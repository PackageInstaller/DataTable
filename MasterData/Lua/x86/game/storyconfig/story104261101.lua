return {
	Play426111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play426111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effectzhengyanzhixian1

				if not arg_1_1.var_.effectzhengyanzhixian1 then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), manager.ui.mainCamera.transform)
					var_4_16.name = "zhengyanzhixian1"
					arg_1_1.var_.effectzhengyanzhixian1 = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9000)
				end

				var_4_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				if arg_1_1.var_.effectzhengyanzhixian1 then
					Object.Destroy(arg_1_1.var_.effectzhengyanzhixian1)

					arg_1_1.var_.effectzhengyanzhixian1 = nil
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.075

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(426111001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 3 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 3)

				if (3 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 3)) > 0 and var_4_20 < var_4_24 then
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
	Play426111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 426111002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play426111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.025

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(426111002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 41 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 41)

				if (41 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 41)) > 0 and var_12_0 < var_12_3 then
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
	Play426111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 426111003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play426111004(arg_13_1)
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

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(426111003).content)

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
	Play426111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 426111004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play426111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.675

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

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(426111004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 27 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 27)

				if (27 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 27)) > 0 and var_20_0 < var_20_3 then
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
	Play426111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 426111005
		arg_21_1.duration_ = 7.3

		local var_21_0 = {
			zh = 5.466,
			ja = 7.3
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
				arg_21_0:Play426111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_9000

			if arg_21_1.bgs_.ST2007 == nil then
				local var_24_0 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007")
				var_24_0.name = "ST2007"
				var_24_0.transform.parent = arg_21_1.stage_.transform
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_.ST2007 = var_24_0
			end

			if 0.966666666666667 < arg_21_1.time_ and arg_21_1.time_ <= 0.966666666666667 + arg_24_0 then
				local var_24_1 = arg_21_1.bgs_.ST2007

				arg_21_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_2 = var_24_1:GetComponent("SpriteRenderer")

				if var_24_2 and var_24_2.sprite then
					local var_24_3 = 2 * (var_24_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_1.transform.localScale = Vector3.New(var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "ST2007" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_4 = 1.999999999999

			if 1.999999999999 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_4 + 0.3 and arg_21_1.time_ < var_24_4 + 0.3 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			local var_24_5 = "6148ui_story"

			if arg_21_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_24_6 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_21_1.stage_.transform)

				var_24_6.name = var_24_5
				var_24_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_[var_24_5] = var_24_6

				local var_24_7 = var_24_6:GetComponentInChildren(typeof(CharacterEffect))

				var_24_7.enabled = true

				local var_24_8 = GameObjectTools.GetOrAddComponent(var_24_6, typeof(DynamicBoneHelper))

				if var_24_8 then
					var_24_8:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_7.transform, false)

				arg_21_1.var_[var_24_5 .. "Animator"] = var_24_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_[var_24_5 .. "Animator"].applyRootMotion = true
				arg_21_1.var_[var_24_5 .. "LipSync"] = var_24_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_9 = arg_21_1.actors_["6148ui_story"].transform

			if 1.999999999999 < arg_21_1.time_ and arg_21_1.time_ <= 1.999999999999 + arg_24_0 then
				arg_21_1.var_.moveOldPos6148ui_story = var_24_9.localPosition

				local var_24_10 = GameObjectTools.GetOrAddComponent(var_24_9.gameObject, typeof(DynamicBoneHelper))

				if var_24_10 then
					var_24_10:EnableDynamicBone(false)
				end
			end

			local var_24_11 = 0.001

			if 1.999999999999 <= arg_21_1.time_ and arg_21_1.time_ < 1.999999999999 + var_24_11 then
				var_24_9.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_21_1.time_ - 1.999999999999) / var_24_11)
				var_24_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_9.position).x, (manager.ui.mainCamera.transform.position - var_24_9.position).y, (manager.ui.mainCamera.transform.position - var_24_9.position).z)
				var_24_9.localEulerAngles.z = 0
				var_24_9.localEulerAngles.x = 0
				var_24_9.localEulerAngles = var_24_9.localEulerAngles
			end

			if arg_21_1.time_ >= 1.999999999999 + var_24_11 and arg_21_1.time_ < 1.999999999999 + var_24_11 + arg_24_0 then
				var_24_9.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_24_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_9.position).x, (manager.ui.mainCamera.transform.position - var_24_9.position).y, (manager.ui.mainCamera.transform.position - var_24_9.position).z)
				var_24_9.localEulerAngles.z = 0
				var_24_9.localEulerAngles.x = 0
				var_24_9.localEulerAngles = var_24_9.localEulerAngles

				local var_24_12 = GameObjectTools.GetOrAddComponent(var_24_9.gameObject, typeof(DynamicBoneHelper))

				if var_24_12 then
					var_24_12:EnableDynamicBone(true)
				end
			end

			local var_24_13 = arg_21_1.actors_["6148ui_story"]

			if 1.999999999999 < arg_21_1.time_ and arg_21_1.time_ <= 1.999999999999 + arg_24_0 and not isNil(var_24_13) and arg_21_1.var_.characterEffect6148ui_story == nil then
				arg_21_1.var_.characterEffect6148ui_story = var_24_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_14 = 0.200000002980232

			if 1.999999999999 <= arg_21_1.time_ and arg_21_1.time_ < 1.999999999999 + var_24_14 and not isNil(var_24_13) then
				if arg_21_1.var_.characterEffect6148ui_story and not isNil(var_24_13) then
					arg_21_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 1.999999999999 + var_24_14 and arg_21_1.time_ < 1.999999999999 + var_24_14 + arg_24_0 and not isNil(var_24_13) and arg_21_1.var_.characterEffect6148ui_story then
				arg_21_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 1.999999999999 < arg_21_1.time_ and arg_21_1.time_ <= 1.999999999999 + arg_24_0 then
				arg_21_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 1.999999999999 < arg_21_1.time_ and arg_21_1.time_ <= 1.999999999999 + arg_24_0 then
				arg_21_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0.200000002980232 < arg_21_1.time_ and arg_21_1.time_ <= 0.200000002980232 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_150", "se_story_150_cut", "")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_17 = arg_21_1.var_.effectzhuanchangzhixian12

				if not arg_21_1.var_.effectzhuanchangzhixian12 then
					var_24_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_24_17.name = "zhuanchangzhixian12"
					arg_21_1.var_.effectzhuanchangzhixian12 = var_24_17
				else
					var_24_17.transform:SetParent(var_24_9000)
				end

				var_24_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_24_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_19 = 2
			local var_24_20 = 0.4

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_21 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_21:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_22 = arg_21_1:GetWordFromCfg(426111005)
				local var_24_23 = arg_21_1:FormatText(var_24_22.content)

				arg_21_1.text_.text = var_24_23

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_25 = 16 <= 0 and var_24_20 or var_24_20 * (utf8.len(var_24_23) / 16)

				if (16 <= 0 and var_24_20 or var_24_20 * (utf8.len(var_24_23) / 16)) > 0 and var_24_20 < var_24_25 then
					arg_21_1.talkMaxDuration = var_24_25
					var_24_19 = var_24_19 + 0.3

					if var_24_25 + var_24_19 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_25 + var_24_19
					end
				end

				arg_21_1.text_.text = var_24_23
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111005", "story_v_out_426111.awb") ~= 0 then
					local var_24_26 = manager.audio:GetVoiceLength("story_v_out_426111", "426111005", "story_v_out_426111.awb") / 1000

					if var_24_26 + var_24_19 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_26 + var_24_19
					end

					if var_24_22.prefab_name ~= "" and arg_21_1.actors_[var_24_22.prefab_name] ~= nil then
						local var_24_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_22.prefab_name].transform, "story_v_out_426111", "426111005", "story_v_out_426111.awb")

						arg_21_1:RecordAudio("426111005", var_24_27)
						arg_21_1:RecordAudio("426111005", var_24_27)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_426111", "426111005", "story_v_out_426111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_426111", "426111005", "story_v_out_426111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_28 = var_24_19 + 0.3
			local var_24_29 = math.max(var_24_20, arg_21_1.talkMaxDuration)

			if var_24_19 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_28 + var_24_29 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_28) / var_24_29

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_28 + var_24_29 and arg_21_1.time_ < var_24_28 + var_24_29 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play426111006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 426111006
		arg_27_1.duration_ = 8

		local var_27_0 = {
			zh = 7.2,
			ja = 8
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
				arg_27_0:Play426111007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "1054ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1054ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["1054ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["1054ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["1054ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1054ui_story = var_30_3.localPosition

				local var_30_4 = GameObjectTools.GetOrAddComponent(var_30_3.gameObject, typeof(DynamicBoneHelper))

				if var_30_4 then
					var_30_4:EnableDynamicBone(false)
				end
			end

			local var_30_5 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_27_1.time_ - 0) / var_30_5)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles

				local var_30_6 = GameObjectTools.GetOrAddComponent(var_30_3.gameObject, typeof(DynamicBoneHelper))

				if var_30_6 then
					var_30_6:EnableDynamicBone(true)
				end
			end

			local var_30_7 = arg_27_1.actors_["1054ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.characterEffect1054ui_story == nil then
				arg_27_1.var_.characterEffect1054ui_story = var_30_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_8 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_8 and not isNil(var_30_7) then
				if arg_27_1.var_.characterEffect1054ui_story and not isNil(var_30_7) then
					arg_27_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_8 and arg_27_1.time_ < 0 + var_30_8 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.characterEffect1054ui_story then
				arg_27_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_30_10 = arg_27_1.actors_["6148ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_10) and arg_27_1.var_.characterEffect6148ui_story == nil then
				arg_27_1.var_.characterEffect6148ui_story = var_30_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_11 and not isNil(var_30_10) then
				if arg_27_1.var_.characterEffect6148ui_story and not isNil(var_30_10) then
					arg_27_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_27_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_11)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_11 and arg_27_1.time_ < 0 + var_30_11 + arg_30_0 and not isNil(var_30_10) and arg_27_1.var_.characterEffect6148ui_story then
				arg_27_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_27_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_30_12 = 0
			local var_30_13 = 0.75

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_14 = arg_27_1:GetWordFromCfg(426111006)
				local var_30_15 = arg_27_1:FormatText(var_30_14.content)

				arg_27_1.text_.text = var_30_15

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_17 = 30 <= 0 and var_30_13 or var_30_13 * (utf8.len(var_30_15) / 30)

				if (30 <= 0 and var_30_13 or var_30_13 * (utf8.len(var_30_15) / 30)) > 0 and var_30_13 < var_30_17 then
					arg_27_1.talkMaxDuration = var_30_17

					if var_30_17 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_17 + var_30_12
					end
				end

				arg_27_1.text_.text = var_30_15
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111006", "story_v_out_426111.awb") ~= 0 then
					local var_30_18 = manager.audio:GetVoiceLength("story_v_out_426111", "426111006", "story_v_out_426111.awb") / 1000

					if var_30_18 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_18 + var_30_12
					end

					if var_30_14.prefab_name ~= "" and arg_27_1.actors_[var_30_14.prefab_name] ~= nil then
						local var_30_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_14.prefab_name].transform, "story_v_out_426111", "426111006", "story_v_out_426111.awb")

						arg_27_1:RecordAudio("426111006", var_30_19)
						arg_27_1:RecordAudio("426111006", var_30_19)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_426111", "426111006", "story_v_out_426111.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_426111", "426111006", "story_v_out_426111.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_20 = math.max(var_30_13, arg_27_1.talkMaxDuration)

			if var_30_12 <= arg_27_1.time_ and arg_27_1.time_ < var_30_12 + var_30_20 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_12) / var_30_20

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_12 + var_30_20 and arg_27_1.time_ < var_30_12 + var_30_20 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play426111007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 426111007
		arg_31_1.duration_ = 9.1

		local var_31_0 = {
			zh = 6.566,
			ja = 9.1
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
				arg_31_0:Play426111008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos6148ui_story = arg_31_1.actors_["6148ui_story"].transform.localPosition

				local var_34_0 = GameObjectTools.GetOrAddComponent(arg_31_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_34_0 then
					var_34_0:EnableDynamicBone(false)
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_31_1.time_ - 0) / var_34_1)
				arg_31_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["6148ui_story"].transform.position).z)
				arg_31_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["6148ui_story"].transform.localEulerAngles = arg_31_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_31_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["6148ui_story"].transform.position).z)
				arg_31_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["6148ui_story"].transform.localEulerAngles = arg_31_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_34_2 = GameObjectTools.GetOrAddComponent(arg_31_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_34_2 then
					var_34_2:EnableDynamicBone(true)
				end
			end

			local var_34_3 = arg_31_1.actors_["6148ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.characterEffect6148ui_story == nil then
				arg_31_1.var_.characterEffect6148ui_story = var_34_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_4 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 and not isNil(var_34_3) then
				if arg_31_1.var_.characterEffect6148ui_story and not isNil(var_34_3) then
					arg_31_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.characterEffect6148ui_story then
				arg_31_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_34_6 = arg_31_1.actors_["1054ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.characterEffect1054ui_story == nil then
				arg_31_1.var_.characterEffect1054ui_story = var_34_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_7 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 and not isNil(var_34_6) then
				if arg_31_1.var_.characterEffect1054ui_story and not isNil(var_34_6) then
					arg_31_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_7)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.characterEffect1054ui_story then
				arg_31_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_34_8 = 0
			local var_34_9 = 0.825

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(426111007)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 33 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 33)

				if (33 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 33)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111007", "story_v_out_426111.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_426111", "426111007", "story_v_out_426111.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_426111", "426111007", "story_v_out_426111.awb")

						arg_31_1:RecordAudio("426111007", var_34_15)
						arg_31_1:RecordAudio("426111007", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_426111", "426111007", "story_v_out_426111.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_426111", "426111007", "story_v_out_426111.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_16 and arg_31_1.time_ < var_34_8 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play426111008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 426111008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play426111009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos6148ui_story = arg_35_1.actors_["6148ui_story"].transform.localPosition

				local var_38_0 = GameObjectTools.GetOrAddComponent(arg_35_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_38_0 then
					var_38_0:EnableDynamicBone(false)
				end
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				arg_35_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_1)
				arg_35_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["6148ui_story"].transform.position).z)
				arg_35_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["6148ui_story"].transform.localEulerAngles = arg_35_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				arg_35_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["6148ui_story"].transform.position).z)
				arg_35_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["6148ui_story"].transform.localEulerAngles = arg_35_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_38_2 = GameObjectTools.GetOrAddComponent(arg_35_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_38_2 then
					var_38_2:EnableDynamicBone(true)
				end
			end

			local var_38_3 = arg_35_1.actors_["1054ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1054ui_story = var_38_3.localPosition

				local var_38_4 = GameObjectTools.GetOrAddComponent(var_38_3.gameObject, typeof(DynamicBoneHelper))

				if var_38_4 then
					var_38_4:EnableDynamicBone(false)
				end
			end

			local var_38_5 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_5 then
				var_38_3.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_5)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_5 and arg_35_1.time_ < 0 + var_38_5 + arg_38_0 then
				var_38_3.localPosition = Vector3.New(0, 100, 0)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles

				local var_38_6 = GameObjectTools.GetOrAddComponent(var_38_3.gameObject, typeof(DynamicBoneHelper))

				if var_38_6 then
					var_38_6:EnableDynamicBone(true)
				end
			end

			local var_38_7 = arg_35_1.actors_["6148ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_7) and arg_35_1.var_.characterEffect6148ui_story == nil then
				arg_35_1.var_.characterEffect6148ui_story = var_38_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_8 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_8 and not isNil(var_38_7) then
				if arg_35_1.var_.characterEffect6148ui_story and not isNil(var_38_7) then
					arg_35_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_35_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_8)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_8 and arg_35_1.time_ < 0 + var_38_8 + arg_38_0 and not isNil(var_38_7) and arg_35_1.var_.characterEffect6148ui_story then
				arg_35_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_35_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0.433333333333333 < arg_35_1.time_ and arg_35_1.time_ <= 0.433333333333333 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_150", "se_story_150_cook", "")
			end

			local var_38_10 = 0
			local var_38_11 = 0.7

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_12 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(426111008).content)

				arg_35_1.text_.text = var_38_12

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_14 = 28 <= 0 and var_38_11 or var_38_11 * (utf8.len(var_38_12) / 28)

				if (28 <= 0 and var_38_11 or var_38_11 * (utf8.len(var_38_12) / 28)) > 0 and var_38_11 < var_38_14 then
					arg_35_1.talkMaxDuration = var_38_14

					if var_38_14 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_10
					end
				end

				arg_35_1.text_.text = var_38_12
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_15 = math.max(var_38_11, arg_35_1.talkMaxDuration)

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_15 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_10) / var_38_15

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_10 + var_38_15 and arg_35_1.time_ < var_38_10 + var_38_15 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_35_1:InitPlayNodeList()
	end,
	Play426111009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 426111009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play426111010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.35

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

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(426111009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 14 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 14)

				if (14 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 14)) > 0 and var_42_0 < var_42_3 then
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
	Play426111010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 426111010
		arg_43_1.duration_ = 9.53

		local var_43_0 = {
			zh = 5.9,
			ja = 9.533
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
				arg_43_0:Play426111011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1054ui_story = arg_43_1.actors_["1054ui_story"].transform.localPosition

				local var_46_0 = GameObjectTools.GetOrAddComponent(arg_43_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_46_0 then
					var_46_0:EnableDynamicBone(false)
				end
			end

			local var_46_1 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 then
				arg_43_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_43_1.time_ - 0) / var_46_1)
				arg_43_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1054ui_story"].transform.position).z)
				arg_43_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1054ui_story"].transform.localEulerAngles = arg_43_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 then
				arg_43_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_43_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1054ui_story"].transform.position).z)
				arg_43_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1054ui_story"].transform.localEulerAngles = arg_43_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_46_2 = GameObjectTools.GetOrAddComponent(arg_43_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(true)
				end
			end

			local var_46_3 = arg_43_1.actors_["1054ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect1054ui_story == nil then
				arg_43_1.var_.characterEffect1054ui_story = var_46_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_4 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 and not isNil(var_46_3) then
				if arg_43_1.var_.characterEffect1054ui_story and not isNil(var_46_3) then
					arg_43_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect1054ui_story then
				arg_43_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_46_6 = "1111ui_story"

			if arg_43_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_46_7 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_43_1.stage_.transform)

				var_46_7.name = var_46_6
				var_46_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_[var_46_6] = var_46_7

				local var_46_8 = var_46_7:GetComponentInChildren(typeof(CharacterEffect))

				var_46_8.enabled = true

				local var_46_9 = GameObjectTools.GetOrAddComponent(var_46_7, typeof(DynamicBoneHelper))

				if var_46_9 then
					var_46_9:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_8.transform, false)

				arg_43_1.var_[var_46_6 .. "Animator"] = var_46_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_[var_46_6 .. "Animator"].applyRootMotion = true
				arg_43_1.var_[var_46_6 .. "LipSync"] = var_46_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_46_10 = 0
			local var_46_11 = 0.5

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_12 = arg_43_1:GetWordFromCfg(426111010)
				local var_46_13 = arg_43_1:FormatText(var_46_12.content)

				arg_43_1.text_.text = var_46_13

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_15 = 20 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_13) / 20)

				if (20 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_13) / 20)) > 0 and var_46_11 < var_46_15 then
					arg_43_1.talkMaxDuration = var_46_15

					if var_46_15 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_10
					end
				end

				arg_43_1.text_.text = var_46_13
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111010", "story_v_out_426111.awb") ~= 0 then
					local var_46_16 = manager.audio:GetVoiceLength("story_v_out_426111", "426111010", "story_v_out_426111.awb") / 1000

					if var_46_16 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_10
					end

					if var_46_12.prefab_name ~= "" and arg_43_1.actors_[var_46_12.prefab_name] ~= nil then
						local var_46_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_12.prefab_name].transform, "story_v_out_426111", "426111010", "story_v_out_426111.awb")

						arg_43_1:RecordAudio("426111010", var_46_17)
						arg_43_1:RecordAudio("426111010", var_46_17)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_426111", "426111010", "story_v_out_426111.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_426111", "426111010", "story_v_out_426111.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_18 = math.max(var_46_11, arg_43_1.talkMaxDuration)

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_18 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_10) / var_46_18

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_10 + var_46_18 and arg_43_1.time_ < var_46_10 + var_46_18 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play426111011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 426111011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play426111012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1054ui_story"]) and arg_47_1.var_.characterEffect1054ui_story == nil then
				arg_47_1.var_.characterEffect1054ui_story = arg_47_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1054ui_story"]) then
				if arg_47_1.var_.characterEffect1054ui_story and not isNil(arg_47_1.actors_["1054ui_story"]) then
					arg_47_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1054ui_story"]) and arg_47_1.var_.characterEffect1054ui_story then
				arg_47_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.525

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
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

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(426111011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 21 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 21)

				if (21 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 21)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play426111012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 426111012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play426111013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1054ui_story = arg_51_1.actors_["1054ui_story"].transform.localPosition

				local var_54_0 = GameObjectTools.GetOrAddComponent(arg_51_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_54_0 then
					var_54_0:EnableDynamicBone(false)
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_1)
				arg_51_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1054ui_story"].transform.position).z)
				arg_51_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1054ui_story"].transform.localEulerAngles = arg_51_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1054ui_story"].transform.position).z)
				arg_51_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1054ui_story"].transform.localEulerAngles = arg_51_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_54_2 = GameObjectTools.GetOrAddComponent(arg_51_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_54_2 then
					var_54_2:EnableDynamicBone(true)
				end
			end

			local var_54_3 = 0
			local var_54_4 = 0.675

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_5 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(426111012).content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 27 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 27)

				if (27 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 27)) > 0 and var_54_4 < var_54_7 then
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
				actorName = "1054ui_story",
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
	Play426111013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 426111013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play426111014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.375

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

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(426111013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 15 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 15)

				if (15 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 15)) > 0 and var_58_0 < var_58_3 then
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
	Play426111014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 426111014
		arg_59_1.duration_ = 4.07

		local var_59_0 = {
			zh = 3.366,
			ja = 4.066
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
				arg_59_0:Play426111015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos6148ui_story = arg_59_1.actors_["6148ui_story"].transform.localPosition

				local var_62_0 = GameObjectTools.GetOrAddComponent(arg_59_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_62_0 then
					var_62_0:EnableDynamicBone(false)
				end
			end

			local var_62_1 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 then
				arg_59_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_59_1.time_ - 0) / var_62_1)
				arg_59_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["6148ui_story"].transform.position).z)
				arg_59_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["6148ui_story"].transform.localEulerAngles = arg_59_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 then
				arg_59_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_59_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["6148ui_story"].transform.position).z)
				arg_59_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["6148ui_story"].transform.localEulerAngles = arg_59_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_62_2 = GameObjectTools.GetOrAddComponent(arg_59_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_62_2 then
					var_62_2:EnableDynamicBone(true)
				end
			end

			local var_62_3 = arg_59_1.actors_["6148ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_3) and arg_59_1.var_.characterEffect6148ui_story == nil then
				arg_59_1.var_.characterEffect6148ui_story = var_62_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_4 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 and not isNil(var_62_3) then
				if arg_59_1.var_.characterEffect6148ui_story and not isNil(var_62_3) then
					arg_59_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 and not isNil(var_62_3) and arg_59_1.var_.characterEffect6148ui_story then
				arg_59_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_62_6 = 0
			local var_62_7 = 0.375

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(426111014)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 15 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 15)

				if (15 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 15)) > 0 and var_62_7 < var_62_11 then
					arg_59_1.talkMaxDuration = var_62_11

					if var_62_11 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111014", "story_v_out_426111.awb") ~= 0 then
					local var_62_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111014", "story_v_out_426111.awb") / 1000

					if var_62_12 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_6
					end

					if var_62_8.prefab_name ~= "" and arg_59_1.actors_[var_62_8.prefab_name] ~= nil then
						local var_62_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_8.prefab_name].transform, "story_v_out_426111", "426111014", "story_v_out_426111.awb")

						arg_59_1:RecordAudio("426111014", var_62_13)
						arg_59_1:RecordAudio("426111014", var_62_13)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_426111", "426111014", "story_v_out_426111.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_426111", "426111014", "story_v_out_426111.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play426111015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 426111015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play426111016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos6148ui_story = arg_63_1.actors_["6148ui_story"].transform.localPosition

				local var_66_0 = GameObjectTools.GetOrAddComponent(arg_63_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_66_0 then
					var_66_0:EnableDynamicBone(false)
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_1)
				arg_63_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["6148ui_story"].transform.position).z)
				arg_63_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["6148ui_story"].transform.localEulerAngles = arg_63_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["6148ui_story"].transform.position).z)
				arg_63_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["6148ui_story"].transform.localEulerAngles = arg_63_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_66_2 = GameObjectTools.GetOrAddComponent(arg_63_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_66_2 then
					var_66_2:EnableDynamicBone(true)
				end
			end

			local var_66_3 = arg_63_1.actors_["6148ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect6148ui_story == nil then
				arg_63_1.var_.characterEffect6148ui_story = var_66_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_4 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 and not isNil(var_66_3) then
				if arg_63_1.var_.characterEffect6148ui_story and not isNil(var_66_3) then
					arg_63_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_63_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_4)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect6148ui_story then
				arg_63_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_63_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0.133333333333333 < arg_63_1.time_ and arg_63_1.time_ <= 0.133333333333333 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_150", "se_story_150_cook_brush", "")
			end

			local var_66_6 = 0
			local var_66_7 = 0.9

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(426111015).content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 36 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_8) / 36)

				if (36 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_8) / 36)) > 0 and var_66_7 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_11 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_11 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_11

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_11 and arg_63_1.time_ < var_66_6 + var_66_11 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play426111016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 426111016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play426111017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.6

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(426111016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 24 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 24)

				if (24 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 24)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play426111017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 426111017
		arg_71_1.duration_ = 11.53

		local var_71_0 = {
			zh = 10.233,
			ja = 11.533
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play426111018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos6148ui_story = arg_71_1.actors_["6148ui_story"].transform.localPosition

				local var_74_0 = GameObjectTools.GetOrAddComponent(arg_71_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_74_0 then
					var_74_0:EnableDynamicBone(false)
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_71_1.time_ - 0) / var_74_1)
				arg_71_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["6148ui_story"].transform.position).z)
				arg_71_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["6148ui_story"].transform.localEulerAngles = arg_71_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_71_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["6148ui_story"].transform.position).z)
				arg_71_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["6148ui_story"].transform.localEulerAngles = arg_71_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_74_2 = GameObjectTools.GetOrAddComponent(arg_71_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_74_2 then
					var_74_2:EnableDynamicBone(true)
				end
			end

			local var_74_3 = arg_71_1.actors_["6148ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect6148ui_story == nil then
				arg_71_1.var_.characterEffect6148ui_story = var_74_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_4 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 and not isNil(var_74_3) then
				if arg_71_1.var_.characterEffect6148ui_story and not isNil(var_74_3) then
					arg_71_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect6148ui_story then
				arg_71_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action486")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_74_6 = 0
			local var_74_7 = 0.775

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(426111017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 31 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 31)

				if (31 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 31)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111017", "story_v_out_426111.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111017", "story_v_out_426111.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_426111", "426111017", "story_v_out_426111.awb")

						arg_71_1:RecordAudio("426111017", var_74_13)
						arg_71_1:RecordAudio("426111017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_426111", "426111017", "story_v_out_426111.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_426111", "426111017", "story_v_out_426111.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play426111018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 426111018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play426111019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["6148ui_story"]) and arg_75_1.var_.characterEffect6148ui_story == nil then
				arg_75_1.var_.characterEffect6148ui_story = arg_75_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["6148ui_story"]) then
				if arg_75_1.var_.characterEffect6148ui_story and not isNil(arg_75_1.actors_["6148ui_story"]) then
					arg_75_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_75_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["6148ui_story"]) and arg_75_1.var_.characterEffect6148ui_story then
				arg_75_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_75_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.85

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(426111018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 34 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 34)

				if (34 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 34)) > 0 and var_78_2 < var_78_5 then
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

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play426111019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 426111019
		arg_79_1.duration_ = 3.9

		local var_79_0 = {
			zh = 2.8,
			ja = 3.9
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play426111020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos6148ui_story = arg_79_1.actors_["6148ui_story"].transform.localPosition

				local var_82_0 = GameObjectTools.GetOrAddComponent(arg_79_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_82_0 then
					var_82_0:EnableDynamicBone(false)
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_79_1.time_ - 0) / var_82_1)
				arg_79_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["6148ui_story"].transform.position).z)
				arg_79_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["6148ui_story"].transform.localEulerAngles = arg_79_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_79_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["6148ui_story"].transform.position).z)
				arg_79_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["6148ui_story"].transform.localEulerAngles = arg_79_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_82_2 = GameObjectTools.GetOrAddComponent(arg_79_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_82_2 then
					var_82_2:EnableDynamicBone(true)
				end
			end

			local var_82_3 = arg_79_1.actors_["6148ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect6148ui_story == nil then
				arg_79_1.var_.characterEffect6148ui_story = var_82_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_4 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 and not isNil(var_82_3) then
				if arg_79_1.var_.characterEffect6148ui_story and not isNil(var_82_3) then
					arg_79_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect6148ui_story then
				arg_79_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action462")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_82_6 = 0
			local var_82_7 = 0.275

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(426111019)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 11 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_9) / 11)

				if (11 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_9) / 11)) > 0 and var_82_7 < var_82_11 then
					arg_79_1.talkMaxDuration = var_82_11

					if var_82_11 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111019", "story_v_out_426111.awb") ~= 0 then
					local var_82_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111019", "story_v_out_426111.awb") / 1000

					if var_82_12 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_6
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_out_426111", "426111019", "story_v_out_426111.awb")

						arg_79_1:RecordAudio("426111019", var_82_13)
						arg_79_1:RecordAudio("426111019", var_82_13)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_426111", "426111019", "story_v_out_426111.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_426111", "426111019", "story_v_out_426111.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_14 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_14 and arg_79_1.time_ < var_82_6 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play426111020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 426111020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play426111021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["6148ui_story"]) and arg_83_1.var_.characterEffect6148ui_story == nil then
				arg_83_1.var_.characterEffect6148ui_story = arg_83_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["6148ui_story"]) then
				if arg_83_1.var_.characterEffect6148ui_story and not isNil(arg_83_1.actors_["6148ui_story"]) then
					arg_83_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_83_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["6148ui_story"]) and arg_83_1.var_.characterEffect6148ui_story then
				arg_83_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_83_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.175

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
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

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(426111020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 7 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 7)

				if (7 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 7)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play426111021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 426111021
		arg_87_1.duration_ = 5.3

		local var_87_0 = {
			zh = 4,
			ja = 5.3
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
				arg_87_0:Play426111022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos6148ui_story = arg_87_1.actors_["6148ui_story"].transform.localPosition

				local var_90_0 = GameObjectTools.GetOrAddComponent(arg_87_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_90_0 then
					var_90_0:EnableDynamicBone(false)
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_87_1.time_ - 0) / var_90_1)
				arg_87_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["6148ui_story"].transform.position).z)
				arg_87_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["6148ui_story"].transform.localEulerAngles = arg_87_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_87_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["6148ui_story"].transform.position).z)
				arg_87_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["6148ui_story"].transform.localEulerAngles = arg_87_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_90_2 = GameObjectTools.GetOrAddComponent(arg_87_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_90_2 then
					var_90_2:EnableDynamicBone(true)
				end
			end

			local var_90_3 = arg_87_1.actors_["6148ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_3) and arg_87_1.var_.characterEffect6148ui_story == nil then
				arg_87_1.var_.characterEffect6148ui_story = var_90_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_4 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 and not isNil(var_90_3) then
				if arg_87_1.var_.characterEffect6148ui_story and not isNil(var_90_3) then
					arg_87_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 and not isNil(var_90_3) and arg_87_1.var_.characterEffect6148ui_story then
				arg_87_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_90_6 = 0
			local var_90_7 = 0.475

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_8 = arg_87_1:GetWordFromCfg(426111021)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_11 = 19 <= 0 and var_90_7 or var_90_7 * (utf8.len(var_90_9) / 19)

				if (19 <= 0 and var_90_7 or var_90_7 * (utf8.len(var_90_9) / 19)) > 0 and var_90_7 < var_90_11 then
					arg_87_1.talkMaxDuration = var_90_11

					if var_90_11 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111021", "story_v_out_426111.awb") ~= 0 then
					local var_90_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111021", "story_v_out_426111.awb") / 1000

					if var_90_12 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_6
					end

					if var_90_8.prefab_name ~= "" and arg_87_1.actors_[var_90_8.prefab_name] ~= nil then
						local var_90_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_8.prefab_name].transform, "story_v_out_426111", "426111021", "story_v_out_426111.awb")

						arg_87_1:RecordAudio("426111021", var_90_13)
						arg_87_1:RecordAudio("426111021", var_90_13)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_426111", "426111021", "story_v_out_426111.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_426111", "426111021", "story_v_out_426111.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_14 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_14

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_14 and arg_87_1.time_ < var_90_6 + var_90_14 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play426111022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 426111022
		arg_91_1.duration_ = 4.93

		local var_91_0 = {
			zh = 3.7,
			ja = 4.933
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play426111023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1054ui_story = arg_91_1.actors_["1054ui_story"].transform.localPosition

				local var_94_0 = GameObjectTools.GetOrAddComponent(arg_91_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_94_0 then
					var_94_0:EnableDynamicBone(false)
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_91_1.time_ - 0) / var_94_1)
				arg_91_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1054ui_story"].transform.position).z)
				arg_91_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1054ui_story"].transform.localEulerAngles = arg_91_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_91_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1054ui_story"].transform.position).z)
				arg_91_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1054ui_story"].transform.localEulerAngles = arg_91_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_94_2 = GameObjectTools.GetOrAddComponent(arg_91_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_94_2 then
					var_94_2:EnableDynamicBone(true)
				end
			end

			local var_94_3 = arg_91_1.actors_["6148ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos6148ui_story = var_94_3.localPosition

				local var_94_4 = GameObjectTools.GetOrAddComponent(var_94_3.gameObject, typeof(DynamicBoneHelper))

				if var_94_4 then
					var_94_4:EnableDynamicBone(false)
				end
			end

			local var_94_5 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 then
				var_94_3.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_91_1.time_ - 0) / var_94_5)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 then
				var_94_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles

				local var_94_6 = GameObjectTools.GetOrAddComponent(var_94_3.gameObject, typeof(DynamicBoneHelper))

				if var_94_6 then
					var_94_6:EnableDynamicBone(true)
				end
			end

			local var_94_7 = arg_91_1.actors_["1054ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.characterEffect1054ui_story == nil then
				arg_91_1.var_.characterEffect1054ui_story = var_94_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_8 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_8 and not isNil(var_94_7) then
				if arg_91_1.var_.characterEffect1054ui_story and not isNil(var_94_7) then
					arg_91_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_8 and arg_91_1.time_ < 0 + var_94_8 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.characterEffect1054ui_story then
				arg_91_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_94_10 = arg_91_1.actors_["6148ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_10) and arg_91_1.var_.characterEffect6148ui_story == nil then
				arg_91_1.var_.characterEffect6148ui_story = var_94_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_11 and not isNil(var_94_10) then
				if arg_91_1.var_.characterEffect6148ui_story and not isNil(var_94_10) then
					arg_91_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_91_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_11)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_11 and arg_91_1.time_ < 0 + var_94_11 + arg_94_0 and not isNil(var_94_10) and arg_91_1.var_.characterEffect6148ui_story then
				arg_91_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_91_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_94_12 = 0
			local var_94_13 = 0.3

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_14 = arg_91_1:GetWordFromCfg(426111022)
				local var_94_15 = arg_91_1:FormatText(var_94_14.content)

				arg_91_1.text_.text = var_94_15

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_17 = 12 <= 0 and var_94_13 or var_94_13 * (utf8.len(var_94_15) / 12)

				if (12 <= 0 and var_94_13 or var_94_13 * (utf8.len(var_94_15) / 12)) > 0 and var_94_13 < var_94_17 then
					arg_91_1.talkMaxDuration = var_94_17

					if var_94_17 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_17 + var_94_12
					end
				end

				arg_91_1.text_.text = var_94_15
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111022", "story_v_out_426111.awb") ~= 0 then
					local var_94_18 = manager.audio:GetVoiceLength("story_v_out_426111", "426111022", "story_v_out_426111.awb") / 1000

					if var_94_18 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_18 + var_94_12
					end

					if var_94_14.prefab_name ~= "" and arg_91_1.actors_[var_94_14.prefab_name] ~= nil then
						local var_94_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_14.prefab_name].transform, "story_v_out_426111", "426111022", "story_v_out_426111.awb")

						arg_91_1:RecordAudio("426111022", var_94_19)
						arg_91_1:RecordAudio("426111022", var_94_19)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_426111", "426111022", "story_v_out_426111.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_426111", "426111022", "story_v_out_426111.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_20 = math.max(var_94_13, arg_91_1.talkMaxDuration)

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_20 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_12) / var_94_20

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_12 + var_94_20 and arg_91_1.time_ < var_94_12 + var_94_20 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
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
	Play426111023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 426111023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play426111024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1054ui_story"]) and arg_95_1.var_.characterEffect1054ui_story == nil then
				arg_95_1.var_.characterEffect1054ui_story = arg_95_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1054ui_story"]) then
				if arg_95_1.var_.characterEffect1054ui_story and not isNil(arg_95_1.actors_["1054ui_story"]) then
					arg_95_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1054ui_story"]) and arg_95_1.var_.characterEffect1054ui_story then
				arg_95_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.225

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(426111023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 9 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 9)

				if (9 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 9)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play426111024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 426111024
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play426111025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1054ui_story = arg_99_1.actors_["1054ui_story"].transform.localPosition

				local var_102_0 = GameObjectTools.GetOrAddComponent(arg_99_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_102_0 then
					var_102_0:EnableDynamicBone(false)
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_99_1.time_ - 0) / var_102_1)
				arg_99_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1054ui_story"].transform.position).z)
				arg_99_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1054ui_story"].transform.localEulerAngles = arg_99_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_99_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1054ui_story"].transform.position).z)
				arg_99_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1054ui_story"].transform.localEulerAngles = arg_99_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_102_2 = GameObjectTools.GetOrAddComponent(arg_99_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(true)
				end
			end

			local var_102_3 = arg_99_1.actors_["1054ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_3) and arg_99_1.var_.characterEffect1054ui_story == nil then
				arg_99_1.var_.characterEffect1054ui_story = var_102_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_4 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 and not isNil(var_102_3) then
				if arg_99_1.var_.characterEffect1054ui_story and not isNil(var_102_3) then
					arg_99_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 and not isNil(var_102_3) and arg_99_1.var_.characterEffect1054ui_story then
				arg_99_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_102_6 = 0
			local var_102_7 = 0.15

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(426111024)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 6 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 6)

				if (6 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 6)) > 0 and var_102_7 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111024", "story_v_out_426111.awb") ~= 0 then
					local var_102_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111024", "story_v_out_426111.awb") / 1000

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_426111", "426111024", "story_v_out_426111.awb")

						arg_99_1:RecordAudio("426111024", var_102_13)
						arg_99_1:RecordAudio("426111024", var_102_13)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_426111", "426111024", "story_v_out_426111.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_426111", "426111024", "story_v_out_426111.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play426111025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 426111025
		arg_103_1.duration_ = 6.4

		local var_103_0 = {
			zh = 6.4,
			ja = 5.533
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play426111026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos6148ui_story = arg_103_1.actors_["6148ui_story"].transform.localPosition

				local var_106_0 = GameObjectTools.GetOrAddComponent(arg_103_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_106_0 then
					var_106_0:EnableDynamicBone(false)
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_103_1.time_ - 0) / var_106_1)
				arg_103_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["6148ui_story"].transform.position).z)
				arg_103_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["6148ui_story"].transform.localEulerAngles = arg_103_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_103_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["6148ui_story"].transform.position).z)
				arg_103_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["6148ui_story"].transform.localEulerAngles = arg_103_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_106_2 = GameObjectTools.GetOrAddComponent(arg_103_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_106_2 then
					var_106_2:EnableDynamicBone(true)
				end
			end

			local var_106_3 = arg_103_1.actors_["6148ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect6148ui_story == nil then
				arg_103_1.var_.characterEffect6148ui_story = var_106_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_4 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 and not isNil(var_106_3) then
				if arg_103_1.var_.characterEffect6148ui_story and not isNil(var_106_3) then
					arg_103_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect6148ui_story then
				arg_103_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_106_6 = arg_103_1.actors_["1054ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect1054ui_story == nil then
				arg_103_1.var_.characterEffect1054ui_story = var_106_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_7 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 and not isNil(var_106_6) then
				if arg_103_1.var_.characterEffect1054ui_story and not isNil(var_106_6) then
					arg_103_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_7)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect1054ui_story then
				arg_103_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_106_8 = 0
			local var_106_9 = 0.7

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(426111025)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 28 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 28)

				if (28 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 28)) > 0 and var_106_9 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111025", "story_v_out_426111.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_426111", "426111025", "story_v_out_426111.awb") / 1000

					if var_106_14 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_8
					end

					if var_106_10.prefab_name ~= "" and arg_103_1.actors_[var_106_10.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_10.prefab_name].transform, "story_v_out_426111", "426111025", "story_v_out_426111.awb")

						arg_103_1:RecordAudio("426111025", var_106_15)
						arg_103_1:RecordAudio("426111025", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_426111", "426111025", "story_v_out_426111.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_426111", "426111025", "story_v_out_426111.awb")
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
				actorName = "6148ui_story",
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
	Play426111026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 426111026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play426111027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["6148ui_story"]) and arg_107_1.var_.characterEffect6148ui_story == nil then
				arg_107_1.var_.characterEffect6148ui_story = arg_107_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["6148ui_story"]) then
				if arg_107_1.var_.characterEffect6148ui_story and not isNil(arg_107_1.actors_["6148ui_story"]) then
					arg_107_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_107_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["6148ui_story"]) and arg_107_1.var_.characterEffect6148ui_story then
				arg_107_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_107_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.55

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(426111026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 22 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 22)

				if (22 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 22)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play426111027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 426111027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play426111028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos6148ui_story = arg_111_1.actors_["6148ui_story"].transform.localPosition

				local var_114_0 = GameObjectTools.GetOrAddComponent(arg_111_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_114_0 then
					var_114_0:EnableDynamicBone(false)
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_1)
				arg_111_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).z)
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles = arg_111_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).z)
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles = arg_111_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_114_2 = GameObjectTools.GetOrAddComponent(arg_111_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(true)
				end
			end

			local var_114_3 = arg_111_1.actors_["1054ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1054ui_story = var_114_3.localPosition

				local var_114_4 = GameObjectTools.GetOrAddComponent(var_114_3.gameObject, typeof(DynamicBoneHelper))

				if var_114_4 then
					var_114_4:EnableDynamicBone(false)
				end
			end

			local var_114_5 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_5 then
				var_114_3.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_5)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_5 and arg_111_1.time_ < 0 + var_114_5 + arg_114_0 then
				var_114_3.localPosition = Vector3.New(0, 100, 0)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles

				local var_114_6 = GameObjectTools.GetOrAddComponent(var_114_3.gameObject, typeof(DynamicBoneHelper))

				if var_114_6 then
					var_114_6:EnableDynamicBone(true)
				end
			end

			local var_114_7 = 0
			local var_114_8 = 0.5

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(426111027).content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 20 <= 0 and var_114_8 or var_114_8 * (utf8.len(var_114_9) / 20)

				if (20 <= 0 and var_114_8 or var_114_8 * (utf8.len(var_114_9) / 20)) > 0 and var_114_8 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_7 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_7
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_8, arg_111_1.talkMaxDuration)

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_7) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_7 + var_114_12 and arg_111_1.time_ < var_114_7 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_111_1:InitPlayNodeList()
	end,
	Play426111028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 426111028
		arg_115_1.duration_ = 4.6

		local var_115_0 = {
			zh = 4.233,
			ja = 4.6
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play426111029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos6148ui_story = arg_115_1.actors_["6148ui_story"].transform.localPosition

				local var_118_0 = GameObjectTools.GetOrAddComponent(arg_115_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_118_0 then
					var_118_0:EnableDynamicBone(false)
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_115_1.time_ - 0) / var_118_1)
				arg_115_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["6148ui_story"].transform.position).z)
				arg_115_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["6148ui_story"].transform.localEulerAngles = arg_115_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_115_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["6148ui_story"].transform.position).z)
				arg_115_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["6148ui_story"].transform.localEulerAngles = arg_115_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_118_2 = GameObjectTools.GetOrAddComponent(arg_115_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(true)
				end
			end

			local var_118_3 = arg_115_1.actors_["6148ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect6148ui_story == nil then
				arg_115_1.var_.characterEffect6148ui_story = var_118_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_4 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 and not isNil(var_118_3) then
				if arg_115_1.var_.characterEffect6148ui_story and not isNil(var_118_3) then
					arg_115_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect6148ui_story then
				arg_115_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_118_6 = 0
			local var_118_7 = 0.375

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(426111028)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 15 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 15)

				if (15 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 15)) > 0 and var_118_7 < var_118_11 then
					arg_115_1.talkMaxDuration = var_118_11

					if var_118_11 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111028", "story_v_out_426111.awb") ~= 0 then
					local var_118_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111028", "story_v_out_426111.awb") / 1000

					if var_118_12 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_6
					end

					if var_118_8.prefab_name ~= "" and arg_115_1.actors_[var_118_8.prefab_name] ~= nil then
						local var_118_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_8.prefab_name].transform, "story_v_out_426111", "426111028", "story_v_out_426111.awb")

						arg_115_1:RecordAudio("426111028", var_118_13)
						arg_115_1:RecordAudio("426111028", var_118_13)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_426111", "426111028", "story_v_out_426111.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_426111", "426111028", "story_v_out_426111.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play426111029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 426111029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play426111030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["6148ui_story"]) and arg_119_1.var_.characterEffect6148ui_story == nil then
				arg_119_1.var_.characterEffect6148ui_story = arg_119_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["6148ui_story"]) then
				if arg_119_1.var_.characterEffect6148ui_story and not isNil(arg_119_1.actors_["6148ui_story"]) then
					arg_119_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_119_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["6148ui_story"]) and arg_119_1.var_.characterEffect6148ui_story then
				arg_119_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_119_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.475

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
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

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(426111029).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 19 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 19)

				if (19 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 19)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play426111030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 426111030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play426111031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.55

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(426111030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 22 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 22)

				if (22 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 22)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play426111031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 426111031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play426111032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos6148ui_story = arg_127_1.actors_["6148ui_story"].transform.localPosition

				local var_130_0 = GameObjectTools.GetOrAddComponent(arg_127_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_130_0 then
					var_130_0:EnableDynamicBone(false)
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_1)
				arg_127_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).z)
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles = arg_127_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).z)
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles = arg_127_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_130_2 = GameObjectTools.GetOrAddComponent(arg_127_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(true)
				end
			end

			local var_130_3 = arg_127_1.actors_["1054ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1054ui_story = var_130_3.localPosition

				local var_130_4 = GameObjectTools.GetOrAddComponent(var_130_3.gameObject, typeof(DynamicBoneHelper))

				if var_130_4 then
					var_130_4:EnableDynamicBone(false)
				end
			end

			local var_130_5 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 then
				var_130_3.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_5)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 then
				var_130_3.localPosition = Vector3.New(0, 100, 0)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles

				local var_130_6 = GameObjectTools.GetOrAddComponent(var_130_3.gameObject, typeof(DynamicBoneHelper))

				if var_130_6 then
					var_130_6:EnableDynamicBone(true)
				end
			end

			local var_130_7 = 0
			local var_130_8 = 0.65

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_9 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(426111031).content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 26 <= 0 and var_130_8 or var_130_8 * (utf8.len(var_130_9) / 26)

				if (26 <= 0 and var_130_8 or var_130_8 * (utf8.len(var_130_9) / 26)) > 0 and var_130_8 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_7 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_7
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_8, arg_127_1.talkMaxDuration)

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_7) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_7 + var_130_12 and arg_127_1.time_ < var_130_7 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_127_1:InitPlayNodeList()
	end,
	Play426111032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 426111032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play426111033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0.4 < arg_131_1.time_ and arg_131_1.time_ <= 0.4 + arg_134_0 then
				arg_131_1:AudioAction("play", "effect", "se_story_150", "se_story_150_cook_sizzle_first", "")
			end

			local var_134_1 = 0
			local var_134_2 = 0.75

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(426111032).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 30 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 30)

				if (30 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 30)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play426111033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 426111033
		arg_135_1.duration_ = 6.5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play426111034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_9000

			if arg_135_1.bgs_.J27g == nil then
				local var_138_0 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27g")
				var_138_0.name = "J27g"
				var_138_0.transform.parent = arg_135_1.stage_.transform
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_.J27g = var_138_0
			end

			if 0.75 < arg_135_1.time_ and arg_135_1.time_ <= 0.75 + arg_138_0 then
				local var_138_1 = arg_135_1.bgs_.J27g

				arg_135_1.bgs_.J27g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_138_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_2 = var_138_1:GetComponent("SpriteRenderer")

				if var_138_2 and var_138_2.sprite then
					local var_138_3 = 2 * (var_138_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_138_1.transform.localScale = Vector3.New(var_138_3 / var_138_2.sprite.bounds.size.y < var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x and var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x or var_138_3 / var_138_2.sprite.bounds.size.y, var_138_3 / var_138_2.sprite.bounds.size.y < var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x and var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x or var_138_3 / var_138_2.sprite.bounds.size.y, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "J27g" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_4 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_4 + 0.3 and arg_135_1.time_ < var_138_4 + 0.3 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				local var_138_5 = arg_135_1.var_.effectzhuanchang1

				if not arg_135_1.var_.effectzhuanchang1 then
					var_138_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_138_5.name = "zhuanchang1"
					arg_135_1.var_.effectzhuanchang1 = var_138_5
				else
					var_138_5.transform:SetParent(var_138_9000)
				end

				var_138_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_138_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_138_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_135_1.bgmTxt_.text ~= var_138_9 and arg_135_1.bgmTxt_.text ~= "" then
						if arg_135_1.bgmTxt2_.text ~= "" then
							arg_135_1.bgmTxt_.text = arg_135_1.bgmTxt2_.text
						end

						arg_135_1.bgmTxt2_.text = var_138_9

						arg_135_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_135_1.bgmTxt_.text = var_138_9
						arg_135_1.bgmTxt2_.text = var_138_9
					end

					if arg_135_1.bgmTimer then
						arg_135_1.bgmTimer:Stop()

						arg_135_1.bgmTimer = nil
					end

					if arg_135_1.settingData.show_music_name == 1 then
						arg_135_1.musicController:SetSelectedState("show")
						arg_135_1.musicAnimator_:Play("open", 0, 0)

						if arg_135_1.settingData.music_time ~= 0 then
							arg_135_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_135_1.settingData.music_time), function()
								if arg_135_1 == nil or isNil(arg_135_1.bgmTxt_) then
									return
								end

								arg_135_1.musicController:SetSelectedState("hide")
								arg_135_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_135_1.time_ and arg_135_1.time_ <= 0.433333333333333 + arg_138_0 then
				arg_135_1:AudioAction("play", "music", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian.awb")

				local var_138_12 = manager.audio:GetAudioName("bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian")

				if "" ~= "" then
					if arg_135_1.bgmTxt_.text ~= var_138_12 and arg_135_1.bgmTxt_.text ~= "" then
						if arg_135_1.bgmTxt2_.text ~= "" then
							arg_135_1.bgmTxt_.text = arg_135_1.bgmTxt2_.text
						end

						arg_135_1.bgmTxt2_.text = var_138_12

						arg_135_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_135_1.bgmTxt_.text = var_138_12
						arg_135_1.bgmTxt2_.text = var_138_12
					end

					if arg_135_1.bgmTimer then
						arg_135_1.bgmTimer:Stop()

						arg_135_1.bgmTimer = nil
					end

					if arg_135_1.settingData.show_music_name == 1 then
						arg_135_1.musicController:SetSelectedState("show")
						arg_135_1.musicAnimator_:Play("open", 0, 0)

						if arg_135_1.settingData.music_time ~= 0 then
							arg_135_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_135_1.settingData.music_time), function()
								if arg_135_1 == nil or isNil(arg_135_1.bgmTxt_) then
									return
								end

								arg_135_1.musicController:SetSelectedState("hide")
								arg_135_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_135_1.time_ and arg_135_1.time_ <= 0.6 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_150", "se_story_150_flower_field", "")
			end

			if 0.133333333333333 < arg_135_1.time_ and arg_135_1.time_ <= 0.133333333333333 + arg_138_0 then
				arg_135_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_15 = 1.5
			local var_138_16 = 1.25

			if 1.5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_17 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_17:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_135_1.dialogCg_.alpha = arg_141_0
				end))
				var_138_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_18 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(426111033).content)

				arg_135_1.text_.text = var_138_18

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 50 <= 0 and var_138_16 or var_138_16 * (utf8.len(var_138_18) / 50)

				if (50 <= 0 and var_138_16 or var_138_16 * (utf8.len(var_138_18) / 50)) > 0 and var_138_16 < var_138_20 then
					arg_135_1.talkMaxDuration = var_138_20
					var_138_15 = var_138_15 + 0.3

					if var_138_20 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_18
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_21 = var_138_15 + 0.3
			local var_138_22 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_21 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_21) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_21 + var_138_22 and arg_135_1.time_ < var_138_21 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play426111034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 426111034
		arg_143_1.duration_ = 6.67

		local var_143_0 = {
			zh = 6.666,
			ja = 4.233
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
				arg_143_0:Play426111035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1054ui_story = arg_143_1.actors_["1054ui_story"].transform.localPosition

				local var_146_0 = GameObjectTools.GetOrAddComponent(arg_143_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_146_0 then
					var_146_0:EnableDynamicBone(false)
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_143_1.time_ - 0) / var_146_1)
				arg_143_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1054ui_story"].transform.position).z)
				arg_143_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1054ui_story"].transform.localEulerAngles = arg_143_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_143_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1054ui_story"].transform.position).z)
				arg_143_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1054ui_story"].transform.localEulerAngles = arg_143_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_146_2 = GameObjectTools.GetOrAddComponent(arg_143_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_146_2 then
					var_146_2:EnableDynamicBone(true)
				end
			end

			local var_146_3 = arg_143_1.actors_["1054ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_3) and arg_143_1.var_.characterEffect1054ui_story == nil then
				arg_143_1.var_.characterEffect1054ui_story = var_146_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_4 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 and not isNil(var_146_3) then
				if arg_143_1.var_.characterEffect1054ui_story and not isNil(var_146_3) then
					arg_143_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 and not isNil(var_146_3) and arg_143_1.var_.characterEffect1054ui_story then
				arg_143_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_146_6 = 0
			local var_146_7 = 0.325

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(426111034)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 13 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 13)

				if (13 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 13)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111034", "story_v_out_426111.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111034", "story_v_out_426111.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_out_426111", "426111034", "story_v_out_426111.awb")

						arg_143_1:RecordAudio("426111034", var_146_13)
						arg_143_1:RecordAudio("426111034", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_426111", "426111034", "story_v_out_426111.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_426111", "426111034", "story_v_out_426111.awb")
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
				actorName = "1054ui_story",
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
	Play426111035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 426111035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play426111036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1054ui_story = arg_147_1.actors_["1054ui_story"].transform.localPosition

				local var_150_0 = GameObjectTools.GetOrAddComponent(arg_147_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_150_0 then
					var_150_0:EnableDynamicBone(false)
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_1)
				arg_147_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1054ui_story"].transform.position).z)
				arg_147_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1054ui_story"].transform.localEulerAngles = arg_147_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1054ui_story"].transform.position).z)
				arg_147_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1054ui_story"].transform.localEulerAngles = arg_147_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_150_2 = GameObjectTools.GetOrAddComponent(arg_147_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(true)
				end
			end

			local var_150_3 = arg_147_1.actors_["1054ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_3) and arg_147_1.var_.characterEffect1054ui_story == nil then
				arg_147_1.var_.characterEffect1054ui_story = var_150_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_4 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 and not isNil(var_150_3) then
				if arg_147_1.var_.characterEffect1054ui_story and not isNil(var_150_3) then
					arg_147_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_4)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 and not isNil(var_150_3) and arg_147_1.var_.characterEffect1054ui_story then
				arg_147_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_150_5 = 0
			local var_150_6 = 0.675

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(426111035).content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 27 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_7) / 27)

				if (27 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_7) / 27)) > 0 and var_150_6 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_6, arg_147_1.talkMaxDuration)

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_5) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_5 + var_150_10 and arg_147_1.time_ < var_150_5 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play426111036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426111036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426111037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.75

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(426111036).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 30 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 30)

				if (30 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 30)) > 0 and var_154_0 < var_154_3 then
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
	Play426111037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 426111037
		arg_155_1.duration_ = 4.47

		local var_155_0 = {
			zh = 2.5,
			ja = 4.466
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
				arg_155_0:Play426111038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1054ui_story = arg_155_1.actors_["1054ui_story"].transform.localPosition

				local var_158_0 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_0 then
					var_158_0:EnableDynamicBone(false)
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_155_1.time_ - 0) / var_158_1)
				arg_155_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).z)
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles = arg_155_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_155_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).z)
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles = arg_155_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_158_2 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(true)
				end
			end

			local var_158_3 = arg_155_1.actors_["1054ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect1054ui_story == nil then
				arg_155_1.var_.characterEffect1054ui_story = var_158_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_4 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 and not isNil(var_158_3) then
				if arg_155_1.var_.characterEffect1054ui_story and not isNil(var_158_3) then
					arg_155_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect1054ui_story then
				arg_155_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_6 = 0
			local var_158_7 = 0.275

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(426111037)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 11 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 11)

				if (11 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 11)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111037", "story_v_out_426111.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111037", "story_v_out_426111.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_426111", "426111037", "story_v_out_426111.awb")

						arg_155_1:RecordAudio("426111037", var_158_13)
						arg_155_1:RecordAudio("426111037", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_426111", "426111037", "story_v_out_426111.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_426111", "426111037", "story_v_out_426111.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play426111038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426111038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426111039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1054ui_story"]) and arg_159_1.var_.characterEffect1054ui_story == nil then
				arg_159_1.var_.characterEffect1054ui_story = arg_159_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1054ui_story"]) then
				if arg_159_1.var_.characterEffect1054ui_story and not isNil(arg_159_1.actors_["1054ui_story"]) then
					arg_159_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1054ui_story"]) and arg_159_1.var_.characterEffect1054ui_story then
				arg_159_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.125

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
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

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(426111038).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 5 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 5)

				if (5 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 5)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play426111039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426111039
		arg_163_1.duration_ = 6.93

		local var_163_0 = {
			zh = 4.333,
			ja = 6.933
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
				arg_163_0:Play426111040(arg_163_1)
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
				arg_163_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_166_6 = 0
			local var_166_7 = 0.4

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

				local var_166_8 = arg_163_1:GetWordFromCfg(426111039)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 16 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 16)

				if (16 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 16)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111039", "story_v_out_426111.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111039", "story_v_out_426111.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_426111", "426111039", "story_v_out_426111.awb")

						arg_163_1:RecordAudio("426111039", var_166_13)
						arg_163_1:RecordAudio("426111039", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_426111", "426111039", "story_v_out_426111.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_426111", "426111039", "story_v_out_426111.awb")
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
	Play426111040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426111040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play426111041(arg_167_1)
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
			local var_170_2 = 0.525

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

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(426111040).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 21 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 21)

				if (21 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 21)) > 0 and var_170_2 < var_170_5 then
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
	Play426111041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426111041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play426111042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.5

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(426111041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 20 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 20)

				if (20 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 20)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play426111042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 426111042
		arg_175_1.duration_ = 13.03

		local var_175_0 = {
			zh = 9.966,
			ja = 13.033
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
				arg_175_0:Play426111043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1054ui_story = arg_175_1.actors_["1054ui_story"].transform.localPosition

				local var_178_0 = GameObjectTools.GetOrAddComponent(arg_175_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_178_0 then
					var_178_0:EnableDynamicBone(false)
				end
			end

			local var_178_1 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 then
				arg_175_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_175_1.time_ - 0) / var_178_1)
				arg_175_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1054ui_story"].transform.position).z)
				arg_175_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1054ui_story"].transform.localEulerAngles = arg_175_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 then
				arg_175_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_175_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1054ui_story"].transform.position).z)
				arg_175_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1054ui_story"].transform.localEulerAngles = arg_175_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_178_2 = GameObjectTools.GetOrAddComponent(arg_175_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_178_2 then
					var_178_2:EnableDynamicBone(true)
				end
			end

			local var_178_3 = arg_175_1.actors_["1054ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_3) and arg_175_1.var_.characterEffect1054ui_story == nil then
				arg_175_1.var_.characterEffect1054ui_story = var_178_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_4 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 and not isNil(var_178_3) then
				if arg_175_1.var_.characterEffect1054ui_story and not isNil(var_178_3) then
					arg_175_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 and not isNil(var_178_3) and arg_175_1.var_.characterEffect1054ui_story then
				arg_175_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action434")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_6 = 0
			local var_178_7 = 0.85

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:GetWordFromCfg(426111042)
				local var_178_9 = arg_175_1:FormatText(var_178_8.content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 34 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 34)

				if (34 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 34)) > 0 and var_178_7 < var_178_11 then
					arg_175_1.talkMaxDuration = var_178_11

					if var_178_11 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111042", "story_v_out_426111.awb") ~= 0 then
					local var_178_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111042", "story_v_out_426111.awb") / 1000

					if var_178_12 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_6
					end

					if var_178_8.prefab_name ~= "" and arg_175_1.actors_[var_178_8.prefab_name] ~= nil then
						local var_178_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_8.prefab_name].transform, "story_v_out_426111", "426111042", "story_v_out_426111.awb")

						arg_175_1:RecordAudio("426111042", var_178_13)
						arg_175_1:RecordAudio("426111042", var_178_13)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_426111", "426111042", "story_v_out_426111.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_426111", "426111042", "story_v_out_426111.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play426111043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 426111043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play426111044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1054ui_story = arg_179_1.actors_["1054ui_story"].transform.localPosition

				local var_182_0 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_0 then
					var_182_0:EnableDynamicBone(false)
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_1)
				arg_179_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).z)
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles = arg_179_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).z)
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles = arg_179_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_182_2 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(true)
				end
			end

			local var_182_3 = arg_179_1.actors_["1054ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect1054ui_story == nil then
				arg_179_1.var_.characterEffect1054ui_story = var_182_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_4 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 and not isNil(var_182_3) then
				if arg_179_1.var_.characterEffect1054ui_story and not isNil(var_182_3) then
					arg_179_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_4)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect1054ui_story then
				arg_179_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_182_5 = 0
			local var_182_6 = 0.875

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

				local var_182_7 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(426111043).content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 35 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_7) / 35)

				if (35 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_7) / 35)) > 0 and var_182_6 < var_182_9 then
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
				actorName = "1054ui_story",
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
	Play426111044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 426111044
		arg_183_1.duration_ = 6.13

		local var_183_0 = {
			zh = 4.6,
			ja = 6.133
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
				arg_183_0:Play426111045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos6148ui_story = arg_183_1.actors_["6148ui_story"].transform.localPosition

				local var_186_0 = GameObjectTools.GetOrAddComponent(arg_183_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_186_0 then
					var_186_0:EnableDynamicBone(false)
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_183_1.time_ - 0) / var_186_1)
				arg_183_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).z)
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles = arg_183_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_183_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).z)
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles = arg_183_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_186_2 = GameObjectTools.GetOrAddComponent(arg_183_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(true)
				end
			end

			local var_186_3 = arg_183_1.actors_["6148ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_3) and arg_183_1.var_.characterEffect6148ui_story == nil then
				arg_183_1.var_.characterEffect6148ui_story = var_186_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_4 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 and not isNil(var_186_3) then
				if arg_183_1.var_.characterEffect6148ui_story and not isNil(var_186_3) then
					arg_183_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 and not isNil(var_186_3) and arg_183_1.var_.characterEffect6148ui_story then
				arg_183_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_186_6 = 0
			local var_186_7 = 0.6

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(426111044)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 24 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 24)

				if (24 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 24)) > 0 and var_186_7 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111044", "story_v_out_426111.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111044", "story_v_out_426111.awb") / 1000

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end

					if var_186_8.prefab_name ~= "" and arg_183_1.actors_[var_186_8.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_8.prefab_name].transform, "story_v_out_426111", "426111044", "story_v_out_426111.awb")

						arg_183_1:RecordAudio("426111044", var_186_13)
						arg_183_1:RecordAudio("426111044", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_426111", "426111044", "story_v_out_426111.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_426111", "426111044", "story_v_out_426111.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play426111045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 426111045
		arg_187_1.duration_ = 2.23

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play426111046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1054ui_story = arg_187_1.actors_["1054ui_story"].transform.localPosition

				local var_190_0 = GameObjectTools.GetOrAddComponent(arg_187_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_190_0 then
					var_190_0:EnableDynamicBone(false)
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_187_1.time_ - 0) / var_190_1)
				arg_187_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1054ui_story"].transform.position).z)
				arg_187_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1054ui_story"].transform.localEulerAngles = arg_187_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_187_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1054ui_story"].transform.position).z)
				arg_187_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1054ui_story"].transform.localEulerAngles = arg_187_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_190_2 = GameObjectTools.GetOrAddComponent(arg_187_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_190_2 then
					var_190_2:EnableDynamicBone(true)
				end
			end

			local var_190_3 = arg_187_1.actors_["1054ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_3) and arg_187_1.var_.characterEffect1054ui_story == nil then
				arg_187_1.var_.characterEffect1054ui_story = var_190_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_4 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 and not isNil(var_190_3) then
				if arg_187_1.var_.characterEffect1054ui_story and not isNil(var_190_3) then
					arg_187_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 and not isNil(var_190_3) and arg_187_1.var_.characterEffect1054ui_story then
				arg_187_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_190_6 = arg_187_1.actors_["6148ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect6148ui_story == nil then
				arg_187_1.var_.characterEffect6148ui_story = var_190_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_7 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 and not isNil(var_190_6) then
				if arg_187_1.var_.characterEffect6148ui_story and not isNil(var_190_6) then
					arg_187_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_187_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_7)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect6148ui_story then
				arg_187_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_187_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_190_8 = 0
			local var_190_9 = 0.225

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(426111045)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 9 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 9)

				if (9 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 9)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111045", "story_v_out_426111.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_426111", "426111045", "story_v_out_426111.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_426111", "426111045", "story_v_out_426111.awb")

						arg_187_1:RecordAudio("426111045", var_190_15)
						arg_187_1:RecordAudio("426111045", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_426111", "426111045", "story_v_out_426111.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_426111", "426111045", "story_v_out_426111.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play426111046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 426111046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play426111047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1054ui_story"]) and arg_191_1.var_.characterEffect1054ui_story == nil then
				arg_191_1.var_.characterEffect1054ui_story = arg_191_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1054ui_story"]) then
				if arg_191_1.var_.characterEffect1054ui_story and not isNil(arg_191_1.actors_["1054ui_story"]) then
					arg_191_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1054ui_story"]) and arg_191_1.var_.characterEffect1054ui_story then
				arg_191_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_194_1 = 0
			local var_194_2 = 0.375

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

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(426111046).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 15 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 15)

				if (15 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 15)) > 0 and var_194_2 < var_194_5 then
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
	Play426111047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 426111047
		arg_195_1.duration_ = 7.03

		local var_195_0 = {
			zh = 5.866,
			ja = 7.033
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
				arg_195_0:Play426111048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1054ui_story = arg_195_1.actors_["1054ui_story"].transform.localPosition

				local var_198_0 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_198_0 then
					var_198_0:EnableDynamicBone(false)
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_195_1.time_ - 0) / var_198_1)
				arg_195_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1054ui_story"].transform.position).z)
				arg_195_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1054ui_story"].transform.localEulerAngles = arg_195_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_195_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1054ui_story"].transform.position).z)
				arg_195_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1054ui_story"].transform.localEulerAngles = arg_195_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_198_2 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(true)
				end
			end

			local var_198_3 = arg_195_1.actors_["1054ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_3) and arg_195_1.var_.characterEffect1054ui_story == nil then
				arg_195_1.var_.characterEffect1054ui_story = var_198_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_4 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 and not isNil(var_198_3) then
				if arg_195_1.var_.characterEffect1054ui_story and not isNil(var_198_3) then
					arg_195_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 and not isNil(var_198_3) and arg_195_1.var_.characterEffect1054ui_story then
				arg_195_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_198_6 = 0
			local var_198_7 = 0.4

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(426111047)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 16 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 16)

				if (16 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 16)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111047", "story_v_out_426111.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111047", "story_v_out_426111.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_426111", "426111047", "story_v_out_426111.awb")

						arg_195_1:RecordAudio("426111047", var_198_13)
						arg_195_1:RecordAudio("426111047", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_426111", "426111047", "story_v_out_426111.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_426111", "426111047", "story_v_out_426111.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play426111048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 426111048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play426111049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1054ui_story"]) and arg_199_1.var_.characterEffect1054ui_story == nil then
				arg_199_1.var_.characterEffect1054ui_story = arg_199_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1054ui_story"]) then
				if arg_199_1.var_.characterEffect1054ui_story and not isNil(arg_199_1.actors_["1054ui_story"]) then
					arg_199_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1054ui_story"]) and arg_199_1.var_.characterEffect1054ui_story then
				arg_199_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.275

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
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

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(426111048).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 11 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 11)

				if (11 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 11)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play426111049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 426111049
		arg_203_1.duration_ = 4.47

		local var_203_0 = {
			zh = 4.3,
			ja = 4.466
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
				arg_203_0:Play426111050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1054ui_story = arg_203_1.actors_["1054ui_story"].transform.localPosition

				local var_206_0 = GameObjectTools.GetOrAddComponent(arg_203_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_206_0 then
					var_206_0:EnableDynamicBone(false)
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_203_1.time_ - 0) / var_206_1)
				arg_203_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1054ui_story"].transform.position).z)
				arg_203_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1054ui_story"].transform.localEulerAngles = arg_203_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_203_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1054ui_story"].transform.position).z)
				arg_203_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1054ui_story"].transform.localEulerAngles = arg_203_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_206_2 = GameObjectTools.GetOrAddComponent(arg_203_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(true)
				end
			end

			local var_206_3 = arg_203_1.actors_["1054ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect1054ui_story == nil then
				arg_203_1.var_.characterEffect1054ui_story = var_206_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_4 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 and not isNil(var_206_3) then
				if arg_203_1.var_.characterEffect1054ui_story and not isNil(var_206_3) then
					arg_203_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect1054ui_story then
				arg_203_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_6 = 0
			local var_206_7 = 0.325

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(426111049)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 13 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 13)

				if (13 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 13)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111049", "story_v_out_426111.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111049", "story_v_out_426111.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_426111", "426111049", "story_v_out_426111.awb")

						arg_203_1:RecordAudio("426111049", var_206_13)
						arg_203_1:RecordAudio("426111049", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_426111", "426111049", "story_v_out_426111.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_426111", "426111049", "story_v_out_426111.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play426111050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 426111050
		arg_207_1.duration_ = 9.5

		local var_207_0 = {
			zh = 7.7,
			ja = 9.5
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
				arg_207_0:Play426111051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_210_0 = 0
			local var_210_1 = 0.65

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(426111050)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 26 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 26)

				if (26 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 26)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111050", "story_v_out_426111.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_out_426111", "426111050", "story_v_out_426111.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_out_426111", "426111050", "story_v_out_426111.awb")

						arg_207_1:RecordAudio("426111050", var_210_7)
						arg_207_1:RecordAudio("426111050", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_426111", "426111050", "story_v_out_426111.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_426111", "426111050", "story_v_out_426111.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play426111051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 426111051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play426111052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1054ui_story"]) and arg_211_1.var_.characterEffect1054ui_story == nil then
				arg_211_1.var_.characterEffect1054ui_story = arg_211_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1054ui_story"]) then
				if arg_211_1.var_.characterEffect1054ui_story and not isNil(arg_211_1.actors_["1054ui_story"]) then
					arg_211_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_0)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1054ui_story"]) and arg_211_1.var_.characterEffect1054ui_story then
				arg_211_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_214_1 = 0
			local var_214_2 = 0.8

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

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(426111051).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 32 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 32)

				if (32 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 32)) > 0 and var_214_2 < var_214_5 then
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
	Play426111052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 426111052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play426111053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(426111052).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 40 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 40)

				if (40 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 40)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play426111053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 426111053
		arg_219_1.duration_ = 14.1

		local var_219_0 = {
			zh = 9.1,
			ja = 14.1
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play426111054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1054ui_story = arg_219_1.actors_["1054ui_story"].transform.localPosition

				local var_222_0 = GameObjectTools.GetOrAddComponent(arg_219_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_222_0 then
					var_222_0:EnableDynamicBone(false)
				end
			end

			local var_222_1 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 then
				arg_219_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_219_1.time_ - 0) / var_222_1)
				arg_219_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1054ui_story"].transform.position).z)
				arg_219_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1054ui_story"].transform.localEulerAngles = arg_219_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 then
				arg_219_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_219_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1054ui_story"].transform.position).z)
				arg_219_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1054ui_story"].transform.localEulerAngles = arg_219_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_222_2 = GameObjectTools.GetOrAddComponent(arg_219_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_222_2 then
					var_222_2:EnableDynamicBone(true)
				end
			end

			local var_222_3 = arg_219_1.actors_["1054ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.characterEffect1054ui_story == nil then
				arg_219_1.var_.characterEffect1054ui_story = var_222_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_4 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 and not isNil(var_222_3) then
				if arg_219_1.var_.characterEffect1054ui_story and not isNil(var_222_3) then
					arg_219_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.characterEffect1054ui_story then
				arg_219_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_222_6 = 0
			local var_222_7 = 0.775

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(426111053)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 31 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 31)

				if (31 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 31)) > 0 and var_222_7 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111053", "story_v_out_426111.awb") ~= 0 then
					local var_222_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111053", "story_v_out_426111.awb") / 1000

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_426111", "426111053", "story_v_out_426111.awb")

						arg_219_1:RecordAudio("426111053", var_222_13)
						arg_219_1:RecordAudio("426111053", var_222_13)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_426111", "426111053", "story_v_out_426111.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_426111", "426111053", "story_v_out_426111.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play426111054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 426111054
		arg_223_1.duration_ = 7.1

		local var_223_0 = {
			zh = 3.533,
			ja = 7.1
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play426111055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos6148ui_story = arg_223_1.actors_["6148ui_story"].transform.localPosition

				local var_226_0 = GameObjectTools.GetOrAddComponent(arg_223_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_226_0 then
					var_226_0:EnableDynamicBone(false)
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_223_1.time_ - 0) / var_226_1)
				arg_223_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).z)
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles = arg_223_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_223_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).z)
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles = arg_223_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_226_2 = GameObjectTools.GetOrAddComponent(arg_223_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_226_2 then
					var_226_2:EnableDynamicBone(true)
				end
			end

			local var_226_3 = arg_223_1.actors_["6148ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_3) and arg_223_1.var_.characterEffect6148ui_story == nil then
				arg_223_1.var_.characterEffect6148ui_story = var_226_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_4 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 and not isNil(var_226_3) then
				if arg_223_1.var_.characterEffect6148ui_story and not isNil(var_226_3) then
					arg_223_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 and not isNil(var_226_3) and arg_223_1.var_.characterEffect6148ui_story then
				arg_223_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_226_6 = arg_223_1.actors_["1054ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1054ui_story == nil then
				arg_223_1.var_.characterEffect1054ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_7 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 and not isNil(var_226_6) then
				if arg_223_1.var_.characterEffect1054ui_story and not isNil(var_226_6) then
					arg_223_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_7)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1054ui_story then
				arg_223_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_226_8 = 0
			local var_226_9 = 0.4

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_10 = arg_223_1:GetWordFromCfg(426111054)
				local var_226_11 = arg_223_1:FormatText(var_226_10.content)

				arg_223_1.text_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_13 = 16 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 16)

				if (16 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 16)) > 0 and var_226_9 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_11
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111054", "story_v_out_426111.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_426111", "426111054", "story_v_out_426111.awb") / 1000

					if var_226_14 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_8
					end

					if var_226_10.prefab_name ~= "" and arg_223_1.actors_[var_226_10.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_10.prefab_name].transform, "story_v_out_426111", "426111054", "story_v_out_426111.awb")

						arg_223_1:RecordAudio("426111054", var_226_15)
						arg_223_1:RecordAudio("426111054", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_426111", "426111054", "story_v_out_426111.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_426111", "426111054", "story_v_out_426111.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_8) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_8 + var_226_16 and arg_223_1.time_ < var_226_8 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play426111055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 426111055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play426111056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["6148ui_story"]) and arg_227_1.var_.characterEffect6148ui_story == nil then
				arg_227_1.var_.characterEffect6148ui_story = arg_227_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["6148ui_story"]) then
				if arg_227_1.var_.characterEffect6148ui_story and not isNil(arg_227_1.actors_["6148ui_story"]) then
					arg_227_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_227_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["6148ui_story"]) and arg_227_1.var_.characterEffect6148ui_story then
				arg_227_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_227_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.85

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(426111055).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 34 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 34)

				if (34 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 34)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play426111056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 426111056
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play426111057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if arg_231_1.bgs_.SS2604 == nil then
				local var_234_0 = Object.Instantiate(arg_231_1.paintGo_)

				var_234_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2604")
				var_234_0.name = "SS2604"
				var_234_0.transform.parent = arg_231_1.stage_.transform
				var_234_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.bgs_.SS2604 = var_234_0
			end

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				local var_234_1 = arg_231_1.bgs_.SS2604

				arg_231_1.bgs_.SS2604.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_2 = var_234_1:GetComponent("SpriteRenderer")

				if var_234_2 and var_234_2.sprite then
					local var_234_3 = 2 * (var_234_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_1.transform.localScale = Vector3.New(var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "SS2604" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_4 = 3.999999999999

			if 3.999999999999 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= var_234_4 + 0.3 and arg_231_1.time_ < var_234_4 + 0.3 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			local var_234_5 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_6 = 2

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_5) / var_234_6)
				arg_231_1.mask_.color = var_234_7
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 then
				local var_234_8 = Color.New(0, 0, 0)

				var_234_8.a = 1
				arg_231_1.mask_.color = var_234_8
			end

			local var_234_9 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_10 = 2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 then
				local var_234_11 = Color.New(0, 0, 0)

				var_234_11.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_9) / var_234_10)
				arg_231_1.mask_.color = var_234_11
			end

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 then
				local var_234_12 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_12.a = 0
				arg_231_1.mask_.color = var_234_12
			end

			local var_234_13 = arg_231_1.actors_["6148ui_story"].transform

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 then
				arg_231_1.var_.moveOldPos6148ui_story = var_234_13.localPosition

				local var_234_14 = GameObjectTools.GetOrAddComponent(var_234_13.gameObject, typeof(DynamicBoneHelper))

				if var_234_14 then
					var_234_14:EnableDynamicBone(false)
				end
			end

			local var_234_15 = 0.001

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_15 then
				var_234_13.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 1.96599999815226) / var_234_15)
				var_234_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_13.position).x, (manager.ui.mainCamera.transform.position - var_234_13.position).y, (manager.ui.mainCamera.transform.position - var_234_13.position).z)
				var_234_13.localEulerAngles.z = 0
				var_234_13.localEulerAngles.x = 0
				var_234_13.localEulerAngles = var_234_13.localEulerAngles
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_15 and arg_231_1.time_ < 1.96599999815226 + var_234_15 + arg_234_0 then
				var_234_13.localPosition = Vector3.New(0, 100, 0)
				var_234_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_13.position).x, (manager.ui.mainCamera.transform.position - var_234_13.position).y, (manager.ui.mainCamera.transform.position - var_234_13.position).z)
				var_234_13.localEulerAngles.z = 0
				var_234_13.localEulerAngles.x = 0
				var_234_13.localEulerAngles = var_234_13.localEulerAngles

				local var_234_16 = GameObjectTools.GetOrAddComponent(var_234_13.gameObject, typeof(DynamicBoneHelper))

				if var_234_16 then
					var_234_16:EnableDynamicBone(true)
				end
			end

			local var_234_17 = arg_231_1.actors_["1054ui_story"].transform

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 then
				arg_231_1.var_.moveOldPos1054ui_story = var_234_17.localPosition

				local var_234_18 = GameObjectTools.GetOrAddComponent(var_234_17.gameObject, typeof(DynamicBoneHelper))

				if var_234_18 then
					var_234_18:EnableDynamicBone(false)
				end
			end

			local var_234_19 = 0.001

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_19 then
				var_234_17.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 1.96599999815226) / var_234_19)
				var_234_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_17.position).x, (manager.ui.mainCamera.transform.position - var_234_17.position).y, (manager.ui.mainCamera.transform.position - var_234_17.position).z)
				var_234_17.localEulerAngles.z = 0
				var_234_17.localEulerAngles.x = 0
				var_234_17.localEulerAngles = var_234_17.localEulerAngles
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_19 and arg_231_1.time_ < 1.96599999815226 + var_234_19 + arg_234_0 then
				var_234_17.localPosition = Vector3.New(0, 100, 0)
				var_234_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_17.position).x, (manager.ui.mainCamera.transform.position - var_234_17.position).y, (manager.ui.mainCamera.transform.position - var_234_17.position).z)
				var_234_17.localEulerAngles.z = 0
				var_234_17.localEulerAngles.x = 0
				var_234_17.localEulerAngles = var_234_17.localEulerAngles

				local var_234_20 = GameObjectTools.GetOrAddComponent(var_234_17.gameObject, typeof(DynamicBoneHelper))

				if var_234_20 then
					var_234_20:EnableDynamicBone(true)
				end
			end

			local var_234_21 = arg_231_1.bgs_.SS2604.transform

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				arg_231_1.var_.moveOldPosSS2604 = var_234_21.localPosition
			end

			local var_234_22 = 2

			if 2 <= arg_231_1.time_ and arg_231_1.time_ < 2 + var_234_22 then
				var_234_21.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPosSS2604, Vector3.New(3.2, -0.7, -2), (arg_231_1.time_ - 2) / var_234_22)
			end

			if arg_231_1.time_ >= 2 + var_234_22 and arg_231_1.time_ < 2 + var_234_22 + arg_234_0 then
				var_234_21.localPosition = Vector3.New(3.2, -0.7, -2)
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_23 = 4
			local var_234_24 = 1.1

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_23 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_25 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_25:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(426111056).content)

				arg_231_1.text_.text = var_234_26

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 44 <= 0 and var_234_24 or var_234_24 * (utf8.len(var_234_26) / 44)

				if (44 <= 0 and var_234_24 or var_234_24 * (utf8.len(var_234_26) / 44)) > 0 and var_234_24 < var_234_28 then
					arg_231_1.talkMaxDuration = var_234_28
					var_234_23 = var_234_23 + 0.3

					if var_234_28 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_28 + var_234_23
					end
				end

				arg_231_1.text_.text = var_234_26
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_29 = var_234_23 + 0.3
			local var_234_30 = math.max(var_234_24, arg_231_1.talkMaxDuration)

			if var_234_23 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_29 + var_234_30 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_29) / var_234_30

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_29 + var_234_30 and arg_231_1.time_ < var_234_29 + var_234_30 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2604",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(3, -0.7, -2),
					endPos = Vector3.New(3.2, -0.7, -2),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play426111057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 426111057
		arg_237_1.duration_ = 7.2

		local var_237_0 = {
			zh = 5.433,
			ja = 7.2
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
				arg_237_0:Play426111058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.475

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_1 = arg_237_1:GetWordFromCfg(426111057)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 19 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 19)

				if (19 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 19)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111057", "story_v_out_426111.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111057", "story_v_out_426111.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_426111", "426111057", "story_v_out_426111.awb")

						arg_237_1:RecordAudio("426111057", var_240_6)
						arg_237_1:RecordAudio("426111057", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_426111", "426111057", "story_v_out_426111.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_426111", "426111057", "story_v_out_426111.awb")
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
	Play426111058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 426111058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play426111059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.625

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(426111058).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 25 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 25)

				if (25 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 25)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play426111059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 426111059
		arg_245_1.duration_ = 4.6

		local var_245_0 = {
			zh = 4,
			ja = 4.6
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
				arg_245_0:Play426111060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.375

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(426111059)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 15 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 15)

				if (15 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 15)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111059", "story_v_out_426111.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111059", "story_v_out_426111.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_426111", "426111059", "story_v_out_426111.awb")

						arg_245_1:RecordAudio("426111059", var_248_6)
						arg_245_1:RecordAudio("426111059", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_426111", "426111059", "story_v_out_426111.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_426111", "426111059", "story_v_out_426111.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play426111060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 426111060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play426111061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 1.175

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
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

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(426111060).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 47 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 47)

				if (47 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 47)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play426111061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 426111061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play426111062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.75

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(426111061).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 30 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 30)

				if (30 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 30)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play426111062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 426111062
		arg_257_1.duration_ = 6.5

		local var_257_0 = {
			zh = 4.666,
			ja = 6.5
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
				arg_257_0:Play426111063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.425

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:GetWordFromCfg(426111062)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 17 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 17)

				if (17 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 17)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111062", "story_v_out_426111.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111062", "story_v_out_426111.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_426111", "426111062", "story_v_out_426111.awb")

						arg_257_1:RecordAudio("426111062", var_260_6)
						arg_257_1:RecordAudio("426111062", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_426111", "426111062", "story_v_out_426111.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_426111", "426111062", "story_v_out_426111.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play426111063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 426111063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play426111064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.675

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
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

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(426111063).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 27 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 27)

				if (27 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 27)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play426111064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 426111064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play426111065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.65

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(426111064).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 26 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 26)

				if (26 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 26)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play426111065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 426111065
		arg_269_1.duration_ = 7.17

		local var_269_0 = {
			zh = 4.666,
			ja = 7.166
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
				arg_269_0:Play426111066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.6

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_1 = arg_269_1:GetWordFromCfg(426111065)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 24 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 24)

				if (24 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 24)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111065", "story_v_out_426111.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111065", "story_v_out_426111.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_426111", "426111065", "story_v_out_426111.awb")

						arg_269_1:RecordAudio("426111065", var_272_6)
						arg_269_1:RecordAudio("426111065", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_426111", "426111065", "story_v_out_426111.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_426111", "426111065", "story_v_out_426111.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play426111066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 426111066
		arg_273_1.duration_ = 6.9

		local var_273_0 = {
			zh = 4.6,
			ja = 6.9
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
				arg_273_0:Play426111067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.55

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:GetWordFromCfg(426111066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 22 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 22)

				if (22 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 22)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111066", "story_v_out_426111.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111066", "story_v_out_426111.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_426111", "426111066", "story_v_out_426111.awb")

						arg_273_1:RecordAudio("426111066", var_276_6)
						arg_273_1:RecordAudio("426111066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_426111", "426111066", "story_v_out_426111.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_426111", "426111066", "story_v_out_426111.awb")
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
	Play426111067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 426111067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play426111068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(426111067).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 40 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 40)

				if (40 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 40)) > 0 and var_280_0 < var_280_3 then
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
	Play426111068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 426111068
		arg_281_1.duration_ = 10.36

		local var_281_0 = {
			zh = 3.957999999999,
			ja = 10.357999999999
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
				arg_281_0:Play426111069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPosSS2604 = arg_281_1.bgs_.SS2604.transform.localPosition
			end

			local var_284_0 = 2.9

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.bgs_.SS2604.transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPosSS2604, Vector3.New(-1.99, -0.28, 4.57), (arg_281_1.time_ - 0) / var_284_0)
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.bgs_.SS2604.transform.localPosition = Vector3.New(-1.99, -0.28, 4.57)
			end

			local var_284_1 = 0

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.allBtn_.enabled = false
			end

			if arg_281_1.time_ >= var_284_1 + 2.9 and arg_281_1.time_ < var_284_1 + 2.9 + arg_284_0 then
				arg_281_1.allBtn_.enabled = true
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_2 = 0.624999999999
			local var_284_3 = 0.375

			if 0.624999999999 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_4 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_4:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:GetWordFromCfg(426111068)
				local var_284_6 = arg_281_1:FormatText(var_284_5.content)

				arg_281_1.text_.text = var_284_6

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_8 = 15 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_6) / 15)

				if (15 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_6) / 15)) > 0 and var_284_3 < var_284_8 then
					arg_281_1.talkMaxDuration = var_284_8
					var_284_2 = var_284_2 + 0.3

					if var_284_8 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_6
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111068", "story_v_out_426111.awb") ~= 0 then
					local var_284_9 = manager.audio:GetVoiceLength("story_v_out_426111", "426111068", "story_v_out_426111.awb") / 1000

					if var_284_9 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_2
					end

					if var_284_5.prefab_name ~= "" and arg_281_1.actors_[var_284_5.prefab_name] ~= nil then
						local var_284_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_5.prefab_name].transform, "story_v_out_426111", "426111068", "story_v_out_426111.awb")

						arg_281_1:RecordAudio("426111068", var_284_10)
						arg_281_1:RecordAudio("426111068", var_284_10)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_426111", "426111068", "story_v_out_426111.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_426111", "426111068", "story_v_out_426111.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_11 = var_284_2 + 0.3
			local var_284_12 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 + 0.3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_11 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_11) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_11 + var_284_12 and arg_281_1.time_ < var_284_11 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2604",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.9,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(3.2, -0.7, -2),
					endPos = Vector3.New(-1.99, -0.28, 4.57),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play426111069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 426111069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play426111070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.825

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(426111069).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 33 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 33)

				if (33 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 33)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play426111070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 426111070
		arg_291_1.duration_ = 6.6

		local var_291_0 = {
			zh = 4.833333333332,
			ja = 6.6
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
				arg_291_0:Play426111071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_9001
			local var_294_9000

			if 1.06666666666667 < arg_291_1.time_ and arg_291_1.time_ <= 1.06666666666667 + arg_294_0 then
				local var_294_0 = arg_291_1.bgs_.SS2604

				arg_291_1.bgs_.SS2604.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_294_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_1 = var_294_0:GetComponent("SpriteRenderer")

				if var_294_1 and var_294_1.sprite then
					local var_294_2 = 2 * (var_294_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_294_0.transform.localScale = Vector3.New(var_294_2 / var_294_1.sprite.bounds.size.y < var_294_2 * manager.ui.mainCameraCom_.aspect / var_294_1.sprite.bounds.size.x and var_294_2 * manager.ui.mainCameraCom_.aspect / var_294_1.sprite.bounds.size.x or var_294_2 / var_294_1.sprite.bounds.size.y, var_294_2 / var_294_1.sprite.bounds.size.y < var_294_2 * manager.ui.mainCameraCom_.aspect / var_294_1.sprite.bounds.size.x and var_294_2 * manager.ui.mainCameraCom_.aspect / var_294_1.sprite.bounds.size.x or var_294_2 / var_294_1.sprite.bounds.size.y, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "SS2604" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				local var_294_3 = arg_291_1.var_.effecthuatianzhuanchang1

				if not arg_291_1.var_.effecthuatianzhuanchang1 then
					var_294_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_294_3.name = "huatianzhuanchang1"
					arg_291_1.var_.effecthuatianzhuanchang1 = var_294_3
				else
					var_294_3.transform:SetParent(var_294_9001)
				end

				var_294_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_294_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.5 < arg_291_1.time_ and arg_291_1.time_ <= 1.5 + arg_294_0 then
				if arg_291_1.var_.effecthuatianzhuanchang1 then
					Object.Destroy(arg_291_1.var_.effecthuatianzhuanchang1)

					arg_291_1.var_.effecthuatianzhuanchang1 = nil
				end
			end

			if 1.5 < arg_291_1.time_ and arg_291_1.time_ <= 1.5 + arg_294_0 then
				local var_294_6 = arg_291_1.var_.effecthuatianzhuanchang2

				if not arg_291_1.var_.effecthuatianzhuanchang2 then
					var_294_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_294_6.name = "huatianzhuanchang2"
					arg_291_1.var_.effecthuatianzhuanchang2 = var_294_6
				else
					var_294_6.transform:SetParent(var_294_9000)
				end

				var_294_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_294_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.3 < arg_291_1.time_ and arg_291_1.time_ <= 2.3 + arg_294_0 then
				if arg_291_1.var_.effecthuatianzhuanchang2 then
					Object.Destroy(arg_291_1.var_.effecthuatianzhuanchang2)

					arg_291_1.var_.effecthuatianzhuanchang2 = nil
				end
			end

			local var_294_9 = arg_291_1.bgs_.SS2604.transform

			if 1.23333333333333 < arg_291_1.time_ and arg_291_1.time_ <= 1.23333333333333 + arg_294_0 then
				arg_291_1.var_.moveOldPosSS2604 = var_294_9.localPosition
			end

			local var_294_10 = 3.6

			if 1.23333333333333 <= arg_291_1.time_ and arg_291_1.time_ < 1.23333333333333 + var_294_10 then
				var_294_9.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPosSS2604, Vector3.New(0, 1, 10), (arg_291_1.time_ - 1.23333333333333) / var_294_10)
			end

			if arg_291_1.time_ >= 1.23333333333333 + var_294_10 and arg_291_1.time_ < 1.23333333333333 + var_294_10 + arg_294_0 then
				var_294_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_294_11 = 0

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_11 + arg_294_0 then
				arg_291_1.allBtn_.enabled = false
			end

			if arg_291_1.time_ >= var_294_11 + 4.83333333333333 and arg_291_1.time_ < var_294_11 + 4.83333333333333 + arg_294_0 then
				arg_291_1.allBtn_.enabled = true
			end

			local var_294_12 = 2
			local var_294_13 = 0.2

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_12 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_14 = arg_291_1:GetWordFromCfg(426111070)
				local var_294_15 = arg_291_1:FormatText(var_294_14.content)

				arg_291_1.text_.text = var_294_15

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_17 = 8 <= 0 and var_294_13 or var_294_13 * (utf8.len(var_294_15) / 8)

				if (8 <= 0 and var_294_13 or var_294_13 * (utf8.len(var_294_15) / 8)) > 0 and var_294_13 < var_294_17 then
					arg_291_1.talkMaxDuration = var_294_17

					if var_294_17 + var_294_12 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_17 + var_294_12
					end
				end

				arg_291_1.text_.text = var_294_15
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111070", "story_v_out_426111.awb") ~= 0 then
					local var_294_18 = manager.audio:GetVoiceLength("story_v_out_426111", "426111070", "story_v_out_426111.awb") / 1000

					if var_294_18 + var_294_12 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_18 + var_294_12
					end

					if var_294_14.prefab_name ~= "" and arg_291_1.actors_[var_294_14.prefab_name] ~= nil then
						local var_294_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_14.prefab_name].transform, "story_v_out_426111", "426111070", "story_v_out_426111.awb")

						arg_291_1:RecordAudio("426111070", var_294_19)
						arg_291_1:RecordAudio("426111070", var_294_19)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_426111", "426111070", "story_v_out_426111.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_426111", "426111070", "story_v_out_426111.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_20 = math.max(var_294_13, arg_291_1.talkMaxDuration)

			if var_294_12 <= arg_291_1.time_ and arg_291_1.time_ < var_294_12 + var_294_20 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_12) / var_294_20

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_12 + var_294_20 and arg_291_1.time_ < var_294_12 + var_294_20 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2604",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.6,
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play426111071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 426111071
		arg_295_1.duration_ = 4.7

		local var_295_0 = {
			zh = 3.333,
			ja = 4.7
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play426111072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.275

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:GetWordFromCfg(426111071)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 11 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 11)

				if (11 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 11)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111071", "story_v_out_426111.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111071", "story_v_out_426111.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_426111", "426111071", "story_v_out_426111.awb")

						arg_295_1:RecordAudio("426111071", var_298_6)
						arg_295_1:RecordAudio("426111071", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_426111", "426111071", "story_v_out_426111.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_426111", "426111071", "story_v_out_426111.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play426111072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 426111072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play426111073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.925

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(426111072).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 37 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 37)

				if (37 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 37)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play426111073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 426111073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play426111074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.525

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(426111073).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 61 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 61)

				if (61 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 61)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play426111074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 426111074
		arg_307_1.duration_ = 1.97

		local var_307_0 = {
			zh = 1.566,
			ja = 1.966
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play426111075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0.3 < arg_307_1.time_ and arg_307_1.time_ <= 0.3 + arg_310_0 then
				arg_307_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_310_0 = 0.3

			if 0.3 <= arg_307_1.time_ and arg_307_1.time_ < 0.3 + var_310_0 then
				local var_310_1, var_310_2 = math.modf((arg_307_1.time_ - 0.3) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_310_2 * 0.13, var_310_2 * 0.13, var_310_2 * 0.13) + arg_307_1.var_.shakeOldPos
			end

			if arg_307_1.time_ >= 0.3 + var_310_0 and arg_307_1.time_ < 0.3 + var_310_0 + arg_310_0 then
				manager.ui.mainCamera.transform.localPosition = arg_307_1.var_.shakeOldPos
			end

			local var_310_3 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= var_310_3 + 0.6 and arg_307_1.time_ < var_310_3 + 0.6 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_4 = 0.3
			local var_310_5 = 0.075

			if 0.3 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_6 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_6:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_7 = arg_307_1:GetWordFromCfg(426111074)
				local var_310_8 = arg_307_1:FormatText(var_310_7.content)

				arg_307_1.text_.text = var_310_8

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_10 = 3 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_8) / 3)

				if (3 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_8) / 3)) > 0 and var_310_5 < var_310_10 then
					arg_307_1.talkMaxDuration = var_310_10
					var_310_4 = var_310_4 + 0.3

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_8
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111074", "story_v_out_426111.awb") ~= 0 then
					local var_310_11 = manager.audio:GetVoiceLength("story_v_out_426111", "426111074", "story_v_out_426111.awb") / 1000

					if var_310_11 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_4
					end

					if var_310_7.prefab_name ~= "" and arg_307_1.actors_[var_310_7.prefab_name] ~= nil then
						local var_310_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_7.prefab_name].transform, "story_v_out_426111", "426111074", "story_v_out_426111.awb")

						arg_307_1:RecordAudio("426111074", var_310_12)
						arg_307_1:RecordAudio("426111074", var_310_12)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_426111", "426111074", "story_v_out_426111.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_426111", "426111074", "story_v_out_426111.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_13 = var_310_4 + 0.3
			local var_310_14 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 + 0.3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_13 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_13) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_13 + var_310_14 and arg_307_1.time_ < var_310_13 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play426111075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 426111075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play426111076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.275

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(426111075).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 11 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 11)

				if (11 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 11)) > 0 and var_316_0 < var_316_3 then
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
	Play426111076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 426111076
		arg_317_1.duration_ = 9.1

		local var_317_0 = {
			zh = 5.333,
			ja = 9.1
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play426111077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.675

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:GetWordFromCfg(426111076)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 27 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 27)

				if (27 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 27)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111076", "story_v_out_426111.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111076", "story_v_out_426111.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_426111", "426111076", "story_v_out_426111.awb")

						arg_317_1:RecordAudio("426111076", var_320_6)
						arg_317_1:RecordAudio("426111076", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_426111", "426111076", "story_v_out_426111.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_426111", "426111076", "story_v_out_426111.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play426111077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 426111077
		arg_321_1.duration_ = 5.3

		local var_321_0 = {
			zh = 3.766,
			ja = 5.3
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
				arg_321_0:Play426111078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.375

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(426111077)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 15 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 15)

				if (15 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 15)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111077", "story_v_out_426111.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111077", "story_v_out_426111.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_426111", "426111077", "story_v_out_426111.awb")

						arg_321_1:RecordAudio("426111077", var_324_6)
						arg_321_1:RecordAudio("426111077", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_426111", "426111077", "story_v_out_426111.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_426111", "426111077", "story_v_out_426111.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play426111078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 426111078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play426111079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.35

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
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

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(426111078).content)

				arg_325_1.text_.text = var_328_1

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_3 = 14 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 14)

				if (14 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 14)) > 0 and var_328_0 < var_328_3 then
					arg_325_1.talkMaxDuration = var_328_3

					if var_328_3 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_3 + 0
					end
				end

				arg_325_1.text_.text = var_328_1
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_4 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_4

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play426111079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 426111079
		arg_329_1.duration_ = 5.5

		local var_329_0 = {
			zh = 3.633,
			ja = 5.5
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
				arg_329_0:Play426111080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.425

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:GetWordFromCfg(426111079)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 17 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 17)

				if (17 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 17)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111079", "story_v_out_426111.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_426111", "426111079", "story_v_out_426111.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_426111", "426111079", "story_v_out_426111.awb")

						arg_329_1:RecordAudio("426111079", var_332_6)
						arg_329_1:RecordAudio("426111079", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_426111", "426111079", "story_v_out_426111.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_426111", "426111079", "story_v_out_426111.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play426111080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 426111080
		arg_333_1.duration_ = 9

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play426111081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 2 < arg_333_1.time_ and arg_333_1.time_ <= 2 + arg_336_0 then
				local var_336_0 = arg_333_1.bgs_.J27g

				arg_333_1.bgs_.J27g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_336_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_336_1 = var_336_0:GetComponent("SpriteRenderer")

				if var_336_1 and var_336_1.sprite then
					local var_336_2 = 2 * (var_336_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_336_0.transform.localScale = Vector3.New(var_336_2 / var_336_1.sprite.bounds.size.y < var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x and var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x or var_336_2 / var_336_1.sprite.bounds.size.y, var_336_2 / var_336_1.sprite.bounds.size.y < var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x and var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x or var_336_2 / var_336_1.sprite.bounds.size.y, 0)
				end

				for iter_336_0, iter_336_1 in pairs(arg_333_1.bgs_) do
					if iter_336_0 ~= "J27g" then
						iter_336_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_336_3 = 4

			if 4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_3 + arg_336_0 then
				arg_333_1.allBtn_.enabled = false
			end

			if arg_333_1.time_ >= var_336_3 + 0.3 and arg_333_1.time_ < var_336_3 + 0.3 + arg_336_0 then
				arg_333_1.allBtn_.enabled = true
			end

			local var_336_4 = 0

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_5 = 2

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_5 then
				local var_336_6 = Color.New(0, 0, 0)

				var_336_6.a = Mathf.Lerp(0, 1, (arg_333_1.time_ - var_336_4) / var_336_5)
				arg_333_1.mask_.color = var_336_6
			end

			if arg_333_1.time_ >= var_336_4 + var_336_5 and arg_333_1.time_ < var_336_4 + var_336_5 + arg_336_0 then
				local var_336_7 = Color.New(0, 0, 0)

				var_336_7.a = 1
				arg_333_1.mask_.color = var_336_7
			end

			local var_336_8 = 2

			if 2 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_9 = 2

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_9 then
				local var_336_10 = Color.New(0, 0, 0)

				var_336_10.a = Mathf.Lerp(1, 0, (arg_333_1.time_ - var_336_8) / var_336_9)
				arg_333_1.mask_.color = var_336_10
			end

			if arg_333_1.time_ >= var_336_8 + var_336_9 and arg_333_1.time_ < var_336_8 + var_336_9 + arg_336_0 then
				local var_336_11 = Color.New(0, 0, 0)

				arg_333_1.mask_.enabled = false
				var_336_11.a = 0
				arg_333_1.mask_.color = var_336_11
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_12 = 4
			local var_336_13 = 0.55

			if 4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_12 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_14 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_14:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_15 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(426111080).content)

				arg_333_1.text_.text = var_336_15

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_17 = 22 <= 0 and var_336_13 or var_336_13 * (utf8.len(var_336_15) / 22)

				if (22 <= 0 and var_336_13 or var_336_13 * (utf8.len(var_336_15) / 22)) > 0 and var_336_13 < var_336_17 then
					arg_333_1.talkMaxDuration = var_336_17
					var_336_12 = var_336_12 + 0.3

					if var_336_17 + var_336_12 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_17 + var_336_12
					end
				end

				arg_333_1.text_.text = var_336_15
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_18 = var_336_12 + 0.3
			local var_336_19 = math.max(var_336_13, arg_333_1.talkMaxDuration)

			if var_336_12 + 0.3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_18 + var_336_19 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_18) / var_336_19

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_18 + var_336_19 and arg_333_1.time_ < var_336_18 + var_336_19 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play426111081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 426111081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play426111082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.45

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
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

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(426111081).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 18 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 18)

				if (18 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 18)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play426111082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 426111082
		arg_343_1.duration_ = 3.37

		local var_343_0 = {
			zh = 1.999999999999,
			ja = 3.366
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play426111083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos6148ui_story = arg_343_1.actors_["6148ui_story"].transform.localPosition

				local var_346_0 = GameObjectTools.GetOrAddComponent(arg_343_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_346_0 then
					var_346_0:EnableDynamicBone(false)
				end
			end

			local var_346_1 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_1 then
				arg_343_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_343_1.time_ - 0) / var_346_1)
				arg_343_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["6148ui_story"].transform.position).z)
				arg_343_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["6148ui_story"].transform.localEulerAngles = arg_343_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_1 and arg_343_1.time_ < 0 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_343_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["6148ui_story"].transform.position).z)
				arg_343_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["6148ui_story"].transform.localEulerAngles = arg_343_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_346_2 = GameObjectTools.GetOrAddComponent(arg_343_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_346_2 then
					var_346_2:EnableDynamicBone(true)
				end
			end

			local var_346_3 = arg_343_1.actors_["6148ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_3) and arg_343_1.var_.characterEffect6148ui_story == nil then
				arg_343_1.var_.characterEffect6148ui_story = var_346_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_4 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 and not isNil(var_346_3) then
				if arg_343_1.var_.characterEffect6148ui_story and not isNil(var_346_3) then
					arg_343_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 and not isNil(var_346_3) and arg_343_1.var_.characterEffect6148ui_story then
				arg_343_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_346_6 = 0
			local var_346_7 = 0.1

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_8 = arg_343_1:GetWordFromCfg(426111082)
				local var_346_9 = arg_343_1:FormatText(var_346_8.content)

				arg_343_1.text_.text = var_346_9

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_11 = 4 <= 0 and var_346_7 or var_346_7 * (utf8.len(var_346_9) / 4)

				if (4 <= 0 and var_346_7 or var_346_7 * (utf8.len(var_346_9) / 4)) > 0 and var_346_7 < var_346_11 then
					arg_343_1.talkMaxDuration = var_346_11

					if var_346_11 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_11 + var_346_6
					end
				end

				arg_343_1.text_.text = var_346_9
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111082", "story_v_out_426111.awb") ~= 0 then
					local var_346_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111082", "story_v_out_426111.awb") / 1000

					if var_346_12 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_12 + var_346_6
					end

					if var_346_8.prefab_name ~= "" and arg_343_1.actors_[var_346_8.prefab_name] ~= nil then
						local var_346_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_8.prefab_name].transform, "story_v_out_426111", "426111082", "story_v_out_426111.awb")

						arg_343_1:RecordAudio("426111082", var_346_13)
						arg_343_1:RecordAudio("426111082", var_346_13)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_426111", "426111082", "story_v_out_426111.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_426111", "426111082", "story_v_out_426111.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_14 = math.max(var_346_7, arg_343_1.talkMaxDuration)

			if var_346_6 <= arg_343_1.time_ and arg_343_1.time_ < var_346_6 + var_346_14 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_6) / var_346_14

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_6 + var_346_14 and arg_343_1.time_ < var_346_6 + var_346_14 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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

		arg_343_1:InitPlayNodeList()
	end,
	Play426111083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 426111083
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play426111084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["6148ui_story"]) and arg_347_1.var_.characterEffect6148ui_story == nil then
				arg_347_1.var_.characterEffect6148ui_story = arg_347_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["6148ui_story"]) then
				if arg_347_1.var_.characterEffect6148ui_story and not isNil(arg_347_1.actors_["6148ui_story"]) then
					arg_347_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_347_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["6148ui_story"]) and arg_347_1.var_.characterEffect6148ui_story then
				arg_347_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_347_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0
			local var_350_2 = 0.325

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(426111083).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 13 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 13)

				if (13 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 13)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play426111084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 426111084
		arg_351_1.duration_ = 3.37

		local var_351_0 = {
			zh = 3.366,
			ja = 2.766
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play426111085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1054ui_story = arg_351_1.actors_["1054ui_story"].transform.localPosition

				local var_354_0 = GameObjectTools.GetOrAddComponent(arg_351_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_354_0 then
					var_354_0:EnableDynamicBone(false)
				end
			end

			local var_354_1 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_1 then
				arg_351_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_351_1.time_ - 0) / var_354_1)
				arg_351_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1054ui_story"].transform.position).z)
				arg_351_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1054ui_story"].transform.localEulerAngles = arg_351_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_1 and arg_351_1.time_ < 0 + var_354_1 + arg_354_0 then
				arg_351_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_351_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1054ui_story"].transform.position).z)
				arg_351_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1054ui_story"].transform.localEulerAngles = arg_351_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_354_2 = GameObjectTools.GetOrAddComponent(arg_351_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_354_2 then
					var_354_2:EnableDynamicBone(true)
				end
			end

			local var_354_3 = arg_351_1.actors_["6148ui_story"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos6148ui_story = var_354_3.localPosition

				local var_354_4 = GameObjectTools.GetOrAddComponent(var_354_3.gameObject, typeof(DynamicBoneHelper))

				if var_354_4 then
					var_354_4:EnableDynamicBone(false)
				end
			end

			local var_354_5 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_5 then
				var_354_3.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_351_1.time_ - 0) / var_354_5)
				var_354_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_3.position).x, (manager.ui.mainCamera.transform.position - var_354_3.position).y, (manager.ui.mainCamera.transform.position - var_354_3.position).z)
				var_354_3.localEulerAngles.z = 0
				var_354_3.localEulerAngles.x = 0
				var_354_3.localEulerAngles = var_354_3.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_5 and arg_351_1.time_ < 0 + var_354_5 + arg_354_0 then
				var_354_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_354_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_3.position).x, (manager.ui.mainCamera.transform.position - var_354_3.position).y, (manager.ui.mainCamera.transform.position - var_354_3.position).z)
				var_354_3.localEulerAngles.z = 0
				var_354_3.localEulerAngles.x = 0
				var_354_3.localEulerAngles = var_354_3.localEulerAngles

				local var_354_6 = GameObjectTools.GetOrAddComponent(var_354_3.gameObject, typeof(DynamicBoneHelper))

				if var_354_6 then
					var_354_6:EnableDynamicBone(true)
				end
			end

			local var_354_7 = arg_351_1.actors_["1054ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_7) and arg_351_1.var_.characterEffect1054ui_story == nil then
				arg_351_1.var_.characterEffect1054ui_story = var_354_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_8 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_8 and not isNil(var_354_7) then
				if arg_351_1.var_.characterEffect1054ui_story and not isNil(var_354_7) then
					arg_351_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_8 and arg_351_1.time_ < 0 + var_354_8 + arg_354_0 and not isNil(var_354_7) and arg_351_1.var_.characterEffect1054ui_story then
				arg_351_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_354_10 = 0
			local var_354_11 = 0.3

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_12 = arg_351_1:GetWordFromCfg(426111084)
				local var_354_13 = arg_351_1:FormatText(var_354_12.content)

				arg_351_1.text_.text = var_354_13

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_15 = 12 <= 0 and var_354_11 or var_354_11 * (utf8.len(var_354_13) / 12)

				if (12 <= 0 and var_354_11 or var_354_11 * (utf8.len(var_354_13) / 12)) > 0 and var_354_11 < var_354_15 then
					arg_351_1.talkMaxDuration = var_354_15

					if var_354_15 + var_354_10 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_15 + var_354_10
					end
				end

				arg_351_1.text_.text = var_354_13
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111084", "story_v_out_426111.awb") ~= 0 then
					local var_354_16 = manager.audio:GetVoiceLength("story_v_out_426111", "426111084", "story_v_out_426111.awb") / 1000

					if var_354_16 + var_354_10 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_16 + var_354_10
					end

					if var_354_12.prefab_name ~= "" and arg_351_1.actors_[var_354_12.prefab_name] ~= nil then
						local var_354_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_12.prefab_name].transform, "story_v_out_426111", "426111084", "story_v_out_426111.awb")

						arg_351_1:RecordAudio("426111084", var_354_17)
						arg_351_1:RecordAudio("426111084", var_354_17)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_426111", "426111084", "story_v_out_426111.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_426111", "426111084", "story_v_out_426111.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_18 = math.max(var_354_11, arg_351_1.talkMaxDuration)

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_18 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_10) / var_354_18

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_10 + var_354_18 and arg_351_1.time_ < var_354_10 + var_354_18 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play426111085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 426111085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play426111086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1054ui_story"]) and arg_355_1.var_.characterEffect1054ui_story == nil then
				arg_355_1.var_.characterEffect1054ui_story = arg_355_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1054ui_story"]) then
				if arg_355_1.var_.characterEffect1054ui_story and not isNil(arg_355_1.actors_["1054ui_story"]) then
					arg_355_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1054ui_story"]) and arg_355_1.var_.characterEffect1054ui_story then
				arg_355_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.325

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
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

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(426111085).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 13 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 13)

				if (13 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 13)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play426111086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 426111086
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play426111087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action425")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_362_0 = 0
			local var_362_1 = 0.55

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_2 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(426111086).content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 22 <= 0 and var_362_1 or var_362_1 * (utf8.len(var_362_2) / 22)

				if (22 <= 0 and var_362_1 or var_362_1 * (utf8.len(var_362_2) / 22)) > 0 and var_362_1 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_5 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_5 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_5

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_5 and arg_359_1.time_ < var_362_0 + var_362_5 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play426111087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 426111087
		arg_363_1.duration_ = 8.83

		local var_363_0 = {
			zh = 7.5,
			ja = 8.833
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
				arg_363_0:Play426111088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1054ui_story"]) and arg_363_1.var_.characterEffect1054ui_story == nil then
				arg_363_1.var_.characterEffect1054ui_story = arg_363_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1054ui_story"]) then
				if arg_363_1.var_.characterEffect1054ui_story and not isNil(arg_363_1.actors_["1054ui_story"]) then
					arg_363_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1054ui_story"]) and arg_363_1.var_.characterEffect1054ui_story then
				arg_363_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_366_2 = 0
			local var_366_3 = 0.6

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_4 = arg_363_1:GetWordFromCfg(426111087)
				local var_366_5 = arg_363_1:FormatText(var_366_4.content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 24 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 24)

				if (24 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 24)) > 0 and var_366_3 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111087", "story_v_out_426111.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_426111", "426111087", "story_v_out_426111.awb") / 1000

					if var_366_8 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_2
					end

					if var_366_4.prefab_name ~= "" and arg_363_1.actors_[var_366_4.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_4.prefab_name].transform, "story_v_out_426111", "426111087", "story_v_out_426111.awb")

						arg_363_1:RecordAudio("426111087", var_366_9)
						arg_363_1:RecordAudio("426111087", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_426111", "426111087", "story_v_out_426111.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_426111", "426111087", "story_v_out_426111.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_10 and arg_363_1.time_ < var_366_2 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play426111088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 426111088
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play426111089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1054ui_story"]) and arg_367_1.var_.characterEffect1054ui_story == nil then
				arg_367_1.var_.characterEffect1054ui_story = arg_367_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1054ui_story"]) then
				if arg_367_1.var_.characterEffect1054ui_story and not isNil(arg_367_1.actors_["1054ui_story"]) then
					arg_367_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1054ui_story"]) and arg_367_1.var_.characterEffect1054ui_story then
				arg_367_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 0.475

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(426111088).content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 19 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 19)

				if (19 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 19)) > 0 and var_370_2 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_6 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_6 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_6

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_6 and arg_367_1.time_ < var_370_1 + var_370_6 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play426111089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 426111089
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play426111090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.725

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

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(426111089).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 29 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 29)

				if (29 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 29)) > 0 and var_374_0 < var_374_3 then
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
	Play426111090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 426111090
		arg_375_1.duration_ = 12.6

		local var_375_0 = {
			zh = 9.9,
			ja = 12.6
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
				arg_375_0:Play426111091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1054ui_story = arg_375_1.actors_["1054ui_story"].transform.localPosition

				local var_378_0 = GameObjectTools.GetOrAddComponent(arg_375_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_378_0 then
					var_378_0:EnableDynamicBone(false)
				end
			end

			local var_378_1 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_1 then
				arg_375_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_375_1.time_ - 0) / var_378_1)
				arg_375_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).z)
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles = arg_375_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_1 and arg_375_1.time_ < 0 + var_378_1 + arg_378_0 then
				arg_375_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_375_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).z)
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles = arg_375_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_378_2 = GameObjectTools.GetOrAddComponent(arg_375_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_378_2 then
					var_378_2:EnableDynamicBone(true)
				end
			end

			local var_378_3 = arg_375_1.actors_["1054ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_3) and arg_375_1.var_.characterEffect1054ui_story == nil then
				arg_375_1.var_.characterEffect1054ui_story = var_378_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_4 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 and not isNil(var_378_3) then
				if arg_375_1.var_.characterEffect1054ui_story and not isNil(var_378_3) then
					arg_375_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 and not isNil(var_378_3) and arg_375_1.var_.characterEffect1054ui_story then
				arg_375_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action453")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_378_6 = 0
			local var_378_7 = 0.95

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_8 = arg_375_1:GetWordFromCfg(426111090)
				local var_378_9 = arg_375_1:FormatText(var_378_8.content)

				arg_375_1.text_.text = var_378_9

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_11 = 38 <= 0 and var_378_7 or var_378_7 * (utf8.len(var_378_9) / 38)

				if (38 <= 0 and var_378_7 or var_378_7 * (utf8.len(var_378_9) / 38)) > 0 and var_378_7 < var_378_11 then
					arg_375_1.talkMaxDuration = var_378_11

					if var_378_11 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_6
					end
				end

				arg_375_1.text_.text = var_378_9
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111090", "story_v_out_426111.awb") ~= 0 then
					local var_378_12 = manager.audio:GetVoiceLength("story_v_out_426111", "426111090", "story_v_out_426111.awb") / 1000

					if var_378_12 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_12 + var_378_6
					end

					if var_378_8.prefab_name ~= "" and arg_375_1.actors_[var_378_8.prefab_name] ~= nil then
						local var_378_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_8.prefab_name].transform, "story_v_out_426111", "426111090", "story_v_out_426111.awb")

						arg_375_1:RecordAudio("426111090", var_378_13)
						arg_375_1:RecordAudio("426111090", var_378_13)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_426111", "426111090", "story_v_out_426111.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_426111", "426111090", "story_v_out_426111.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_14 = math.max(var_378_7, arg_375_1.talkMaxDuration)

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_14 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_6) / var_378_14

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_6 + var_378_14 and arg_375_1.time_ < var_378_6 + var_378_14 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play426111091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 426111091
		arg_379_1.duration_ = 4.4

		local var_379_0 = {
			zh = 3.8,
			ja = 4.4
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
				arg_379_0:Play426111092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos6148ui_story = arg_379_1.actors_["6148ui_story"].transform.localPosition

				local var_382_0 = GameObjectTools.GetOrAddComponent(arg_379_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_382_0 then
					var_382_0:EnableDynamicBone(false)
				end
			end

			local var_382_1 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 then
				arg_379_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_379_1.time_ - 0) / var_382_1)
				arg_379_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).z)
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles = arg_379_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 then
				arg_379_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_379_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).z)
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles = arg_379_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_382_2 = GameObjectTools.GetOrAddComponent(arg_379_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_382_2 then
					var_382_2:EnableDynamicBone(true)
				end
			end

			local var_382_3 = arg_379_1.actors_["6148ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_3) and arg_379_1.var_.characterEffect6148ui_story == nil then
				arg_379_1.var_.characterEffect6148ui_story = var_382_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_4 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 and not isNil(var_382_3) then
				if arg_379_1.var_.characterEffect6148ui_story and not isNil(var_382_3) then
					arg_379_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 and not isNil(var_382_3) and arg_379_1.var_.characterEffect6148ui_story then
				arg_379_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_382_6 = arg_379_1.actors_["1054ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_6) and arg_379_1.var_.characterEffect1054ui_story == nil then
				arg_379_1.var_.characterEffect1054ui_story = var_382_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_7 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 and not isNil(var_382_6) then
				if arg_379_1.var_.characterEffect1054ui_story and not isNil(var_382_6) then
					arg_379_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_7)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 and not isNil(var_382_6) and arg_379_1.var_.characterEffect1054ui_story then
				arg_379_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action3_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_382_8 = 0
			local var_382_9 = 0.5

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_10 = arg_379_1:GetWordFromCfg(426111091)
				local var_382_11 = arg_379_1:FormatText(var_382_10.content)

				arg_379_1.text_.text = var_382_11

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_13 = 20 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 20)

				if (20 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 20)) > 0 and var_382_9 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_11
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111091", "story_v_out_426111.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_426111", "426111091", "story_v_out_426111.awb") / 1000

					if var_382_14 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_8
					end

					if var_382_10.prefab_name ~= "" and arg_379_1.actors_[var_382_10.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_10.prefab_name].transform, "story_v_out_426111", "426111091", "story_v_out_426111.awb")

						arg_379_1:RecordAudio("426111091", var_382_15)
						arg_379_1:RecordAudio("426111091", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_426111", "426111091", "story_v_out_426111.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_426111", "426111091", "story_v_out_426111.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_16 and arg_379_1.time_ < var_382_8 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play426111092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 426111092
		arg_383_1.duration_ = 9

		local var_383_0 = {
			zh = 9,
			ja = 8.066
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
				arg_383_0:Play426111093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1054ui_story = arg_383_1.actors_["1054ui_story"].transform.localPosition

				local var_386_0 = GameObjectTools.GetOrAddComponent(arg_383_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_386_0 then
					var_386_0:EnableDynamicBone(false)
				end
			end

			local var_386_1 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_1 then
				arg_383_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_383_1.time_ - 0) / var_386_1)
				arg_383_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1054ui_story"].transform.position).z)
				arg_383_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1054ui_story"].transform.localEulerAngles = arg_383_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_1 and arg_383_1.time_ < 0 + var_386_1 + arg_386_0 then
				arg_383_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_383_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1054ui_story"].transform.position).z)
				arg_383_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1054ui_story"].transform.localEulerAngles = arg_383_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_386_2 = GameObjectTools.GetOrAddComponent(arg_383_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_386_2 then
					var_386_2:EnableDynamicBone(true)
				end
			end

			local var_386_3 = arg_383_1.actors_["1054ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_3) and arg_383_1.var_.characterEffect1054ui_story == nil then
				arg_383_1.var_.characterEffect1054ui_story = var_386_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_4 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 and not isNil(var_386_3) then
				if arg_383_1.var_.characterEffect1054ui_story and not isNil(var_386_3) then
					arg_383_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 and not isNil(var_386_3) and arg_383_1.var_.characterEffect1054ui_story then
				arg_383_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_386_6 = arg_383_1.actors_["6148ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_6) and arg_383_1.var_.characterEffect6148ui_story == nil then
				arg_383_1.var_.characterEffect6148ui_story = var_386_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_7 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 and not isNil(var_386_6) then
				if arg_383_1.var_.characterEffect6148ui_story and not isNil(var_386_6) then
					arg_383_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_383_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_7)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 and not isNil(var_386_6) and arg_383_1.var_.characterEffect6148ui_story then
				arg_383_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_383_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action437")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_386_8 = 0
			local var_386_9 = 0.725

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_10 = arg_383_1:GetWordFromCfg(426111092)
				local var_386_11 = arg_383_1:FormatText(var_386_10.content)

				arg_383_1.text_.text = var_386_11

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_13 = 29 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_11) / 29)

				if (29 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_11) / 29)) > 0 and var_386_9 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_8
					end
				end

				arg_383_1.text_.text = var_386_11
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111092", "story_v_out_426111.awb") ~= 0 then
					local var_386_14 = manager.audio:GetVoiceLength("story_v_out_426111", "426111092", "story_v_out_426111.awb") / 1000

					if var_386_14 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_8
					end

					if var_386_10.prefab_name ~= "" and arg_383_1.actors_[var_386_10.prefab_name] ~= nil then
						local var_386_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_10.prefab_name].transform, "story_v_out_426111", "426111092", "story_v_out_426111.awb")

						arg_383_1:RecordAudio("426111092", var_386_15)
						arg_383_1:RecordAudio("426111092", var_386_15)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_426111", "426111092", "story_v_out_426111.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_426111", "426111092", "story_v_out_426111.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_9, arg_383_1.talkMaxDuration)

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_8) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_8 + var_386_16 and arg_383_1.time_ < var_386_8 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
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

		arg_383_1:InitPlayNodeList()
	end,
	Play426111093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 426111093
		arg_387_1.duration_ = 5.73

		local var_387_0 = {
			zh = 4.3,
			ja = 5.733
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play426111094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos6148ui_story = arg_387_1.actors_["6148ui_story"].transform.localPosition

				local var_390_0 = GameObjectTools.GetOrAddComponent(arg_387_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_390_0 then
					var_390_0:EnableDynamicBone(false)
				end
			end

			local var_390_1 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_1 then
				arg_387_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_387_1.time_ - 0) / var_390_1)
				arg_387_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).z)
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles = arg_387_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_1 and arg_387_1.time_ < 0 + var_390_1 + arg_390_0 then
				arg_387_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_387_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).z)
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles = arg_387_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_390_2 = GameObjectTools.GetOrAddComponent(arg_387_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_390_2 then
					var_390_2:EnableDynamicBone(true)
				end
			end

			local var_390_3 = arg_387_1.actors_["6148ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_3) and arg_387_1.var_.characterEffect6148ui_story == nil then
				arg_387_1.var_.characterEffect6148ui_story = var_390_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_4 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 and not isNil(var_390_3) then
				if arg_387_1.var_.characterEffect6148ui_story and not isNil(var_390_3) then
					arg_387_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 and not isNil(var_390_3) and arg_387_1.var_.characterEffect6148ui_story then
				arg_387_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_390_6 = arg_387_1.actors_["1054ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_6) and arg_387_1.var_.characterEffect1054ui_story == nil then
				arg_387_1.var_.characterEffect1054ui_story = var_390_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_7 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 and not isNil(var_390_6) then
				if arg_387_1.var_.characterEffect1054ui_story and not isNil(var_390_6) then
					arg_387_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_7)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 and not isNil(var_390_6) and arg_387_1.var_.characterEffect1054ui_story then
				arg_387_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action3_2")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_390_8 = 0
			local var_390_9 = 0.425

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_8 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_10 = arg_387_1:GetWordFromCfg(426111093)
				local var_390_11 = arg_387_1:FormatText(var_390_10.content)

				arg_387_1.text_.text = var_390_11

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_13 = 17 <= 0 and var_390_9 or var_390_9 * (utf8.len(var_390_11) / 17)

				if (17 <= 0 and var_390_9 or var_390_9 * (utf8.len(var_390_11) / 17)) > 0 and var_390_9 < var_390_13 then
					arg_387_1.talkMaxDuration = var_390_13

					if var_390_13 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_13 + var_390_8
					end
				end

				arg_387_1.text_.text = var_390_11
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426111", "426111093", "story_v_out_426111.awb") ~= 0 then
					local var_390_14 = manager.audio:GetVoiceLength("story_v_out_426111", "426111093", "story_v_out_426111.awb") / 1000

					if var_390_14 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_14 + var_390_8
					end

					if var_390_10.prefab_name ~= "" and arg_387_1.actors_[var_390_10.prefab_name] ~= nil then
						local var_390_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_10.prefab_name].transform, "story_v_out_426111", "426111093", "story_v_out_426111.awb")

						arg_387_1:RecordAudio("426111093", var_390_15)
						arg_387_1:RecordAudio("426111093", var_390_15)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_426111", "426111093", "story_v_out_426111.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_426111", "426111093", "story_v_out_426111.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_16 = math.max(var_390_9, arg_387_1.talkMaxDuration)

			if var_390_8 <= arg_387_1.time_ and arg_387_1.time_ < var_390_8 + var_390_16 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_8) / var_390_16

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_8 + var_390_16 and arg_387_1.time_ < var_390_8 + var_390_16 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
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

		arg_387_1:InitPlayNodeList()
	end,
	Play426111094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 426111094
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play426111095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos6148ui_story = arg_391_1.actors_["6148ui_story"].transform.localPosition

				local var_394_0 = GameObjectTools.GetOrAddComponent(arg_391_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_394_0 then
					var_394_0:EnableDynamicBone(false)
				end
			end

			local var_394_1 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_1 then
				arg_391_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_1)
				arg_391_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["6148ui_story"].transform.position).z)
				arg_391_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["6148ui_story"].transform.localEulerAngles = arg_391_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_1 and arg_391_1.time_ < 0 + var_394_1 + arg_394_0 then
				arg_391_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["6148ui_story"].transform.position).z)
				arg_391_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["6148ui_story"].transform.localEulerAngles = arg_391_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_394_2 = GameObjectTools.GetOrAddComponent(arg_391_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_394_2 then
					var_394_2:EnableDynamicBone(true)
				end
			end

			local var_394_3 = arg_391_1.actors_["1054ui_story"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1054ui_story = var_394_3.localPosition

				local var_394_4 = GameObjectTools.GetOrAddComponent(var_394_3.gameObject, typeof(DynamicBoneHelper))

				if var_394_4 then
					var_394_4:EnableDynamicBone(false)
				end
			end

			local var_394_5 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_5 then
				var_394_3.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_5)
				var_394_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_3.position).x, (manager.ui.mainCamera.transform.position - var_394_3.position).y, (manager.ui.mainCamera.transform.position - var_394_3.position).z)
				var_394_3.localEulerAngles.z = 0
				var_394_3.localEulerAngles.x = 0
				var_394_3.localEulerAngles = var_394_3.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_5 and arg_391_1.time_ < 0 + var_394_5 + arg_394_0 then
				var_394_3.localPosition = Vector3.New(0, 100, 0)
				var_394_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_3.position).x, (manager.ui.mainCamera.transform.position - var_394_3.position).y, (manager.ui.mainCamera.transform.position - var_394_3.position).z)
				var_394_3.localEulerAngles.z = 0
				var_394_3.localEulerAngles.x = 0
				var_394_3.localEulerAngles = var_394_3.localEulerAngles

				local var_394_6 = GameObjectTools.GetOrAddComponent(var_394_3.gameObject, typeof(DynamicBoneHelper))

				if var_394_6 then
					var_394_6:EnableDynamicBone(true)
				end
			end

			local var_394_7 = arg_391_1.actors_["6148ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_7) and arg_391_1.var_.characterEffect6148ui_story == nil then
				arg_391_1.var_.characterEffect6148ui_story = var_394_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_8 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_8 and not isNil(var_394_7) then
				if arg_391_1.var_.characterEffect6148ui_story and not isNil(var_394_7) then
					arg_391_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_391_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_8)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_8 and arg_391_1.time_ < 0 + var_394_8 + arg_394_0 and not isNil(var_394_7) and arg_391_1.var_.characterEffect6148ui_story then
				arg_391_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_391_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_394_9 = 0
			local var_394_10 = 0.65

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_9 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_11 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(426111094).content)

				arg_391_1.text_.text = var_394_11

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_13 = 26 <= 0 and var_394_10 or var_394_10 * (utf8.len(var_394_11) / 26)

				if (26 <= 0 and var_394_10 or var_394_10 * (utf8.len(var_394_11) / 26)) > 0 and var_394_10 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_9 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_9
					end
				end

				arg_391_1.text_.text = var_394_11
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_14 = math.max(var_394_10, arg_391_1.talkMaxDuration)

			if var_394_9 <= arg_391_1.time_ and arg_391_1.time_ < var_394_9 + var_394_14 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_9) / var_394_14

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_9 + var_394_14 and arg_391_1.time_ < var_394_9 + var_394_14 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_391_1:InitPlayNodeList()
	end,
	Play426111095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 426111095
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play426111096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 1.175

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(426111095).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 47 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 47)

				if (47 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 47)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play426111096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 426111096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
			arg_399_1.auto_ = false
		end

		function arg_399_1.playNext_(arg_401_0)
			arg_399_1.onStoryFinished_()
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.675

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(426111096).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 27 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 27)

				if (27 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 27)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2012",
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/SS2604"
	},
	voices = {
		"story_v_out_426111.awb"
	}
}
