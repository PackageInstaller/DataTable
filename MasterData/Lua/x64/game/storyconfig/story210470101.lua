return {
	Play1104701001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104701001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104701002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST05a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05a")
				var_4_0.name = "ST05a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST05a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST05a

				arg_1_1.bgs_.ST05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST05a" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_club", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 0.625

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

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1104701001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 25 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 25)

				if (25 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 25)) > 0 and var_4_14 < var_4_18 then
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
	Play1104701002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1104701002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1104701003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			if arg_8_1.time_ >= 0 + 0.3 and arg_8_1.time_ < 0 + 0.3 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			if 0.2 < arg_8_1.time_ and arg_8_1.time_ <= 0.2 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_130", "se_story_130_paper", "")
			end

			local var_11_1 = 0
			local var_11_2 = 1.425

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1104701002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 57 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 57)

				if (57 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 57)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1104701003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1104701003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1104701004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= 0 + 0.3 and arg_12_1.time_ < 0 + 0.3 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_0 = 0
			local var_15_1 = 1.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1104701003).content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 53 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_2) / 53)

				if (53 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_2) / 53)) > 0 and var_15_1 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_5 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_5 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_5

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_5 and arg_12_1.time_ < var_15_0 + var_15_5 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1104701004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1104701004
		arg_16_1.duration_ = 3.67

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1104701005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= 0 + 0.3 and arg_16_1.time_ < 0 + 0.3 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			if 0.1 < arg_16_1.time_ and arg_16_1.time_ <= 0.1 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_side_128402", "se_story_side_128402_cup", "")
			end

			local var_19_1 = 0
			local var_19_2 = 0.55

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(1104701004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 22 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 22)

				if (22 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 22)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb")

						arg_16_1:RecordAudio("1104701004", var_19_8)
						arg_16_1:RecordAudio("1104701004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701004", "story_v_side_new_1104701.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_9 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_9 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_9

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_9 and arg_16_1.time_ < var_19_1 + var_19_9 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1104701005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1104701005
		arg_20_1.duration_ = 7.2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1104701006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= 0 + 0.3 and arg_20_1.time_ < 0 + 0.3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_0 = 0
			local var_23_1 = 0.875

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_2 = arg_20_1:GetWordFromCfg(1104701005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 35 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 35)

				if (35 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 35)) > 0 and var_23_1 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb") ~= 0 then
					local var_23_6 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb") / 1000

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end

					if var_23_2.prefab_name ~= "" and arg_20_1.actors_[var_23_2.prefab_name] ~= nil then
						local var_23_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_2.prefab_name].transform, "story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb")

						arg_20_1:RecordAudio("1104701005", var_23_7)
						arg_20_1:RecordAudio("1104701005", var_23_7)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701005", "story_v_side_new_1104701.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1104701006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1104701006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1104701007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			if arg_24_1.time_ >= 0 + 0.3 and arg_24_1.time_ < 0 + 0.3 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_0 = 0
			local var_27_1 = 0.05

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_2 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(1104701006).content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 2 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_2) / 2)

				if (2 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_2) / 2)) > 0 and var_27_1 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_5 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_5 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_5

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_5 and arg_24_1.time_ < var_27_0 + var_27_5 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1104701007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1104701007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1104701008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= 0 + 0.3 and arg_28_1.time_ < 0 + 0.3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_0 = 0
			local var_31_1 = 0.8

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(1104701007).content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 32 <= 0 and var_31_1 or var_31_1 * (utf8.len(var_31_2) / 32)

				if (32 <= 0 and var_31_1 or var_31_1 * (utf8.len(var_31_2) / 32)) > 0 and var_31_1 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_5 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_5 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_5

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_5 and arg_28_1.time_ < var_31_0 + var_31_5 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1104701008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1104701008
		arg_32_1.duration_ = 1

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"

			SetActive(arg_32_1.choicesGo_, true)

			for iter_33_0, iter_33_1 in ipairs(arg_32_1.choices_) do
				SetActive(iter_33_1.go, iter_33_0 <= 2)
			end

			arg_32_1.choices_[1].txt.text = arg_32_1:FormatText(StoryChoiceCfg[1649].name)
			arg_32_1.choices_[2].txt.text = arg_32_1:FormatText(StoryChoiceCfg[1650].name)
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1104701009(arg_32_1)
			end

			if arg_34_0 == 2 then
				arg_32_0:Play1104701009(arg_32_1)
			end

			arg_32_1:RecordChoiceLog(1104701008, 1649, 1650)
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= 0 + 0.3 and arg_32_1.time_ < 0 + 0.3 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1104701009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1104701009
		arg_36_1.duration_ = 2.97

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1104701010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "1047ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1047ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["1047ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["1047ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["1047ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1047ui_story = var_39_3.localPosition
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_36_1.time_ - 0) / var_39_4)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			local var_39_5 = arg_36_1.actors_["1047ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1047ui_story == nil then
				arg_36_1.var_.characterEffect1047ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 and not isNil(var_39_5) then
				if arg_36_1.var_.characterEffect1047ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1047ui_story then
				arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_39_8 = "1047ui_story"

			if arg_36_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_39_9 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_36_1.stage_.transform)

				var_39_9.name = var_39_8
				var_39_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_[var_39_8] = var_39_9

				local var_39_10 = var_39_9:GetComponentInChildren(typeof(CharacterEffect))

				var_39_10.enabled = true

				local var_39_11 = GameObjectTools.GetOrAddComponent(var_39_9, typeof(DynamicBoneHelper))

				if var_39_11 then
					var_39_11:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_10.transform, false)

				arg_36_1.var_[var_39_8 .. "Animator"] = var_39_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_[var_39_8 .. "Animator"].applyRootMotion = true
				arg_36_1.var_[var_39_8 .. "LipSync"] = var_39_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_39_12 = "1047ui_story"

			if arg_36_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_39_13 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_36_1.stage_.transform)

				var_39_13.name = var_39_12
				var_39_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_[var_39_12] = var_39_13

				local var_39_14 = var_39_13:GetComponentInChildren(typeof(CharacterEffect))

				var_39_14.enabled = true

				local var_39_15 = GameObjectTools.GetOrAddComponent(var_39_13, typeof(DynamicBoneHelper))

				if var_39_15 then
					var_39_15:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_14.transform, false)

				arg_36_1.var_[var_39_12 .. "Animator"] = var_39_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_[var_39_12 .. "Animator"].applyRootMotion = true
				arg_36_1.var_[var_39_12 .. "LipSync"] = var_39_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_39_16 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_16 + 0.3 and arg_36_1.time_ < var_39_16 + 0.3 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_17 = 0
			local var_39_18 = 0.425

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(1104701009)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_22 = 17 <= 0 and var_39_18 or var_39_18 * (utf8.len(var_39_20) / 17)

				if (17 <= 0 and var_39_18 or var_39_18 * (utf8.len(var_39_20) / 17)) > 0 and var_39_18 < var_39_22 then
					arg_36_1.talkMaxDuration = var_39_22

					if var_39_22 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_17
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb") ~= 0 then
					local var_39_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb") / 1000

					if var_39_23 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_17
					end

					if var_39_19.prefab_name ~= "" and arg_36_1.actors_[var_39_19.prefab_name] ~= nil then
						local var_39_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_19.prefab_name].transform, "story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb")

						arg_36_1:RecordAudio("1104701009", var_39_24)
						arg_36_1:RecordAudio("1104701009", var_39_24)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701009", "story_v_side_new_1104701.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = math.max(var_39_18, arg_36_1.talkMaxDuration)

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_17) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_17 + var_39_25 and arg_36_1.time_ < var_39_17 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1104701010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1104701011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) and arg_40_1.var_.characterEffect1047ui_story == nil then
				arg_40_1.var_.characterEffect1047ui_story = arg_40_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) then
				if arg_40_1.var_.characterEffect1047ui_story and not isNil(arg_40_1.actors_["1047ui_story"]) then
					arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) and arg_40_1.var_.characterEffect1047ui_story then
				arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_43_1 = arg_40_1.actors_["1047ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1047ui_story = var_43_1.localPosition
			end

			local var_43_2 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 then
				var_43_1.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_2)
				var_43_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_1.position).x, (manager.ui.mainCamera.transform.position - var_43_1.position).y, (manager.ui.mainCamera.transform.position - var_43_1.position).z)
				var_43_1.localEulerAngles.z = 0
				var_43_1.localEulerAngles.x = 0
				var_43_1.localEulerAngles = var_43_1.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 then
				var_43_1.localPosition = Vector3.New(0, 100, 0)
				var_43_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_1.position).x, (manager.ui.mainCamera.transform.position - var_43_1.position).y, (manager.ui.mainCamera.transform.position - var_43_1.position).z)
				var_43_1.localEulerAngles.z = 0
				var_43_1.localEulerAngles.x = 0
				var_43_1.localEulerAngles = var_43_1.localEulerAngles
			end

			local var_43_3 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			if arg_40_1.time_ >= var_43_3 + 0.133333333333333 and arg_40_1.time_ < var_43_3 + 0.133333333333333 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			if 0.1 < arg_40_1.time_ and arg_40_1.time_ <= 0.1 + arg_43_0 then
				arg_40_1:AudioAction("play", "effect", "se_story_140", "se_story_140_snap", "")
			end

			local var_43_5 = 0
			local var_43_6 = 1.35

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(1104701010).content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 54 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_7) / 54)

				if (54 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_7) / 54)) > 0 and var_43_6 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_5) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_5 + var_43_10 and arg_40_1.time_ < var_43_5 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play1104701011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1104701011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1104701012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			if arg_44_1.time_ >= 0 + 0.3 and arg_44_1.time_ < 0 + 0.3 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_0 = 0
			local var_47_1 = 0.625

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
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

				local var_47_2 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1104701011).content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 25 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_2) / 25)

				if (25 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_2) / 25)) > 0 and var_47_1 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_5 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_5 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_5

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_5 and arg_44_1.time_ < var_47_0 + var_47_5 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1104701012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1104701012
		arg_48_1.duration_ = 8.27

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1104701013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1047ui_story = arg_48_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1047ui_story"].transform.position).z)
				arg_48_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1047ui_story"].transform.localEulerAngles = arg_48_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_48_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1047ui_story"].transform.position).z)
				arg_48_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1047ui_story"].transform.localEulerAngles = arg_48_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["1047ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1047ui_story == nil then
				arg_48_1.var_.characterEffect1047ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect1047ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1047ui_story then
				arg_48_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_4 = 0

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			if arg_48_1.time_ >= var_51_4 + 0.3 and arg_48_1.time_ < var_51_4 + 0.3 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_5 = 0
			local var_51_6 = 0.875

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:GetWordFromCfg(1104701012)
				local var_51_8 = arg_48_1:FormatText(var_51_7.content)

				arg_48_1.text_.text = var_51_8

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_10 = 35 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 35)

				if (35 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 35)) > 0 and var_51_6 < var_51_10 then
					arg_48_1.talkMaxDuration = var_51_10

					if var_51_10 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_8
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb") ~= 0 then
					local var_51_11 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb") / 1000

					if var_51_11 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_5
					end

					if var_51_7.prefab_name ~= "" and arg_48_1.actors_[var_51_7.prefab_name] ~= nil then
						local var_51_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_7.prefab_name].transform, "story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb")

						arg_48_1:RecordAudio("1104701012", var_51_12)
						arg_48_1:RecordAudio("1104701012", var_51_12)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701012", "story_v_side_new_1104701.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_13 and arg_48_1.time_ < var_51_5 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1104701013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1104701014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1047ui_story"]) and arg_52_1.var_.characterEffect1047ui_story == nil then
				arg_52_1.var_.characterEffect1047ui_story = arg_52_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1047ui_story"]) then
				if arg_52_1.var_.characterEffect1047ui_story and not isNil(arg_52_1.actors_["1047ui_story"]) then
					arg_52_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1047ui_story"]) and arg_52_1.var_.characterEffect1047ui_story then
				arg_52_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			if arg_52_1.time_ >= var_55_1 + 0.3 and arg_52_1.time_ < var_55_1 + 0.3 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_2 = 0
			local var_55_3 = 0.4

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_4 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(1104701013).content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 16 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_4) / 16)

				if (16 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_4) / 16)) > 0 and var_55_3 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_7 and arg_52_1.time_ < var_55_2 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1104701014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1104701014
		arg_56_1.duration_ = 6.53

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1104701015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1047ui_story"]) and arg_56_1.var_.characterEffect1047ui_story == nil then
				arg_56_1.var_.characterEffect1047ui_story = arg_56_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1047ui_story"]) then
				if arg_56_1.var_.characterEffect1047ui_story and not isNil(arg_56_1.actors_["1047ui_story"]) then
					arg_56_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1047ui_story"]) and arg_56_1.var_.characterEffect1047ui_story then
				arg_56_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action434")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_59_2 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_2 + 0.3 and arg_56_1.time_ < var_59_2 + 0.3 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			local var_59_3 = 0
			local var_59_4 = 0.825

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_5 = arg_56_1:GetWordFromCfg(1104701014)
				local var_59_6 = arg_56_1:FormatText(var_59_5.content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_8 = 33 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_6) / 33)

				if (33 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_6) / 33)) > 0 and var_59_4 < var_59_8 then
					arg_56_1.talkMaxDuration = var_59_8

					if var_59_8 + var_59_3 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_3
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb") ~= 0 then
					local var_59_9 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb") / 1000

					if var_59_9 + var_59_3 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_3
					end

					if var_59_5.prefab_name ~= "" and arg_56_1.actors_[var_59_5.prefab_name] ~= nil then
						local var_59_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_5.prefab_name].transform, "story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb")

						arg_56_1:RecordAudio("1104701014", var_59_10)
						arg_56_1:RecordAudio("1104701014", var_59_10)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701014", "story_v_side_new_1104701.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_4, arg_56_1.talkMaxDuration)

			if var_59_3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_3 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_3) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_3 + var_59_11 and arg_56_1.time_ < var_59_3 + var_59_11 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1104701015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1104701015
		arg_60_1.duration_ = 5.73

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1104701016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_0 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= var_63_0 + 0.3 and arg_60_1.time_ < var_63_0 + 0.3 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_1 = 0
			local var_63_2 = 0.65

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(1104701015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 26 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 26)

				if (26 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 26)) > 0 and var_63_2 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb") ~= 0 then
					local var_63_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb") / 1000

					if var_63_7 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_1
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb")

						arg_60_1:RecordAudio("1104701015", var_63_8)
						arg_60_1:RecordAudio("1104701015", var_63_8)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701015", "story_v_side_new_1104701.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_9 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_9 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_9

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_9 and arg_60_1.time_ < var_63_1 + var_63_9 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1104701016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1104701016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1104701017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) and arg_64_1.var_.characterEffect1047ui_story == nil then
				arg_64_1.var_.characterEffect1047ui_story = arg_64_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) then
				if arg_64_1.var_.characterEffect1047ui_story and not isNil(arg_64_1.actors_["1047ui_story"]) then
					arg_64_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) and arg_64_1.var_.characterEffect1047ui_story then
				arg_64_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.45

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(1104701016).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 18 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 18)

				if (18 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 18)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1104701017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1104701017
		arg_68_1.duration_ = 3.6

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1104701018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) and arg_68_1.var_.characterEffect1047ui_story == nil then
				arg_68_1.var_.characterEffect1047ui_story = arg_68_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) then
				if arg_68_1.var_.characterEffect1047ui_story and not isNil(arg_68_1.actors_["1047ui_story"]) then
					arg_68_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) and arg_68_1.var_.characterEffect1047ui_story then
				arg_68_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_71_2 = 0
			local var_71_3 = 0.4

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(1104701017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 16 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 16)

				if (16 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 16)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb")

						arg_68_1:RecordAudio("1104701017", var_71_9)
						arg_68_1:RecordAudio("1104701017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701017", "story_v_side_new_1104701.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1104701018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1104701018
		arg_72_1.duration_ = 7.57

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1104701019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_0 = 0
			local var_75_1 = 0.875

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(1104701018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 35 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 35)

				if (35 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 35)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb")

						arg_72_1:RecordAudio("1104701018", var_75_7)
						arg_72_1:RecordAudio("1104701018", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701018", "story_v_side_new_1104701.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1104701019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1104701019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1104701020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1047ui_story"]) and arg_76_1.var_.characterEffect1047ui_story == nil then
				arg_76_1.var_.characterEffect1047ui_story = arg_76_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1047ui_story"]) then
				if arg_76_1.var_.characterEffect1047ui_story and not isNil(arg_76_1.actors_["1047ui_story"]) then
					arg_76_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1047ui_story"]) and arg_76_1.var_.characterEffect1047ui_story then
				arg_76_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.625

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

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(1104701019).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 25 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 25)

				if (25 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 25)) > 0 and var_79_2 < var_79_5 then
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
	Play1104701020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1104701020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1104701021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1047ui_story = arg_80_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1047ui_story"].transform.position).z)
				arg_80_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1047ui_story"].transform.localEulerAngles = arg_80_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1047ui_story"].transform.position).z)
				arg_80_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1047ui_story"].transform.localEulerAngles = arg_80_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0.2 < arg_80_1.time_ and arg_80_1.time_ <= 0.2 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_140", "se_story_140_glasses", "")
			end

			local var_83_2 = 0
			local var_83_3 = 0.8

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(1104701020).content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 32 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_4) / 32)

				if (32 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_4) / 32)) > 0 and var_83_3 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_7 and arg_80_1.time_ < var_83_2 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play1104701021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1104701021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1104701022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.8

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(1104701021).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 32 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 32)

				if (32 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 32)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1104701022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1104701022
		arg_88_1.duration_ = 13.8

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1104701023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1047ui_story = arg_88_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).z)
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles = arg_88_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_88_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).z)
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles = arg_88_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["1047ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1047ui_story == nil then
				arg_88_1.var_.characterEffect1047ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect1047ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1047ui_story then
				arg_88_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_4 = 0
			local var_91_5 = 1.275

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(1104701022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 51 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 51)

				if (51 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 51)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb")

						arg_88_1:RecordAudio("1104701022", var_91_11)
						arg_88_1:RecordAudio("1104701022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701022", "story_v_side_new_1104701.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play1104701023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1104701023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1104701024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1047ui_story"]) and arg_92_1.var_.characterEffect1047ui_story == nil then
				arg_92_1.var_.characterEffect1047ui_story = arg_92_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1047ui_story"]) then
				if arg_92_1.var_.characterEffect1047ui_story and not isNil(arg_92_1.actors_["1047ui_story"]) then
					arg_92_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1047ui_story"]) and arg_92_1.var_.characterEffect1047ui_story then
				arg_92_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_95_1 = 0
			local var_95_2 = 0.35

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(1104701023).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 14 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 14)

				if (14 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 14)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1104701024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1104701024
		arg_96_1.duration_ = 9.53

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1104701025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1047ui_story"]) and arg_96_1.var_.characterEffect1047ui_story == nil then
				arg_96_1.var_.characterEffect1047ui_story = arg_96_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1047ui_story"]) then
				if arg_96_1.var_.characterEffect1047ui_story and not isNil(arg_96_1.actors_["1047ui_story"]) then
					arg_96_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1047ui_story"]) and arg_96_1.var_.characterEffect1047ui_story then
				arg_96_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action469")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_2 = 0
			local var_99_3 = 0.975

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(1104701024)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 39 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 39)

				if (39 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 39)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb")

						arg_96_1:RecordAudio("1104701024", var_99_9)
						arg_96_1:RecordAudio("1104701024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701024", "story_v_side_new_1104701.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play1104701025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1104701025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1104701026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) and arg_100_1.var_.characterEffect1047ui_story == nil then
				arg_100_1.var_.characterEffect1047ui_story = arg_100_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) then
				if arg_100_1.var_.characterEffect1047ui_story and not isNil(arg_100_1.actors_["1047ui_story"]) then
					arg_100_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) and arg_100_1.var_.characterEffect1047ui_story then
				arg_100_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_103_1 = arg_100_1.actors_["1047ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1047ui_story = var_103_1.localPosition
			end

			local var_103_2 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 then
				var_103_1.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_2)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 then
				var_103_1.localPosition = Vector3.New(0, 100, 0)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			local var_103_3 = 0
			local var_103_4 = 0.675

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(1104701025).content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 27 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 27)

				if (27 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 27)) > 0 and var_103_4 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_3
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_4, arg_100_1.talkMaxDuration)

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_3) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_3 + var_103_8 and arg_100_1.time_ < var_103_3 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play1104701026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1104701026
		arg_104_1.duration_ = 9.6

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1104701027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1047ui_story = arg_104_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1047ui_story"].transform.position).z)
				arg_104_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1047ui_story"].transform.localEulerAngles = arg_104_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_104_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1047ui_story"].transform.position).z)
				arg_104_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1047ui_story"].transform.localEulerAngles = arg_104_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_107_1 = arg_104_1.actors_["1047ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1047ui_story == nil then
				arg_104_1.var_.characterEffect1047ui_story = var_107_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 and not isNil(var_107_1) then
				if arg_104_1.var_.characterEffect1047ui_story and not isNil(var_107_1) then
					arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1047ui_story then
				arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_107_4 = 0
			local var_107_5 = 0.95

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(1104701026)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 38 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 38)

				if (38 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 38)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb")

						arg_104_1:RecordAudio("1104701026", var_107_11)
						arg_104_1:RecordAudio("1104701026", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701026", "story_v_side_new_1104701.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play1104701027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1104701027
		arg_108_1.duration_ = 15.67

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1104701028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1047ui_story = arg_108_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1047ui_story"].transform.position).z)
				arg_108_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1047ui_story"].transform.localEulerAngles = arg_108_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_108_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1047ui_story"].transform.position).z)
				arg_108_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1047ui_story"].transform.localEulerAngles = arg_108_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_111_1 = 0
			local var_111_2 = 1.65

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(1104701027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 66 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 66)

				if (66 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 66)) > 0 and var_111_2 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb") ~= 0 then
					local var_111_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb") / 1000

					if var_111_7 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_1
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb")

						arg_108_1:RecordAudio("1104701027", var_111_8)
						arg_108_1:RecordAudio("1104701027", var_111_8)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701027", "story_v_side_new_1104701.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_9 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_9 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_9

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_9 and arg_108_1.time_ < var_111_1 + var_111_9 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play1104701028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1104701028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1104701029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) and arg_112_1.var_.characterEffect1047ui_story == nil then
				arg_112_1.var_.characterEffect1047ui_story = arg_112_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) then
				if arg_112_1.var_.characterEffect1047ui_story and not isNil(arg_112_1.actors_["1047ui_story"]) then
					arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) and arg_112_1.var_.characterEffect1047ui_story then
				arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_115_1 = 0
			local var_115_2 = 0.05

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(1104701028).content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 2 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 2)

				if (2 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 2)) > 0 and var_115_2 < var_115_5 then
					arg_112_1.talkMaxDuration = var_115_5

					if var_115_5 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_6 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_6 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_6

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_6 and arg_112_1.time_ < var_115_1 + var_115_6 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1104701029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1104701029
		arg_116_1.duration_ = 6.67

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1104701030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1047ui_story = arg_116_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).z)
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles = arg_116_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_116_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).z)
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles = arg_116_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1047ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1047ui_story == nil then
				arg_116_1.var_.characterEffect1047ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1047ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1047ui_story then
				arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_119_4 = 0
			local var_119_5 = 0.625

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(1104701029)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 25 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 25)

				if (25 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 25)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb")

						arg_116_1:RecordAudio("1104701029", var_119_11)
						arg_116_1:RecordAudio("1104701029", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701029", "story_v_side_new_1104701.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1104701030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1104701031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1047ui_story"]) and arg_120_1.var_.characterEffect1047ui_story == nil then
				arg_120_1.var_.characterEffect1047ui_story = arg_120_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1047ui_story"]) then
				if arg_120_1.var_.characterEffect1047ui_story and not isNil(arg_120_1.actors_["1047ui_story"]) then
					arg_120_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1047ui_story"]) and arg_120_1.var_.characterEffect1047ui_story then
				arg_120_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_123_1 = 0
			local var_123_2 = 0.875

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
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

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(1104701030).content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 35 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 35)

				if (35 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 35)) > 0 and var_123_2 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_6 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_6 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_6

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_6 and arg_120_1.time_ < var_123_1 + var_123_6 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1104701031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1104701031
		arg_124_1.duration_ = 8.3

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1104701032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1047ui_story"]) and arg_124_1.var_.characterEffect1047ui_story == nil then
				arg_124_1.var_.characterEffect1047ui_story = arg_124_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1047ui_story"]) then
				if arg_124_1.var_.characterEffect1047ui_story and not isNil(arg_124_1.actors_["1047ui_story"]) then
					arg_124_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1047ui_story"]) and arg_124_1.var_.characterEffect1047ui_story then
				arg_124_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_127_2 = 0
			local var_127_3 = 0.8

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(1104701031)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 32 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 32)

				if (32 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 32)) > 0 and var_127_3 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb") / 1000

					if var_127_8 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_2
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb")

						arg_124_1:RecordAudio("1104701031", var_127_9)
						arg_124_1:RecordAudio("1104701031", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701031", "story_v_side_new_1104701.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_10 and arg_124_1.time_ < var_127_2 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1104701032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1104701032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1104701033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1047ui_story"]) and arg_128_1.var_.characterEffect1047ui_story == nil then
				arg_128_1.var_.characterEffect1047ui_story = arg_128_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1047ui_story"]) then
				if arg_128_1.var_.characterEffect1047ui_story and not isNil(arg_128_1.actors_["1047ui_story"]) then
					arg_128_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_0)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1047ui_story"]) and arg_128_1.var_.characterEffect1047ui_story then
				arg_128_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_131_1 = arg_128_1.actors_["1047ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1047ui_story = var_131_1.localPosition
			end

			local var_131_2 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 then
				var_131_1.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_2)
				var_131_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_1.position).x, (manager.ui.mainCamera.transform.position - var_131_1.position).y, (manager.ui.mainCamera.transform.position - var_131_1.position).z)
				var_131_1.localEulerAngles.z = 0
				var_131_1.localEulerAngles.x = 0
				var_131_1.localEulerAngles = var_131_1.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 then
				var_131_1.localPosition = Vector3.New(0, 100, 0)
				var_131_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_1.position).x, (manager.ui.mainCamera.transform.position - var_131_1.position).y, (manager.ui.mainCamera.transform.position - var_131_1.position).z)
				var_131_1.localEulerAngles.z = 0
				var_131_1.localEulerAngles.x = 0
				var_131_1.localEulerAngles = var_131_1.localEulerAngles
			end

			local var_131_3 = 0
			local var_131_4 = 0.925

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

				local var_131_5 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(1104701032).content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 37 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_5) / 37)

				if (37 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_5) / 37)) > 0 and var_131_4 < var_131_7 then
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

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play1104701033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1104701033
		arg_132_1.duration_ = 1.33

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1104701034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.15

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_1 = arg_132_1:GetWordFromCfg(1104701033)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 6 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 6)

				if (6 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 6)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb")

						arg_132_1:RecordAudio("1104701033", var_135_6)
						arg_132_1:RecordAudio("1104701033", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701033", "story_v_side_new_1104701.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1104701034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1104701034
		arg_136_1.duration_ = 2.4

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1104701035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1047ui_story = arg_136_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).z)
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles = arg_136_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_136_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1047ui_story"].transform.position).z)
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1047ui_story"].transform.localEulerAngles = arg_136_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["1047ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1047ui_story == nil then
				arg_136_1.var_.characterEffect1047ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect1047ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1047ui_story then
				arg_136_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_139_4 = 0
			local var_139_5 = 0.125

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(1104701034)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 5 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 5)

				if (5 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 5)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb")

						arg_136_1:RecordAudio("1104701034", var_139_11)
						arg_136_1:RecordAudio("1104701034", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701034", "story_v_side_new_1104701.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play1104701035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1104701035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1104701036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) and arg_140_1.var_.characterEffect1047ui_story == nil then
				arg_140_1.var_.characterEffect1047ui_story = arg_140_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) then
				if arg_140_1.var_.characterEffect1047ui_story and not isNil(arg_140_1.actors_["1047ui_story"]) then
					arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) and arg_140_1.var_.characterEffect1047ui_story then
				arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.375

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1104701035).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 15 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 15)

				if (15 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 15)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1104701036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1104701036
		arg_144_1.duration_ = 7.23

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1104701037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1047ui_story"]) and arg_144_1.var_.characterEffect1047ui_story == nil then
				arg_144_1.var_.characterEffect1047ui_story = arg_144_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1047ui_story"]) then
				if arg_144_1.var_.characterEffect1047ui_story and not isNil(arg_144_1.actors_["1047ui_story"]) then
					arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1047ui_story"]) and arg_144_1.var_.characterEffect1047ui_story then
				arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_147_2 = 0
			local var_147_3 = 0.75

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(1104701036)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 30 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 30)

				if (30 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 30)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb")

						arg_144_1:RecordAudio("1104701036", var_147_9)
						arg_144_1:RecordAudio("1104701036", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701036", "story_v_side_new_1104701.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1104701037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1104701037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1104701038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1047ui_story"]) and arg_148_1.var_.characterEffect1047ui_story == nil then
				arg_148_1.var_.characterEffect1047ui_story = arg_148_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1047ui_story"]) then
				if arg_148_1.var_.characterEffect1047ui_story and not isNil(arg_148_1.actors_["1047ui_story"]) then
					arg_148_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1047ui_story"]) and arg_148_1.var_.characterEffect1047ui_story then
				arg_148_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_151_1 = arg_148_1.actors_["1047ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1047ui_story = var_151_1.localPosition
			end

			local var_151_2 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 then
				var_151_1.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_2)
				var_151_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_1.position).x, (manager.ui.mainCamera.transform.position - var_151_1.position).y, (manager.ui.mainCamera.transform.position - var_151_1.position).z)
				var_151_1.localEulerAngles.z = 0
				var_151_1.localEulerAngles.x = 0
				var_151_1.localEulerAngles = var_151_1.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 then
				var_151_1.localPosition = Vector3.New(0, 100, 0)
				var_151_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_1.position).x, (manager.ui.mainCamera.transform.position - var_151_1.position).y, (manager.ui.mainCamera.transform.position - var_151_1.position).z)
				var_151_1.localEulerAngles.z = 0
				var_151_1.localEulerAngles.x = 0
				var_151_1.localEulerAngles = var_151_1.localEulerAngles
			end

			local var_151_3 = 0
			local var_151_4 = 0.975

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_5 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(1104701037).content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 39 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_5) / 39)

				if (39 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_5) / 39)) > 0 and var_151_4 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_3
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_4, arg_148_1.talkMaxDuration)

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_3) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_3 + var_151_8 and arg_148_1.time_ < var_151_3 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play1104701038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1104701038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1104701039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.975

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_1 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(1104701038).content)

				arg_152_1.text_.text = var_155_1

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_3 = 39 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 39)

				if (39 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 39)) > 0 and var_155_0 < var_155_3 then
					arg_152_1.talkMaxDuration = var_155_3

					if var_155_3 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_3 + 0
					end
				end

				arg_152_1.text_.text = var_155_1
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_4 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_4

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1104701039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1104701039
		arg_156_1.duration_ = 2.47

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1104701040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1047ui_story = arg_156_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).z)
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles = arg_156_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_156_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).z)
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles = arg_156_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1047ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1047ui_story == nil then
				arg_156_1.var_.characterEffect1047ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1047ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1047ui_story then
				arg_156_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_159_4 = 0
			local var_159_5 = 0.3

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(1104701039)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 12 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 12)

				if (12 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 12)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb")

						arg_156_1:RecordAudio("1104701039", var_159_11)
						arg_156_1:RecordAudio("1104701039", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701039", "story_v_side_new_1104701.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_12 and arg_156_1.time_ < var_159_4 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play1104701040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1104701040
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1104701041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1047ui_story"]) and arg_160_1.var_.characterEffect1047ui_story == nil then
				arg_160_1.var_.characterEffect1047ui_story = arg_160_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1047ui_story"]) then
				if arg_160_1.var_.characterEffect1047ui_story and not isNil(arg_160_1.actors_["1047ui_story"]) then
					arg_160_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1047ui_story"]) and arg_160_1.var_.characterEffect1047ui_story then
				arg_160_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_163_1 = arg_160_1.actors_["1047ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1047ui_story = var_163_1.localPosition
			end

			local var_163_2 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 then
				var_163_1.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_2)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 then
				var_163_1.localPosition = Vector3.New(0, 100, 0)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			local var_163_3 = 0
			local var_163_4 = 0.475

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(1104701040).content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 19 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_5) / 19)

				if (19 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_5) / 19)) > 0 and var_163_4 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_3
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_8 = math.max(var_163_4, arg_160_1.talkMaxDuration)

			if var_163_3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_3 + var_163_8 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_3) / var_163_8

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_3 + var_163_8 and arg_160_1.time_ < var_163_3 + var_163_8 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play1104701041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1104701041
		arg_164_1.duration_ = 4.67

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1104701042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1047ui_story = arg_164_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_167_0 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 then
				arg_164_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_164_1.time_ - 0) / var_167_0)
				arg_164_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1047ui_story"].transform.position).z)
				arg_164_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1047ui_story"].transform.localEulerAngles = arg_164_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 then
				arg_164_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_164_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1047ui_story"].transform.position).z)
				arg_164_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1047ui_story"].transform.localEulerAngles = arg_164_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_167_1 = arg_164_1.actors_["1047ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect1047ui_story == nil then
				arg_164_1.var_.characterEffect1047ui_story = var_167_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_2 and not isNil(var_167_1) then
				if arg_164_1.var_.characterEffect1047ui_story and not isNil(var_167_1) then
					arg_164_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_2 and arg_164_1.time_ < 0 + var_167_2 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect1047ui_story then
				arg_164_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_167_4 = 0
			local var_167_5 = 0.425

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_6 = arg_164_1:GetWordFromCfg(1104701041)
				local var_167_7 = arg_164_1:FormatText(var_167_6.content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 17 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 17)

				if (17 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 17)) > 0 and var_167_5 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_4
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb") ~= 0 then
					local var_167_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb") / 1000

					if var_167_10 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_4
					end

					if var_167_6.prefab_name ~= "" and arg_164_1.actors_[var_167_6.prefab_name] ~= nil then
						local var_167_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_6.prefab_name].transform, "story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb")

						arg_164_1:RecordAudio("1104701041", var_167_11)
						arg_164_1:RecordAudio("1104701041", var_167_11)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701041", "story_v_side_new_1104701.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_12 = math.max(var_167_5, arg_164_1.talkMaxDuration)

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_12 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_4) / var_167_12

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_4 + var_167_12 and arg_164_1.time_ < var_167_4 + var_167_12 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play1104701042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1104701042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1104701043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1047ui_story"]) and arg_168_1.var_.characterEffect1047ui_story == nil then
				arg_168_1.var_.characterEffect1047ui_story = arg_168_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1047ui_story"]) then
				if arg_168_1.var_.characterEffect1047ui_story and not isNil(arg_168_1.actors_["1047ui_story"]) then
					arg_168_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_0)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1047ui_story"]) and arg_168_1.var_.characterEffect1047ui_story then
				arg_168_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_171_1 = 0
			local var_171_2 = 0.875

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_3 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(1104701042).content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 35 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 35)

				if (35 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 35)) > 0 and var_171_2 < var_171_5 then
					arg_168_1.talkMaxDuration = var_171_5

					if var_171_5 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + var_171_1
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_6 = math.max(var_171_2, arg_168_1.talkMaxDuration)

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_6 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_1) / var_171_6

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_1 + var_171_6 and arg_168_1.time_ < var_171_1 + var_171_6 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1104701043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1104701043
		arg_172_1.duration_ = 9

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1104701044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if arg_172_1.bgs_.ST12 == nil then
				local var_175_0 = Object.Instantiate(arg_172_1.paintGo_)

				var_175_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_175_0.name = "ST12"
				var_175_0.transform.parent = arg_172_1.stage_.transform
				var_175_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.bgs_.ST12 = var_175_0
			end

			if 2 < arg_172_1.time_ and arg_172_1.time_ <= 2 + arg_175_0 then
				local var_175_1 = arg_172_1.bgs_.ST12

				arg_172_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_175_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_2 = var_175_1:GetComponent("SpriteRenderer")

				if var_175_2 and var_175_2.sprite then
					local var_175_3 = 2 * (var_175_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_175_1.transform.localScale = Vector3.New(var_175_3 / var_175_2.sprite.bounds.size.y < var_175_3 * manager.ui.mainCameraCom_.aspect / var_175_2.sprite.bounds.size.x and var_175_3 * manager.ui.mainCameraCom_.aspect / var_175_2.sprite.bounds.size.x or var_175_3 / var_175_2.sprite.bounds.size.y, var_175_3 / var_175_2.sprite.bounds.size.y < var_175_3 * manager.ui.mainCameraCom_.aspect / var_175_2.sprite.bounds.size.x and var_175_3 * manager.ui.mainCameraCom_.aspect / var_175_2.sprite.bounds.size.x or var_175_3 / var_175_2.sprite.bounds.size.y, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "ST12" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_4 = 4

			if 4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			if arg_172_1.time_ >= var_175_4 + 0.3 and arg_172_1.time_ < var_175_4 + 0.3 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			local var_175_5 = 0

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_6 = 2

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 then
				local var_175_7 = Color.New(0, 0, 0)

				var_175_7.a = Mathf.Lerp(0, 1, (arg_172_1.time_ - var_175_5) / var_175_6)
				arg_172_1.mask_.color = var_175_7
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 then
				local var_175_8 = Color.New(0, 0, 0)

				var_175_8.a = 1
				arg_172_1.mask_.color = var_175_8
			end

			local var_175_9 = 2

			if 2 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_10 = 2

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_10 then
				local var_175_11 = Color.New(0, 0, 0)

				var_175_11.a = Mathf.Lerp(1, 0, (arg_172_1.time_ - var_175_9) / var_175_10)
				arg_172_1.mask_.color = var_175_11
			end

			if arg_172_1.time_ >= var_175_9 + var_175_10 and arg_172_1.time_ < var_175_9 + var_175_10 + arg_175_0 then
				local var_175_12 = Color.New(0, 0, 0)

				arg_172_1.mask_.enabled = false
				var_175_12.a = 0
				arg_172_1.mask_.color = var_175_12
			end

			local var_175_13 = arg_172_1.actors_["1047ui_story"].transform

			if 1.96599999815226 < arg_172_1.time_ and arg_172_1.time_ <= 1.96599999815226 + arg_175_0 then
				arg_172_1.var_.moveOldPos1047ui_story = var_175_13.localPosition
			end

			local var_175_14 = 0.001

			if 1.96599999815226 <= arg_172_1.time_ and arg_172_1.time_ < 1.96599999815226 + var_175_14 then
				var_175_13.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 1.96599999815226) / var_175_14)
				var_175_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_13.position).x, (manager.ui.mainCamera.transform.position - var_175_13.position).y, (manager.ui.mainCamera.transform.position - var_175_13.position).z)
				var_175_13.localEulerAngles.z = 0
				var_175_13.localEulerAngles.x = 0
				var_175_13.localEulerAngles = var_175_13.localEulerAngles
			end

			if arg_172_1.time_ >= 1.96599999815226 + var_175_14 and arg_172_1.time_ < 1.96599999815226 + var_175_14 + arg_175_0 then
				var_175_13.localPosition = Vector3.New(0, 100, 0)
				var_175_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_13.position).x, (manager.ui.mainCamera.transform.position - var_175_13.position).y, (manager.ui.mainCamera.transform.position - var_175_13.position).z)
				var_175_13.localEulerAngles.z = 0
				var_175_13.localEulerAngles.x = 0
				var_175_13.localEulerAngles = var_175_13.localEulerAngles
			end

			if 0.1 < arg_172_1.time_ and arg_172_1.time_ <= 0.1 + arg_175_0 then
				arg_172_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_club", "")
			end

			if 1.2 < arg_172_1.time_ and arg_172_1.time_ <= 1.2 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_17 = 4
			local var_175_18 = 1.775

			if 4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_17 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_19 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_19:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_172_1.dialogCg_.alpha = arg_176_0
				end))
				var_175_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_20 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(1104701043).content)

				arg_172_1.text_.text = var_175_20

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_22 = 71 <= 0 and var_175_18 or var_175_18 * (utf8.len(var_175_20) / 71)

				if (71 <= 0 and var_175_18 or var_175_18 * (utf8.len(var_175_20) / 71)) > 0 and var_175_18 < var_175_22 then
					arg_172_1.talkMaxDuration = var_175_22
					var_175_17 = var_175_17 + 0.3

					if var_175_22 + var_175_17 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_17
					end
				end

				arg_172_1.text_.text = var_175_20
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_23 = var_175_17 + 0.3
			local var_175_24 = math.max(var_175_18, arg_172_1.talkMaxDuration)

			if var_175_17 + 0.3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_23 + var_175_24 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_23) / var_175_24

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_23 + var_175_24 and arg_172_1.time_ < var_175_23 + var_175_24 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1104701044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1104701044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1104701045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.675

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
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

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(1104701044).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 27 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 27)

				if (27 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 27)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1104701045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1104701045
		arg_182_1.duration_ = 2.2

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1104701046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1047ui_story = arg_182_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).z)
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles = arg_182_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_182_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1047ui_story"].transform.position).z)
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1047ui_story"].transform.localEulerAngles = arg_182_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1047ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1047ui_story == nil then
				arg_182_1.var_.characterEffect1047ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1047ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1047ui_story then
				arg_182_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_185_4 = 0
			local var_185_5 = 0.2

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(1104701045)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 8 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 8)

				if (8 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 8)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb")

						arg_182_1:RecordAudio("1104701045", var_185_11)
						arg_182_1:RecordAudio("1104701045", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701045", "story_v_side_new_1104701.awb")
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
				actorName = "1047ui_story",
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
	Play1104701046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1104701046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1104701047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1047ui_story"]) and arg_186_1.var_.characterEffect1047ui_story == nil then
				arg_186_1.var_.characterEffect1047ui_story = arg_186_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1047ui_story"]) then
				if arg_186_1.var_.characterEffect1047ui_story and not isNil(arg_186_1.actors_["1047ui_story"]) then
					arg_186_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1047ui_story"]) and arg_186_1.var_.characterEffect1047ui_story then
				arg_186_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_189_1 = arg_186_1.actors_["1047ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1047ui_story = var_189_1.localPosition
			end

			local var_189_2 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 then
				var_189_1.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_2)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 then
				var_189_1.localPosition = Vector3.New(0, 100, 0)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			if 0.1 < arg_186_1.time_ and arg_186_1.time_ <= 0.1 + arg_189_0 then
				arg_186_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			local var_189_4 = 0
			local var_189_5 = 1.175

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(1104701046).content)

				arg_186_1.text_.text = var_189_6

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_8 = 47 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_6) / 47)

				if (47 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_6) / 47)) > 0 and var_189_5 < var_189_8 then
					arg_186_1.talkMaxDuration = var_189_8

					if var_189_8 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_6
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_9 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_9 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_9

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_9 and arg_186_1.time_ < var_189_4 + var_189_9 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play1104701047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1104701047
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1104701048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.725

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

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(1104701047).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 29 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 29)

				if (29 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 29)) > 0 and var_193_0 < var_193_3 then
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
	Play1104701048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1104701048
		arg_194_1.duration_ = 8.4

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1104701049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1047ui_story = arg_194_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_197_0 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				arg_194_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1047ui_story"].transform.position).z)
				arg_194_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1047ui_story"].transform.localEulerAngles = arg_194_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				arg_194_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_194_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1047ui_story"].transform.position).z)
				arg_194_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1047ui_story"].transform.localEulerAngles = arg_194_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_197_1 = arg_194_1.actors_["1047ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1047ui_story == nil then
				arg_194_1.var_.characterEffect1047ui_story = var_197_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_2 and not isNil(var_197_1) then
				if arg_194_1.var_.characterEffect1047ui_story and not isNil(var_197_1) then
					arg_194_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_2 and arg_194_1.time_ < 0 + var_197_2 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1047ui_story then
				arg_194_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_197_4 = 0
			local var_197_5 = 0.875

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_6 = arg_194_1:GetWordFromCfg(1104701048)
				local var_197_7 = arg_194_1:FormatText(var_197_6.content)

				arg_194_1.text_.text = var_197_7

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 35 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 35)

				if (35 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 35)) > 0 and var_197_5 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_7
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb") ~= 0 then
					local var_197_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb") / 1000

					if var_197_10 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_4
					end

					if var_197_6.prefab_name ~= "" and arg_194_1.actors_[var_197_6.prefab_name] ~= nil then
						local var_197_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_6.prefab_name].transform, "story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb")

						arg_194_1:RecordAudio("1104701048", var_197_11)
						arg_194_1:RecordAudio("1104701048", var_197_11)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701048", "story_v_side_new_1104701.awb")
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
				actorName = "1047ui_story",
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
	Play1104701049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1104701049
		arg_198_1.duration_ = 6.57

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1104701050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1047ui_story = arg_198_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).z)
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles = arg_198_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_198_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1047ui_story"].transform.position).z)
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1047ui_story"].transform.localEulerAngles = arg_198_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_201_1 = 0
			local var_201_2 = 0.725

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_3 = arg_198_1:GetWordFromCfg(1104701049)
				local var_201_4 = arg_198_1:FormatText(var_201_3.content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_6 = 29 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_4) / 29)

				if (29 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_4) / 29)) > 0 and var_201_2 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb") ~= 0 then
					local var_201_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb") / 1000

					if var_201_7 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_1
					end

					if var_201_3.prefab_name ~= "" and arg_198_1.actors_[var_201_3.prefab_name] ~= nil then
						local var_201_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_3.prefab_name].transform, "story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb")

						arg_198_1:RecordAudio("1104701049", var_201_8)
						arg_198_1:RecordAudio("1104701049", var_201_8)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701049", "story_v_side_new_1104701.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_9 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_9 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_9

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_9 and arg_198_1.time_ < var_201_1 + var_201_9 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play1104701050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1104701050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1104701051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1047ui_story"]) and arg_202_1.var_.characterEffect1047ui_story == nil then
				arg_202_1.var_.characterEffect1047ui_story = arg_202_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1047ui_story"]) then
				if arg_202_1.var_.characterEffect1047ui_story and not isNil(arg_202_1.actors_["1047ui_story"]) then
					arg_202_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1047ui_story"]) and arg_202_1.var_.characterEffect1047ui_story then
				arg_202_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_205_1 = arg_202_1.actors_["1047ui_story"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1047ui_story = var_205_1.localPosition
			end

			local var_205_2 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 then
				var_205_1.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_2)
				var_205_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_1.position).x, (manager.ui.mainCamera.transform.position - var_205_1.position).y, (manager.ui.mainCamera.transform.position - var_205_1.position).z)
				var_205_1.localEulerAngles.z = 0
				var_205_1.localEulerAngles.x = 0
				var_205_1.localEulerAngles = var_205_1.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 then
				var_205_1.localPosition = Vector3.New(0, 100, 0)
				var_205_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_1.position).x, (manager.ui.mainCamera.transform.position - var_205_1.position).y, (manager.ui.mainCamera.transform.position - var_205_1.position).z)
				var_205_1.localEulerAngles.z = 0
				var_205_1.localEulerAngles.x = 0
				var_205_1.localEulerAngles = var_205_1.localEulerAngles
			end

			local var_205_3 = 0
			local var_205_4 = 0.4

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_5 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(1104701050).content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 16 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 16)

				if (16 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 16)) > 0 and var_205_4 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_8 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_3) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_8 and arg_202_1.time_ < var_205_3 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play1104701051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1104701051
		arg_206_1.duration_ = 10.03

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1104701052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1047ui_story = arg_206_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1047ui_story"].transform.position).z)
				arg_206_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1047ui_story"].transform.localEulerAngles = arg_206_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_206_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1047ui_story"].transform.position).z)
				arg_206_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1047ui_story"].transform.localEulerAngles = arg_206_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1047ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1047ui_story == nil then
				arg_206_1.var_.characterEffect1047ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 and not isNil(var_209_1) then
				if arg_206_1.var_.characterEffect1047ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1047ui_story then
				arg_206_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_209_4 = 0
			local var_209_5 = 0.9

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_6 = arg_206_1:GetWordFromCfg(1104701051)
				local var_209_7 = arg_206_1:FormatText(var_209_6.content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 36 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 36)

				if (36 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 36)) > 0 and var_209_5 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb") / 1000

					if var_209_10 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_4
					end

					if var_209_6.prefab_name ~= "" and arg_206_1.actors_[var_209_6.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_6.prefab_name].transform, "story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb")

						arg_206_1:RecordAudio("1104701051", var_209_11)
						arg_206_1:RecordAudio("1104701051", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701051", "story_v_side_new_1104701.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_12 = math.max(var_209_5, arg_206_1.talkMaxDuration)

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_12 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_4) / var_209_12

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_4 + var_209_12 and arg_206_1.time_ < var_209_4 + var_209_12 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play1104701052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1104701052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1104701053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1047ui_story"]) and arg_210_1.var_.characterEffect1047ui_story == nil then
				arg_210_1.var_.characterEffect1047ui_story = arg_210_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1047ui_story"]) then
				if arg_210_1.var_.characterEffect1047ui_story and not isNil(arg_210_1.actors_["1047ui_story"]) then
					arg_210_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1047ui_story"]) and arg_210_1.var_.characterEffect1047ui_story then
				arg_210_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_213_1 = arg_210_1.actors_["1047ui_story"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1047ui_story = var_213_1.localPosition
			end

			local var_213_2 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 then
				var_213_1.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_2)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 then
				var_213_1.localPosition = Vector3.New(0, 100, 0)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			local var_213_3 = 0
			local var_213_4 = 0.8

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_3 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_5 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(1104701052).content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 32 <= 0 and var_213_4 or var_213_4 * (utf8.len(var_213_5) / 32)

				if (32 <= 0 and var_213_4 or var_213_4 * (utf8.len(var_213_5) / 32)) > 0 and var_213_4 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_3 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_3
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_8 = math.max(var_213_4, arg_210_1.talkMaxDuration)

			if var_213_3 <= arg_210_1.time_ and arg_210_1.time_ < var_213_3 + var_213_8 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_3) / var_213_8

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_3 + var_213_8 and arg_210_1.time_ < var_213_3 + var_213_8 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1104701053
		arg_214_1.duration_ = 9.07

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1104701054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1047ui_story = arg_214_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1047ui_story"].transform.position).z)
				arg_214_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1047ui_story"].transform.localEulerAngles = arg_214_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_214_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1047ui_story"].transform.position).z)
				arg_214_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1047ui_story"].transform.localEulerAngles = arg_214_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_217_1 = arg_214_1.actors_["1047ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1047ui_story == nil then
				arg_214_1.var_.characterEffect1047ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_2 and not isNil(var_217_1) then
				if arg_214_1.var_.characterEffect1047ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_2 and arg_214_1.time_ < 0 + var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1047ui_story then
				arg_214_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action453")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_217_4 = 0
			local var_217_5 = 1

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:GetWordFromCfg(1104701053)
				local var_217_7 = arg_214_1:FormatText(var_217_6.content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 40 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 40)

				if (40 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 40)) > 0 and var_217_5 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb") / 1000

					if var_217_10 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_4
					end

					if var_217_6.prefab_name ~= "" and arg_214_1.actors_[var_217_6.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_6.prefab_name].transform, "story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb")

						arg_214_1:RecordAudio("1104701053", var_217_11)
						arg_214_1:RecordAudio("1104701053", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701053", "story_v_side_new_1104701.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_12 and arg_214_1.time_ < var_217_4 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play1104701054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1104701054
		arg_218_1.duration_ = 6.57

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1104701055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1047ui_story = arg_218_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).z)
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles = arg_218_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_218_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).z)
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles = arg_218_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_221_1 = arg_218_1.actors_["1047ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1047ui_story == nil then
				arg_218_1.var_.characterEffect1047ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect1047ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1047ui_story then
				arg_218_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_221_4 = 0
			local var_221_5 = 0.775

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(1104701054)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 31 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 31)

				if (31 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 31)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb")

						arg_218_1:RecordAudio("1104701054", var_221_11)
						arg_218_1:RecordAudio("1104701054", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701054", "story_v_side_new_1104701.awb")
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
				actorName = "1047ui_story",
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
	Play1104701055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1104701055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1104701056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1047ui_story"]) and arg_222_1.var_.characterEffect1047ui_story == nil then
				arg_222_1.var_.characterEffect1047ui_story = arg_222_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1047ui_story"]) then
				if arg_222_1.var_.characterEffect1047ui_story and not isNil(arg_222_1.actors_["1047ui_story"]) then
					arg_222_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_0)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1047ui_story"]) and arg_222_1.var_.characterEffect1047ui_story then
				arg_222_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_225_1 = 0
			local var_225_2 = 0.65

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_3 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(1104701055).content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 26 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 26)

				if (26 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 26)) > 0 and var_225_2 < var_225_5 then
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
	Play1104701056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1104701056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1104701057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.475

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(1104701056).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 19 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 19)

				if (19 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 19)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1104701057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1104701057
		arg_230_1.duration_ = 8.33

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1104701058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1047ui_story"]) and arg_230_1.var_.characterEffect1047ui_story == nil then
				arg_230_1.var_.characterEffect1047ui_story = arg_230_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1047ui_story"]) then
				if arg_230_1.var_.characterEffect1047ui_story and not isNil(arg_230_1.actors_["1047ui_story"]) then
					arg_230_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1047ui_story"]) and arg_230_1.var_.characterEffect1047ui_story then
				arg_230_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_233_2 = 0
			local var_233_3 = 0.9

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_4 = arg_230_1:GetWordFromCfg(1104701057)
				local var_233_5 = arg_230_1:FormatText(var_233_4.content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 36 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 36)

				if (36 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 36)) > 0 and var_233_3 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb") / 1000

					if var_233_8 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_2
					end

					if var_233_4.prefab_name ~= "" and arg_230_1.actors_[var_233_4.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_4.prefab_name].transform, "story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb")

						arg_230_1:RecordAudio("1104701057", var_233_9)
						arg_230_1:RecordAudio("1104701057", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701057", "story_v_side_new_1104701.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_10 and arg_230_1.time_ < var_233_2 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1104701058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1104701058
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1104701059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1047ui_story"]) and arg_234_1.var_.characterEffect1047ui_story == nil then
				arg_234_1.var_.characterEffect1047ui_story = arg_234_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1047ui_story"]) then
				if arg_234_1.var_.characterEffect1047ui_story and not isNil(arg_234_1.actors_["1047ui_story"]) then
					arg_234_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1047ui_story"]) and arg_234_1.var_.characterEffect1047ui_story then
				arg_234_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_237_1 = 0
			local var_237_2 = 0.425

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_3 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(1104701058).content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 17 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 17)

				if (17 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 17)) > 0 and var_237_2 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_1
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_6 = math.max(var_237_2, arg_234_1.talkMaxDuration)

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_6 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_1) / var_237_6

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_1 + var_237_6 and arg_234_1.time_ < var_237_1 + var_237_6 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1104701059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1104701059
		arg_238_1.duration_ = 6.53

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1104701060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1047ui_story = arg_238_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1047ui_story"].transform.position).z)
				arg_238_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1047ui_story"].transform.localEulerAngles = arg_238_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_238_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1047ui_story"].transform.position).z)
				arg_238_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1047ui_story"].transform.localEulerAngles = arg_238_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["1047ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1047ui_story == nil then
				arg_238_1.var_.characterEffect1047ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_2 and not isNil(var_241_1) then
				if arg_238_1.var_.characterEffect1047ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_2 and arg_238_1.time_ < 0 + var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1047ui_story then
				arg_238_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_241_4 = 0
			local var_241_5 = 0.725

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_6 = arg_238_1:GetWordFromCfg(1104701059)
				local var_241_7 = arg_238_1:FormatText(var_241_6.content)

				arg_238_1.text_.text = var_241_7

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_9 = 29 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 29)

				if (29 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 29)) > 0 and var_241_5 < var_241_9 then
					arg_238_1.talkMaxDuration = var_241_9

					if var_241_9 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_4
					end
				end

				arg_238_1.text_.text = var_241_7
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb") ~= 0 then
					local var_241_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb") / 1000

					if var_241_10 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_4
					end

					if var_241_6.prefab_name ~= "" and arg_238_1.actors_[var_241_6.prefab_name] ~= nil then
						local var_241_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_6.prefab_name].transform, "story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb")

						arg_238_1:RecordAudio("1104701059", var_241_11)
						arg_238_1:RecordAudio("1104701059", var_241_11)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701059", "story_v_side_new_1104701.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_12 = math.max(var_241_5, arg_238_1.talkMaxDuration)

			if var_241_4 <= arg_238_1.time_ and arg_238_1.time_ < var_241_4 + var_241_12 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_4) / var_241_12

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_4 + var_241_12 and arg_238_1.time_ < var_241_4 + var_241_12 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play1104701060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1104701060
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1104701061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1047ui_story"]) and arg_242_1.var_.characterEffect1047ui_story == nil then
				arg_242_1.var_.characterEffect1047ui_story = arg_242_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1047ui_story"]) then
				if arg_242_1.var_.characterEffect1047ui_story and not isNil(arg_242_1.actors_["1047ui_story"]) then
					arg_242_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1047ui_story"]) and arg_242_1.var_.characterEffect1047ui_story then
				arg_242_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_245_1 = arg_242_1.actors_["1047ui_story"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1047ui_story = var_245_1.localPosition
			end

			local var_245_2 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 then
				var_245_1.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_2)
				var_245_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_1.position).x, (manager.ui.mainCamera.transform.position - var_245_1.position).y, (manager.ui.mainCamera.transform.position - var_245_1.position).z)
				var_245_1.localEulerAngles.z = 0
				var_245_1.localEulerAngles.x = 0
				var_245_1.localEulerAngles = var_245_1.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 then
				var_245_1.localPosition = Vector3.New(0, 100, 0)
				var_245_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_1.position).x, (manager.ui.mainCamera.transform.position - var_245_1.position).y, (manager.ui.mainCamera.transform.position - var_245_1.position).z)
				var_245_1.localEulerAngles.z = 0
				var_245_1.localEulerAngles.x = 0
				var_245_1.localEulerAngles = var_245_1.localEulerAngles
			end

			if 0.1 < arg_242_1.time_ and arg_242_1.time_ <= 0.1 + arg_245_0 then
				arg_242_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_245_4 = 0
			local var_245_5 = 0.9

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(1104701060).content)

				arg_242_1.text_.text = var_245_6

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_8 = 36 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_6) / 36)

				if (36 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_6) / 36)) > 0 and var_245_5 < var_245_8 then
					arg_242_1.talkMaxDuration = var_245_8

					if var_245_8 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_6
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_9 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_9 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_9

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_9 and arg_242_1.time_ < var_245_4 + var_245_9 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1104701061
		arg_246_1.duration_ = 11.3

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1104701062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1047ui_story = arg_246_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_249_0 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				arg_246_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_246_1.time_ - 0) / var_249_0)
				arg_246_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1047ui_story"].transform.position).z)
				arg_246_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1047ui_story"].transform.localEulerAngles = arg_246_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				arg_246_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_246_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1047ui_story"].transform.position).z)
				arg_246_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1047ui_story"].transform.localEulerAngles = arg_246_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_249_1 = arg_246_1.actors_["1047ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect1047ui_story == nil then
				arg_246_1.var_.characterEffect1047ui_story = var_249_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_2 and not isNil(var_249_1) then
				if arg_246_1.var_.characterEffect1047ui_story and not isNil(var_249_1) then
					arg_246_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_2 and arg_246_1.time_ < 0 + var_249_2 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect1047ui_story then
				arg_246_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_249_4 = 0
			local var_249_5 = 1.375

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_4 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_6 = arg_246_1:GetWordFromCfg(1104701061)
				local var_249_7 = arg_246_1:FormatText(var_249_6.content)

				arg_246_1.text_.text = var_249_7

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_9 = 55 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 55)

				if (55 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 55)) > 0 and var_249_5 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_4
					end
				end

				arg_246_1.text_.text = var_249_7
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb") / 1000

					if var_249_10 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_4
					end

					if var_249_6.prefab_name ~= "" and arg_246_1.actors_[var_249_6.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_6.prefab_name].transform, "story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb")

						arg_246_1:RecordAudio("1104701061", var_249_11)
						arg_246_1:RecordAudio("1104701061", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701061", "story_v_side_new_1104701.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_5, arg_246_1.talkMaxDuration)

			if var_249_4 <= arg_246_1.time_ and arg_246_1.time_ < var_249_4 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_4) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_4 + var_249_12 and arg_246_1.time_ < var_249_4 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play1104701062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1104701062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1104701063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1047ui_story"]) and arg_250_1.var_.characterEffect1047ui_story == nil then
				arg_250_1.var_.characterEffect1047ui_story = arg_250_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1047ui_story"]) then
				if arg_250_1.var_.characterEffect1047ui_story and not isNil(arg_250_1.actors_["1047ui_story"]) then
					arg_250_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1047ui_story"]) and arg_250_1.var_.characterEffect1047ui_story then
				arg_250_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_253_1 = 0
			local var_253_2 = 0.6

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(1104701062).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 24 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 24)

				if (24 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 24)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1104701063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1104701063
		arg_254_1.duration_ = 13.6

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1104701064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1047ui_story = arg_254_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).z)
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles = arg_254_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_254_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).z)
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles = arg_254_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["1047ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1047ui_story == nil then
				arg_254_1.var_.characterEffect1047ui_story = var_257_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 and not isNil(var_257_1) then
				if arg_254_1.var_.characterEffect1047ui_story and not isNil(var_257_1) then
					arg_254_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1047ui_story then
				arg_254_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_257_4 = 0
			local var_257_5 = 1.35

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(1104701063)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 54 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 54)

				if (54 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 54)) > 0 and var_257_5 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb") ~= 0 then
					local var_257_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb") / 1000

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end

					if var_257_6.prefab_name ~= "" and arg_254_1.actors_[var_257_6.prefab_name] ~= nil then
						local var_257_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_6.prefab_name].transform, "story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb")

						arg_254_1:RecordAudio("1104701063", var_257_11)
						arg_254_1:RecordAudio("1104701063", var_257_11)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701063", "story_v_side_new_1104701.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_12 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_12 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_12

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_12 and arg_254_1.time_ < var_257_4 + var_257_12 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play1104701064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1104701064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1104701065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1047ui_story"]) and arg_258_1.var_.characterEffect1047ui_story == nil then
				arg_258_1.var_.characterEffect1047ui_story = arg_258_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1047ui_story"]) then
				if arg_258_1.var_.characterEffect1047ui_story and not isNil(arg_258_1.actors_["1047ui_story"]) then
					arg_258_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1047ui_story"]) and arg_258_1.var_.characterEffect1047ui_story then
				arg_258_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_261_1 = arg_258_1.actors_["1047ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1047ui_story = var_261_1.localPosition
			end

			local var_261_2 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 then
				var_261_1.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_258_1.time_ - 0) / var_261_2)
				var_261_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_1.position).x, (manager.ui.mainCamera.transform.position - var_261_1.position).y, (manager.ui.mainCamera.transform.position - var_261_1.position).z)
				var_261_1.localEulerAngles.z = 0
				var_261_1.localEulerAngles.x = 0
				var_261_1.localEulerAngles = var_261_1.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 then
				var_261_1.localPosition = Vector3.New(0, 100, 0)
				var_261_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_1.position).x, (manager.ui.mainCamera.transform.position - var_261_1.position).y, (manager.ui.mainCamera.transform.position - var_261_1.position).z)
				var_261_1.localEulerAngles.z = 0
				var_261_1.localEulerAngles.x = 0
				var_261_1.localEulerAngles = var_261_1.localEulerAngles
			end

			local var_261_3 = 0
			local var_261_4 = 0.95

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_3 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_5 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(1104701064).content)

				arg_258_1.text_.text = var_261_5

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_7 = 38 <= 0 and var_261_4 or var_261_4 * (utf8.len(var_261_5) / 38)

				if (38 <= 0 and var_261_4 or var_261_4 * (utf8.len(var_261_5) / 38)) > 0 and var_261_4 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_3 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_3
					end
				end

				arg_258_1.text_.text = var_261_5
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_8 = math.max(var_261_4, arg_258_1.talkMaxDuration)

			if var_261_3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_3 + var_261_8 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_3) / var_261_8

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_3 + var_261_8 and arg_258_1.time_ < var_261_3 + var_261_8 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1104701065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1104701065
		arg_262_1.duration_ = 4.33

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1104701066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1047ui_story = arg_262_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_265_0 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 then
				arg_262_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_262_1.time_ - 0) / var_265_0)
				arg_262_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).z)
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles = arg_262_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 then
				arg_262_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_262_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).z)
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles = arg_262_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_265_1 = arg_262_1.actors_["1047ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect1047ui_story == nil then
				arg_262_1.var_.characterEffect1047ui_story = var_265_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 and not isNil(var_265_1) then
				if arg_262_1.var_.characterEffect1047ui_story and not isNil(var_265_1) then
					arg_262_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect1047ui_story then
				arg_262_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_262_1.time_ and arg_262_1.time_ <= 0.1 + arg_265_0 then
				arg_262_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_paper", "")
			end

			local var_265_5 = 0
			local var_265_6 = 0.5

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_7 = arg_262_1:GetWordFromCfg(1104701065)
				local var_265_8 = arg_262_1:FormatText(var_265_7.content)

				arg_262_1.text_.text = var_265_8

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_10 = 20 <= 0 and var_265_6 or var_265_6 * (utf8.len(var_265_8) / 20)

				if (20 <= 0 and var_265_6 or var_265_6 * (utf8.len(var_265_8) / 20)) > 0 and var_265_6 < var_265_10 then
					arg_262_1.talkMaxDuration = var_265_10

					if var_265_10 + var_265_5 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_5
					end
				end

				arg_262_1.text_.text = var_265_8
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb") ~= 0 then
					local var_265_11 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb") / 1000

					if var_265_11 + var_265_5 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_5
					end

					if var_265_7.prefab_name ~= "" and arg_262_1.actors_[var_265_7.prefab_name] ~= nil then
						local var_265_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_7.prefab_name].transform, "story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb")

						arg_262_1:RecordAudio("1104701065", var_265_12)
						arg_262_1:RecordAudio("1104701065", var_265_12)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701065", "story_v_side_new_1104701.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_13 = math.max(var_265_6, arg_262_1.talkMaxDuration)

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_13 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_5) / var_265_13

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_5 + var_265_13 and arg_262_1.time_ < var_265_5 + var_265_13 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play1104701066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1104701066
		arg_266_1.duration_ = 4.3

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1104701067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if arg_266_1.bgs_.STblack == nil then
				local var_269_0 = Object.Instantiate(arg_266_1.paintGo_)

				var_269_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_269_0.name = "STblack"
				var_269_0.transform.parent = arg_266_1.stage_.transform
				var_269_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.bgs_.STblack = var_269_0
			end

			if 2 < arg_266_1.time_ and arg_266_1.time_ <= 2 + arg_269_0 then
				local var_269_1 = arg_266_1.bgs_.STblack

				arg_266_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_269_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_269_2 = var_269_1:GetComponent("SpriteRenderer")

				if var_269_2 and var_269_2.sprite then
					local var_269_3 = 2 * (var_269_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_269_1.transform.localScale = Vector3.New(var_269_3 / var_269_2.sprite.bounds.size.y < var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x and var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x or var_269_3 / var_269_2.sprite.bounds.size.y, var_269_3 / var_269_2.sprite.bounds.size.y < var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x and var_269_3 * manager.ui.mainCameraCom_.aspect / var_269_2.sprite.bounds.size.x or var_269_3 / var_269_2.sprite.bounds.size.y, 0)
				end

				for iter_269_0, iter_269_1 in pairs(arg_266_1.bgs_) do
					if iter_269_0 ~= "STblack" then
						iter_269_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_269_4 = 4

			if 4 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.allBtn_.enabled = false
			end

			if arg_266_1.time_ >= var_269_4 + 0.3 and arg_266_1.time_ < var_269_4 + 0.3 + arg_269_0 then
				arg_266_1.allBtn_.enabled = true
			end

			local var_269_5 = 0

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.mask_.enabled = true
				arg_266_1.mask_.raycastTarget = true

				arg_266_1:SetGaussion(false)
			end

			local var_269_6 = 2

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_6 then
				local var_269_7 = Color.New(0, 0, 0)

				var_269_7.a = Mathf.Lerp(0, 1, (arg_266_1.time_ - var_269_5) / var_269_6)
				arg_266_1.mask_.color = var_269_7
			end

			if arg_266_1.time_ >= var_269_5 + var_269_6 and arg_266_1.time_ < var_269_5 + var_269_6 + arg_269_0 then
				local var_269_8 = Color.New(0, 0, 0)

				var_269_8.a = 1
				arg_266_1.mask_.color = var_269_8
			end

			local var_269_9 = 2

			if 2 < arg_266_1.time_ and arg_266_1.time_ <= var_269_9 + arg_269_0 then
				arg_266_1.mask_.enabled = true
				arg_266_1.mask_.raycastTarget = true

				arg_266_1:SetGaussion(false)
			end

			local var_269_10 = 2

			if var_269_9 <= arg_266_1.time_ and arg_266_1.time_ < var_269_9 + var_269_10 then
				local var_269_11 = Color.New(0, 0, 0)

				var_269_11.a = Mathf.Lerp(1, 0, (arg_266_1.time_ - var_269_9) / var_269_10)
				arg_266_1.mask_.color = var_269_11
			end

			if arg_266_1.time_ >= var_269_9 + var_269_10 and arg_266_1.time_ < var_269_9 + var_269_10 + arg_269_0 then
				local var_269_12 = Color.New(0, 0, 0)

				arg_266_1.mask_.enabled = false
				var_269_12.a = 0
				arg_266_1.mask_.color = var_269_12
			end

			local var_269_13 = arg_266_1.actors_["1047ui_story"]

			if 1.96599999815226 < arg_266_1.time_ and arg_266_1.time_ <= 1.96599999815226 + arg_269_0 and not isNil(var_269_13) and arg_266_1.var_.characterEffect1047ui_story == nil then
				arg_266_1.var_.characterEffect1047ui_story = var_269_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_14 = 0.034000001847744

			if 1.96599999815226 <= arg_266_1.time_ and arg_266_1.time_ < 1.96599999815226 + var_269_14 and not isNil(var_269_13) then
				if arg_266_1.var_.characterEffect1047ui_story and not isNil(var_269_13) then
					arg_266_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 1.96599999815226) / var_269_14)
				end
			end

			if arg_266_1.time_ >= 1.96599999815226 + var_269_14 and arg_266_1.time_ < 1.96599999815226 + var_269_14 + arg_269_0 and not isNil(var_269_13) and arg_266_1.var_.characterEffect1047ui_story then
				arg_266_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_269_15 = arg_266_1.actors_["1047ui_story"].transform

			if 1.96599999815226 < arg_266_1.time_ and arg_266_1.time_ <= 1.96599999815226 + arg_269_0 then
				arg_266_1.var_.moveOldPos1047ui_story = var_269_15.localPosition
			end

			local var_269_16 = 0.001

			if 1.96599999815226 <= arg_266_1.time_ and arg_266_1.time_ < 1.96599999815226 + var_269_16 then
				var_269_15.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 1.96599999815226) / var_269_16)
				var_269_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_15.position).x, (manager.ui.mainCamera.transform.position - var_269_15.position).y, (manager.ui.mainCamera.transform.position - var_269_15.position).z)
				var_269_15.localEulerAngles.z = 0
				var_269_15.localEulerAngles.x = 0
				var_269_15.localEulerAngles = var_269_15.localEulerAngles
			end

			if arg_266_1.time_ >= 1.96599999815226 + var_269_16 and arg_266_1.time_ < 1.96599999815226 + var_269_16 + arg_269_0 then
				var_269_15.localPosition = Vector3.New(0, 100, 0)
				var_269_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_15.position).x, (manager.ui.mainCamera.transform.position - var_269_15.position).y, (manager.ui.mainCamera.transform.position - var_269_15.position).z)
				var_269_15.localEulerAngles.z = 0
				var_269_15.localEulerAngles.x = 0
				var_269_15.localEulerAngles = var_269_15.localEulerAngles
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.fswbg_:SetActive(false)
				arg_266_1.dialog_:SetActive(false)
				SetActive(arg_266_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_266_1:ShowNextGo(false)
			end

			if 0.1 < arg_266_1.time_ and arg_266_1.time_ <= 0.1 + arg_269_0 then
				arg_266_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1104701066,
				charCount = 4,
				enableLayoutChange = true,
				duration = 0.266666666666667,
				groupID = "yizhouhouzhuanchang",
				startTime = 2.9,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play1104701067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1104701067
		arg_270_1.duration_ = 4.9

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1104701068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if arg_270_1.bgs_.B13b == nil then
				local var_273_0 = Object.Instantiate(arg_270_1.paintGo_)

				var_273_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13b")
				var_273_0.name = "B13b"
				var_273_0.transform.parent = arg_270_1.stage_.transform
				var_273_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.bgs_.B13b = var_273_0
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				local var_273_1 = arg_270_1.bgs_.B13b

				arg_270_1.bgs_.B13b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_273_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_2 = var_273_1:GetComponent("SpriteRenderer")

				if var_273_2 and var_273_2.sprite then
					local var_273_3 = 2 * (var_273_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_273_1.transform.localScale = Vector3.New(var_273_3 / var_273_2.sprite.bounds.size.y < var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x and var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x or var_273_3 / var_273_2.sprite.bounds.size.y, var_273_3 / var_273_2.sprite.bounds.size.y < var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x and var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x or var_273_3 / var_273_2.sprite.bounds.size.y, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "B13b" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_4 = 2

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= var_273_4 + 0.3 and arg_270_1.time_ < var_273_4 + 0.3 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			local var_273_5 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_6 = 2

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_6 then
				local var_273_7 = Color.New(0, 0, 0)

				var_273_7.a = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_5) / var_273_6)
				arg_270_1.mask_.color = var_273_7
			end

			if arg_270_1.time_ >= var_273_5 + var_273_6 and arg_270_1.time_ < var_273_5 + var_273_6 + arg_273_0 then
				local var_273_8 = Color.New(0, 0, 0)

				arg_270_1.mask_.enabled = false
				var_273_8.a = 0
				arg_270_1.mask_.color = var_273_8
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.fswbg_:SetActive(false)
				arg_270_1.dialog_:SetActive(false)
				SetActive(arg_270_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_270_1:ShowNextGo(false)
			end

			if 0.1 < arg_270_1.time_ and arg_270_1.time_ <= 0.1 + arg_273_0 then
				arg_270_1:AudioAction("play", "effect", "se_story_147", "se_story_147_amb_rooftop", "")
			end

			if 1 < arg_270_1.time_ and arg_270_1.time_ <= 1 + arg_273_0 then
				arg_270_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_273_12 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_270_1.bgmTxt_.text ~= var_273_12 and arg_270_1.bgmTxt_.text ~= "" then
						if arg_270_1.bgmTxt2_.text ~= "" then
							arg_270_1.bgmTxt_.text = arg_270_1.bgmTxt2_.text
						end

						arg_270_1.bgmTxt2_.text = var_273_12

						arg_270_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_270_1.bgmTxt_.text = var_273_12
						arg_270_1.bgmTxt2_.text = var_273_12
					end

					if arg_270_1.bgmTimer then
						arg_270_1.bgmTimer:Stop()

						arg_270_1.bgmTimer = nil
					end

					if arg_270_1.settingData.show_music_name == 1 then
						arg_270_1.musicController:SetSelectedState("show")
						arg_270_1.musicAnimator_:Play("open", 0, 0)

						if arg_270_1.settingData.music_time ~= 0 then
							arg_270_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_270_1.settingData.music_time), function()
								if arg_270_1 == nil or isNil(arg_270_1.bgmTxt_) then
									return
								end

								arg_270_1.musicController:SetSelectedState("hide")
								arg_270_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_13 = 2
			local var_273_14 = 0.275

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_13 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_15 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_15:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_270_1.dialogCg_.alpha = arg_275_0
				end))
				var_273_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_16 = arg_270_1:GetWordFromCfg(1104701067)
				local var_273_17 = arg_270_1:FormatText(var_273_16.content)

				arg_270_1.text_.text = var_273_17

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_19 = 11 <= 0 and var_273_14 or var_273_14 * (utf8.len(var_273_17) / 11)

				if (11 <= 0 and var_273_14 or var_273_14 * (utf8.len(var_273_17) / 11)) > 0 and var_273_14 < var_273_19 then
					arg_270_1.talkMaxDuration = var_273_19
					var_273_13 = var_273_13 + 0.3

					if var_273_19 + var_273_13 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_19 + var_273_13
					end
				end

				arg_270_1.text_.text = var_273_17
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb") ~= 0 then
					local var_273_20 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb") / 1000

					if var_273_20 + var_273_13 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_20 + var_273_13
					end

					if var_273_16.prefab_name ~= "" and arg_270_1.actors_[var_273_16.prefab_name] ~= nil then
						local var_273_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_16.prefab_name].transform, "story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb")

						arg_270_1:RecordAudio("1104701067", var_273_21)
						arg_270_1:RecordAudio("1104701067", var_273_21)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701067", "story_v_side_new_1104701.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_22 = var_273_13 + 0.3
			local var_273_23 = math.max(var_273_14, arg_270_1.talkMaxDuration)

			if var_273_13 + 0.3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_22 + var_273_23 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_22) / var_273_23

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_22 + var_273_23 and arg_270_1.time_ < var_273_22 + var_273_23 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				groupID = "yizhouhouzhuanchang",
				duration = 0.266666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play1104701068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1104701068
		arg_277_1.duration_ = 4.27

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1104701069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.525

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(1104701068)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 21 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 21)

				if (21 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 21)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb")

						arg_277_1:RecordAudio("1104701068", var_280_6)
						arg_277_1:RecordAudio("1104701068", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701068", "story_v_side_new_1104701.awb")
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
	Play1104701069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1104701069
		arg_281_1.duration_ = 8.93

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1104701070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1.1

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:GetWordFromCfg(1104701069)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 44 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 44)

				if (44 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 44)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb")

						arg_281_1:RecordAudio("1104701069", var_284_6)
						arg_281_1:RecordAudio("1104701069", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701069", "story_v_side_new_1104701.awb")
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
	Play1104701070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1104701070
		arg_285_1.duration_ = 8.3

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1104701071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1047ui_story = arg_285_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1047ui_story"].transform.position).z)
				arg_285_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1047ui_story"].transform.localEulerAngles = arg_285_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_285_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1047ui_story"].transform.position).z)
				arg_285_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1047ui_story"].transform.localEulerAngles = arg_285_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1047ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1047ui_story == nil then
				arg_285_1.var_.characterEffect1047ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1047ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1047ui_story then
				arg_285_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_288_4 = 0
			local var_288_5 = 1.05

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(1104701070)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 42 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 42)

				if (42 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 42)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb")

						arg_285_1:RecordAudio("1104701070", var_288_11)
						arg_285_1:RecordAudio("1104701070", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701070", "story_v_side_new_1104701.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1104701071
		arg_289_1.duration_ = 4.07

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1104701072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1047ui_story = arg_289_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1047ui_story"].transform.position).z)
				arg_289_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1047ui_story"].transform.localEulerAngles = arg_289_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_289_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1047ui_story"].transform.position).z)
				arg_289_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1047ui_story"].transform.localEulerAngles = arg_289_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_1 = 0
			local var_292_2 = 0.475

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:GetWordFromCfg(1104701071)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_6 = 19 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_4) / 19)

				if (19 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_4) / 19)) > 0 and var_292_2 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb") ~= 0 then
					local var_292_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb") / 1000

					if var_292_7 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_1
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb")

						arg_289_1:RecordAudio("1104701071", var_292_8)
						arg_289_1:RecordAudio("1104701071", var_292_8)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701071", "story_v_side_new_1104701.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_9 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_9 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_9

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_9 and arg_289_1.time_ < var_292_1 + var_292_9 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1104701072
		arg_293_1.duration_ = 6.23

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1104701073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1047ui_story"]) and arg_293_1.var_.characterEffect1047ui_story == nil then
				arg_293_1.var_.characterEffect1047ui_story = arg_293_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1047ui_story"]) then
				if arg_293_1.var_.characterEffect1047ui_story and not isNil(arg_293_1.actors_["1047ui_story"]) then
					arg_293_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1047ui_story"]) and arg_293_1.var_.characterEffect1047ui_story then
				arg_293_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.5

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:GetWordFromCfg(1104701072)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_6 = 20 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_4) / 20)

				if (20 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_4) / 20)) > 0 and var_296_2 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb") ~= 0 then
					local var_296_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb") / 1000

					if var_296_7 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_1
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb")

						arg_293_1:RecordAudio("1104701072", var_296_8)
						arg_293_1:RecordAudio("1104701072", var_296_8)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701072", "story_v_side_new_1104701.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_9 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_9 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_9

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_9 and arg_293_1.time_ < var_296_1 + var_296_9 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1104701073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1104701073
		arg_297_1.duration_ = 6.93

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1104701074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) and arg_297_1.var_.characterEffect1047ui_story == nil then
				arg_297_1.var_.characterEffect1047ui_story = arg_297_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) then
				if arg_297_1.var_.characterEffect1047ui_story and not isNil(arg_297_1.actors_["1047ui_story"]) then
					arg_297_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) and arg_297_1.var_.characterEffect1047ui_story then
				arg_297_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_300_2 = 0
			local var_300_3 = 0.75

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:GetWordFromCfg(1104701073)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 30 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 30)

				if (30 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 30)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb")

						arg_297_1:RecordAudio("1104701073", var_300_9)
						arg_297_1:RecordAudio("1104701073", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701073", "story_v_side_new_1104701.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1104701074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1104701074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1104701075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1047ui_story"]) and arg_301_1.var_.characterEffect1047ui_story == nil then
				arg_301_1.var_.characterEffect1047ui_story = arg_301_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1047ui_story"]) then
				if arg_301_1.var_.characterEffect1047ui_story and not isNil(arg_301_1.actors_["1047ui_story"]) then
					arg_301_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_0)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1047ui_story"]) and arg_301_1.var_.characterEffect1047ui_story then
				arg_301_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_304_1 = arg_301_1.actors_["1047ui_story"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1047ui_story = var_304_1.localPosition
			end

			local var_304_2 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 then
				var_304_1.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 0) / var_304_2)
				var_304_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_1.position).x, (manager.ui.mainCamera.transform.position - var_304_1.position).y, (manager.ui.mainCamera.transform.position - var_304_1.position).z)
				var_304_1.localEulerAngles.z = 0
				var_304_1.localEulerAngles.x = 0
				var_304_1.localEulerAngles = var_304_1.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 then
				var_304_1.localPosition = Vector3.New(0, 100, 0)
				var_304_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_1.position).x, (manager.ui.mainCamera.transform.position - var_304_1.position).y, (manager.ui.mainCamera.transform.position - var_304_1.position).z)
				var_304_1.localEulerAngles.z = 0
				var_304_1.localEulerAngles.x = 0
				var_304_1.localEulerAngles = var_304_1.localEulerAngles
			end

			local var_304_3 = 0
			local var_304_4 = 0.95

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_3 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_5 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1104701074).content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 38 <= 0 and var_304_4 or var_304_4 * (utf8.len(var_304_5) / 38)

				if (38 <= 0 and var_304_4 or var_304_4 * (utf8.len(var_304_5) / 38)) > 0 and var_304_4 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_3 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_3
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_4, arg_301_1.talkMaxDuration)

			if var_304_3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_3 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_3) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_3 + var_304_8 and arg_301_1.time_ < var_304_3 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play1104701075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1104701075
		arg_305_1.duration_ = 6.27

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1104701076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.55

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(1104701075)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 22 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 22)

				if (22 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 22)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb")

						arg_305_1:RecordAudio("1104701075", var_308_6)
						arg_305_1:RecordAudio("1104701075", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701075", "story_v_side_new_1104701.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1104701076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1104701076
		arg_309_1.duration_ = 4

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1104701077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1047ui_story = arg_309_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).z)
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles = arg_309_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_309_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1047ui_story"].transform.position).z)
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1047ui_story"].transform.localEulerAngles = arg_309_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1047ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1047ui_story == nil then
				arg_309_1.var_.characterEffect1047ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1047ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1047ui_story then
				arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_4 = 0
			local var_312_5 = 0.425

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(1104701076)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 17 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 17)

				if (17 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 17)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb")

						arg_309_1:RecordAudio("1104701076", var_312_11)
						arg_309_1:RecordAudio("1104701076", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701076", "story_v_side_new_1104701.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1104701077
		arg_313_1.duration_ = 6.53

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1104701078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1047ui_story"]) and arg_313_1.var_.characterEffect1047ui_story == nil then
				arg_313_1.var_.characterEffect1047ui_story = arg_313_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1047ui_story"]) then
				if arg_313_1.var_.characterEffect1047ui_story and not isNil(arg_313_1.actors_["1047ui_story"]) then
					arg_313_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1047ui_story"]) and arg_313_1.var_.characterEffect1047ui_story then
				arg_313_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.625

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(1104701077)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 25 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_4) / 25)

				if (25 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_4) / 25)) > 0 and var_316_2 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb") ~= 0 then
					local var_316_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb") / 1000

					if var_316_7 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_1
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb")

						arg_313_1:RecordAudio("1104701077", var_316_8)
						arg_313_1:RecordAudio("1104701077", var_316_8)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701077", "story_v_side_new_1104701.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_9 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_9 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_9

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_9 and arg_313_1.time_ < var_316_1 + var_316_9 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1104701078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1104701078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1104701079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.65

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1104701078).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 26 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 26)

				if (26 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 26)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1104701079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1104701079
		arg_321_1.duration_ = 3.43

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1104701080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.35

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:GetWordFromCfg(1104701079)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 14 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 14)

				if (14 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 14)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb")

						arg_321_1:RecordAudio("1104701079", var_324_6)
						arg_321_1:RecordAudio("1104701079", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701079", "story_v_side_new_1104701.awb")
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
	Play1104701080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1104701080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1104701081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.775

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(1104701080).content)

				arg_325_1.text_.text = var_328_1

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_3 = 31 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 31)

				if (31 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 31)) > 0 and var_328_0 < var_328_3 then
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
	Play1104701081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1104701081
		arg_329_1.duration_ = 8.17

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1104701082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.925

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_1 = arg_329_1:GetWordFromCfg(1104701081)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 37 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 37)

				if (37 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 37)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb")

						arg_329_1:RecordAudio("1104701081", var_332_6)
						arg_329_1:RecordAudio("1104701081", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701081", "story_v_side_new_1104701.awb")
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
	Play1104701082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1104701082
		arg_333_1.duration_ = 8.67

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1104701083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 1.1

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_1 = arg_333_1:GetWordFromCfg(1104701082)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 44 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 44)

				if (44 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 44)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb")

						arg_333_1:RecordAudio("1104701082", var_336_6)
						arg_333_1:RecordAudio("1104701082", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701082", "story_v_side_new_1104701.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1104701083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1104701083
		arg_337_1.duration_ = 4.93

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1104701084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.525

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:GetWordFromCfg(1104701083)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 21 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 21)

				if (21 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 21)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb")

						arg_337_1:RecordAudio("1104701083", var_340_6)
						arg_337_1:RecordAudio("1104701083", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701083", "story_v_side_new_1104701.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1104701084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1104701084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1104701085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 1.525

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

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1104701084).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 61 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 61)

				if (61 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 61)) > 0 and var_344_0 < var_344_3 then
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
	Play1104701085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1104701085
		arg_345_1.duration_ = 10.87

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1104701086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1047ui_story = arg_345_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).z)
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles = arg_345_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_345_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).z)
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles = arg_345_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1047ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1047ui_story == nil then
				arg_345_1.var_.characterEffect1047ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1047ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1047ui_story then
				arg_345_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action464")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_348_4 = 0
			local var_348_5 = 1.05

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(1104701085)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_9 = 42 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 42)

				if (42 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 42)) > 0 and var_348_5 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb") / 1000

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end

					if var_348_6.prefab_name ~= "" and arg_345_1.actors_[var_348_6.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_6.prefab_name].transform, "story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb")

						arg_345_1:RecordAudio("1104701085", var_348_11)
						arg_345_1:RecordAudio("1104701085", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701085", "story_v_side_new_1104701.awb")
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
				actorName = "1047ui_story",
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
	Play1104701086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1104701086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1104701087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1047ui_story"]) and arg_349_1.var_.characterEffect1047ui_story == nil then
				arg_349_1.var_.characterEffect1047ui_story = arg_349_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1047ui_story"]) then
				if arg_349_1.var_.characterEffect1047ui_story and not isNil(arg_349_1.actors_["1047ui_story"]) then
					arg_349_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1047ui_story"]) and arg_349_1.var_.characterEffect1047ui_story then
				arg_349_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_352_1 = arg_349_1.actors_["1047ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1047ui_story = var_352_1.localPosition
			end

			local var_352_2 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 then
				var_352_1.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_2)
				var_352_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_1.position).x, (manager.ui.mainCamera.transform.position - var_352_1.position).y, (manager.ui.mainCamera.transform.position - var_352_1.position).z)
				var_352_1.localEulerAngles.z = 0
				var_352_1.localEulerAngles.x = 0
				var_352_1.localEulerAngles = var_352_1.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 then
				var_352_1.localPosition = Vector3.New(0, 100, 0)
				var_352_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_1.position).x, (manager.ui.mainCamera.transform.position - var_352_1.position).y, (manager.ui.mainCamera.transform.position - var_352_1.position).z)
				var_352_1.localEulerAngles.z = 0
				var_352_1.localEulerAngles.x = 0
				var_352_1.localEulerAngles = var_352_1.localEulerAngles
			end

			local var_352_3 = 0
			local var_352_4 = 0.55

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_3 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_5 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1104701086).content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 22 <= 0 and var_352_4 or var_352_4 * (utf8.len(var_352_5) / 22)

				if (22 <= 0 and var_352_4 or var_352_4 * (utf8.len(var_352_5) / 22)) > 0 and var_352_4 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_3 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_3
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_4, arg_349_1.talkMaxDuration)

			if var_352_3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_3 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_3) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_3 + var_352_8 and arg_349_1.time_ < var_352_3 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1104701087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1104701087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1104701088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.9

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
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

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(1104701087).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 36 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 36)

				if (36 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 36)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1104701088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1104701088
		arg_357_1.duration_ = 3.03

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1104701089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1047ui_story = arg_357_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).z)
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles = arg_357_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_357_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).z)
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles = arg_357_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1047ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1047ui_story == nil then
				arg_357_1.var_.characterEffect1047ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1047ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1047ui_story then
				arg_357_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_360_4 = 0
			local var_360_5 = 0.225

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(1104701088)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 9 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 9)

				if (9 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 9)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb")

						arg_357_1:RecordAudio("1104701088", var_360_11)
						arg_357_1:RecordAudio("1104701088", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701088", "story_v_side_new_1104701.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play1104701089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1104701089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1104701090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1047ui_story"]) and arg_361_1.var_.characterEffect1047ui_story == nil then
				arg_361_1.var_.characterEffect1047ui_story = arg_361_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1047ui_story"]) then
				if arg_361_1.var_.characterEffect1047ui_story and not isNil(arg_361_1.actors_["1047ui_story"]) then
					arg_361_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1047ui_story"]) and arg_361_1.var_.characterEffect1047ui_story then
				arg_361_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_364_1 = arg_361_1.actors_["1047ui_story"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1047ui_story = var_364_1.localPosition
			end

			local var_364_2 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 then
				var_364_1.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_2)
				var_364_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_1.position).x, (manager.ui.mainCamera.transform.position - var_364_1.position).y, (manager.ui.mainCamera.transform.position - var_364_1.position).z)
				var_364_1.localEulerAngles.z = 0
				var_364_1.localEulerAngles.x = 0
				var_364_1.localEulerAngles = var_364_1.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 then
				var_364_1.localPosition = Vector3.New(0, 100, 0)
				var_364_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_1.position).x, (manager.ui.mainCamera.transform.position - var_364_1.position).y, (manager.ui.mainCamera.transform.position - var_364_1.position).z)
				var_364_1.localEulerAngles.z = 0
				var_364_1.localEulerAngles.x = 0
				var_364_1.localEulerAngles = var_364_1.localEulerAngles
			end

			local var_364_3 = 0
			local var_364_4 = 0.95

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_5 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1104701089).content)

				arg_361_1.text_.text = var_364_5

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_7 = 38 <= 0 and var_364_4 or var_364_4 * (utf8.len(var_364_5) / 38)

				if (38 <= 0 and var_364_4 or var_364_4 * (utf8.len(var_364_5) / 38)) > 0 and var_364_4 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_3 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_3
					end
				end

				arg_361_1.text_.text = var_364_5
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_4, arg_361_1.talkMaxDuration)

			if var_364_3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_3 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_3) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_3 + var_364_8 and arg_361_1.time_ < var_364_3 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play1104701090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1104701090
		arg_365_1.duration_ = 3.97

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1104701091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1047ui_story = arg_365_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1047ui_story"].transform.position).z)
				arg_365_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1047ui_story"].transform.localEulerAngles = arg_365_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_365_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1047ui_story"].transform.position).z)
				arg_365_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1047ui_story"].transform.localEulerAngles = arg_365_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_368_1 = arg_365_1.actors_["1047ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1047ui_story == nil then
				arg_365_1.var_.characterEffect1047ui_story = var_368_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 and not isNil(var_368_1) then
				if arg_365_1.var_.characterEffect1047ui_story and not isNil(var_368_1) then
					arg_365_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1047ui_story then
				arg_365_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_368_4 = 0
			local var_368_5 = 0.45

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_6 = arg_365_1:GetWordFromCfg(1104701090)
				local var_368_7 = arg_365_1:FormatText(var_368_6.content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 18 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 18)

				if (18 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 18)) > 0 and var_368_5 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb") ~= 0 then
					local var_368_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb") / 1000

					if var_368_10 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_4
					end

					if var_368_6.prefab_name ~= "" and arg_365_1.actors_[var_368_6.prefab_name] ~= nil then
						local var_368_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_6.prefab_name].transform, "story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb")

						arg_365_1:RecordAudio("1104701090", var_368_11)
						arg_365_1:RecordAudio("1104701090", var_368_11)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701090", "story_v_side_new_1104701.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_12 = math.max(var_368_5, arg_365_1.talkMaxDuration)

			if var_368_4 <= arg_365_1.time_ and arg_365_1.time_ < var_368_4 + var_368_12 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_4) / var_368_12

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_4 + var_368_12 and arg_365_1.time_ < var_368_4 + var_368_12 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play1104701091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1104701091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1104701092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1047ui_story"]) and arg_369_1.var_.characterEffect1047ui_story == nil then
				arg_369_1.var_.characterEffect1047ui_story = arg_369_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1047ui_story"]) then
				if arg_369_1.var_.characterEffect1047ui_story and not isNil(arg_369_1.actors_["1047ui_story"]) then
					arg_369_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1047ui_story"]) and arg_369_1.var_.characterEffect1047ui_story then
				arg_369_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.175

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

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1104701091).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 7 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 7)

				if (7 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 7)) > 0 and var_372_2 < var_372_5 then
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
	Play1104701092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1104701092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1104701093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1047ui_story = arg_373_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1047ui_story"].transform.position).z)
				arg_373_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1047ui_story"].transform.localEulerAngles = arg_373_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_373_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1047ui_story"].transform.position).z)
				arg_373_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1047ui_story"].transform.localEulerAngles = arg_373_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_376_1 = 0
			local var_376_2 = 0.9

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_3 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(1104701092).content)

				arg_373_1.text_.text = var_376_3

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 36 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 36)

				if (36 <= 0 and var_376_2 or var_376_2 * (utf8.len(var_376_3) / 36)) > 0 and var_376_2 < var_376_5 then
					arg_373_1.talkMaxDuration = var_376_5

					if var_376_5 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + var_376_1
					end
				end

				arg_373_1.text_.text = var_376_3
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_6 = math.max(var_376_2, arg_373_1.talkMaxDuration)

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_6 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_1) / var_376_6

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_1 + var_376_6 and arg_373_1.time_ < var_376_1 + var_376_6 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1104701093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1104701094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.35

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(1104701093).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 14 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 14)

				if (14 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 14)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1104701094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1104701094
		arg_381_1.duration_ = 7.53

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1104701095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1047ui_story = arg_381_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1047ui_story"].transform.position).z)
				arg_381_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1047ui_story"].transform.localEulerAngles = arg_381_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_381_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1047ui_story"].transform.position).z)
				arg_381_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1047ui_story"].transform.localEulerAngles = arg_381_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1047ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1047ui_story == nil then
				arg_381_1.var_.characterEffect1047ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1047ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1047ui_story then
				arg_381_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_384_4 = 0
			local var_384_5 = 0.6

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:GetWordFromCfg(1104701094)
				local var_384_7 = arg_381_1:FormatText(var_384_6.content)

				arg_381_1.text_.text = var_384_7

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 24 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 24)

				if (24 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 24)) > 0 and var_384_5 < var_384_9 then
					arg_381_1.talkMaxDuration = var_384_9

					if var_384_9 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_7
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb") ~= 0 then
					local var_384_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb") / 1000

					if var_384_10 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_4
					end

					if var_384_6.prefab_name ~= "" and arg_381_1.actors_[var_384_6.prefab_name] ~= nil then
						local var_384_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_6.prefab_name].transform, "story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb")

						arg_381_1:RecordAudio("1104701094", var_384_11)
						arg_381_1:RecordAudio("1104701094", var_384_11)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701094", "story_v_side_new_1104701.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_12 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_12 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_12

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_12 and arg_381_1.time_ < var_384_4 + var_384_12 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play1104701095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1104701095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1104701096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1047ui_story"]) and arg_385_1.var_.characterEffect1047ui_story == nil then
				arg_385_1.var_.characterEffect1047ui_story = arg_385_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1047ui_story"]) then
				if arg_385_1.var_.characterEffect1047ui_story and not isNil(arg_385_1.actors_["1047ui_story"]) then
					arg_385_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1047ui_story"]) and arg_385_1.var_.characterEffect1047ui_story then
				arg_385_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 0.175

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(1104701095).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 7 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 7)

				if (7 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 7)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1104701096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1104701096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1104701097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1047ui_story = arg_389_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1047ui_story"].transform.position).z)
				arg_389_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1047ui_story"].transform.localEulerAngles = arg_389_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_389_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1047ui_story"].transform.position).z)
				arg_389_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1047ui_story"].transform.localEulerAngles = arg_389_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_392_1 = 0
			local var_392_2 = 0.925

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_3 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(1104701096).content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 37 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 37)

				if (37 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 37)) > 0 and var_392_2 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_6 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_6 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_6

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_6 and arg_389_1.time_ < var_392_1 + var_392_6 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play1104701097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1104701097
		arg_393_1.duration_ = 11.47

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1104701098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1047ui_story = arg_393_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_396_0 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 then
				arg_393_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_393_1.time_ - 0) / var_396_0)
				arg_393_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1047ui_story"].transform.position).z)
				arg_393_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1047ui_story"].transform.localEulerAngles = arg_393_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 then
				arg_393_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_393_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_393_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_393_1.actors_["1047ui_story"].transform.position).z)
				arg_393_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_393_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_393_1.actors_["1047ui_story"].transform.localEulerAngles = arg_393_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_396_1 = arg_393_1.actors_["1047ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1047ui_story == nil then
				arg_393_1.var_.characterEffect1047ui_story = var_396_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_2 and not isNil(var_396_1) then
				if arg_393_1.var_.characterEffect1047ui_story and not isNil(var_396_1) then
					arg_393_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_2 and arg_393_1.time_ < 0 + var_396_2 + arg_396_0 and not isNil(var_396_1) and arg_393_1.var_.characterEffect1047ui_story then
				arg_393_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_396_4 = 0
			local var_396_5 = 1.2

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_6 = arg_393_1:GetWordFromCfg(1104701097)
				local var_396_7 = arg_393_1:FormatText(var_396_6.content)

				arg_393_1.text_.text = var_396_7

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_9 = 48 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_7) / 48)

				if (48 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_7) / 48)) > 0 and var_396_5 < var_396_9 then
					arg_393_1.talkMaxDuration = var_396_9

					if var_396_9 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_9 + var_396_4
					end
				end

				arg_393_1.text_.text = var_396_7
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb") ~= 0 then
					local var_396_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb") / 1000

					if var_396_10 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_4
					end

					if var_396_6.prefab_name ~= "" and arg_393_1.actors_[var_396_6.prefab_name] ~= nil then
						local var_396_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_6.prefab_name].transform, "story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb")

						arg_393_1:RecordAudio("1104701097", var_396_11)
						arg_393_1:RecordAudio("1104701097", var_396_11)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701097", "story_v_side_new_1104701.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_12 = math.max(var_396_5, arg_393_1.talkMaxDuration)

			if var_396_4 <= arg_393_1.time_ and arg_393_1.time_ < var_396_4 + var_396_12 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_4) / var_396_12

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_4 + var_396_12 and arg_393_1.time_ < var_396_4 + var_396_12 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1104701098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1104701098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1104701099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1047ui_story"]) and arg_397_1.var_.characterEffect1047ui_story == nil then
				arg_397_1.var_.characterEffect1047ui_story = arg_397_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1047ui_story"]) then
				if arg_397_1.var_.characterEffect1047ui_story and not isNil(arg_397_1.actors_["1047ui_story"]) then
					arg_397_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_0)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1047ui_story"]) and arg_397_1.var_.characterEffect1047ui_story then
				arg_397_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_400_1 = arg_397_1.actors_["1047ui_story"].transform

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1047ui_story = var_400_1.localPosition
			end

			local var_400_2 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_2 then
				var_400_1.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_397_1.time_ - 0) / var_400_2)
				var_400_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_1.position).x, (manager.ui.mainCamera.transform.position - var_400_1.position).y, (manager.ui.mainCamera.transform.position - var_400_1.position).z)
				var_400_1.localEulerAngles.z = 0
				var_400_1.localEulerAngles.x = 0
				var_400_1.localEulerAngles = var_400_1.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_2 and arg_397_1.time_ < 0 + var_400_2 + arg_400_0 then
				var_400_1.localPosition = Vector3.New(0, 100, 0)
				var_400_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_1.position).x, (manager.ui.mainCamera.transform.position - var_400_1.position).y, (manager.ui.mainCamera.transform.position - var_400_1.position).z)
				var_400_1.localEulerAngles.z = 0
				var_400_1.localEulerAngles.x = 0
				var_400_1.localEulerAngles = var_400_1.localEulerAngles
			end

			local var_400_3 = 0
			local var_400_4 = 0.4

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_3 + arg_400_0 then
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

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_5 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1104701098).content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 16 <= 0 and var_400_4 or var_400_4 * (utf8.len(var_400_5) / 16)

				if (16 <= 0 and var_400_4 or var_400_4 * (utf8.len(var_400_5) / 16)) > 0 and var_400_4 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_3 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_3
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_8 = math.max(var_400_4, arg_397_1.talkMaxDuration)

			if var_400_3 <= arg_397_1.time_ and arg_397_1.time_ < var_400_3 + var_400_8 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_3) / var_400_8

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_3 + var_400_8 and arg_397_1.time_ < var_400_3 + var_400_8 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play1104701099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1104701099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1104701100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_404_1 = 0
			local var_404_2 = 0.725

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_3 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1104701099).content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 29 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 29)

				if (29 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 29)) > 0 and var_404_2 < var_404_5 then
					arg_401_1.talkMaxDuration = var_404_5

					if var_404_5 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_6 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_6 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_6

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_6 and arg_401_1.time_ < var_404_1 + var_404_6 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1104701100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104701100
		arg_405_1.duration_ = 9

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104701101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if arg_405_1.bgs_.ST22 == nil then
				local var_408_0 = Object.Instantiate(arg_405_1.paintGo_)

				var_408_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_408_0.name = "ST22"
				var_408_0.transform.parent = arg_405_1.stage_.transform
				var_408_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.bgs_.ST22 = var_408_0
			end

			if 2 < arg_405_1.time_ and arg_405_1.time_ <= 2 + arg_408_0 then
				local var_408_1 = arg_405_1.bgs_.ST22

				arg_405_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_408_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_408_2 = var_408_1:GetComponent("SpriteRenderer")

				if var_408_2 and var_408_2.sprite then
					local var_408_3 = 2 * (var_408_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_408_1.transform.localScale = Vector3.New(var_408_3 / var_408_2.sprite.bounds.size.y < var_408_3 * manager.ui.mainCameraCom_.aspect / var_408_2.sprite.bounds.size.x and var_408_3 * manager.ui.mainCameraCom_.aspect / var_408_2.sprite.bounds.size.x or var_408_3 / var_408_2.sprite.bounds.size.y, var_408_3 / var_408_2.sprite.bounds.size.y < var_408_3 * manager.ui.mainCameraCom_.aspect / var_408_2.sprite.bounds.size.x and var_408_3 * manager.ui.mainCameraCom_.aspect / var_408_2.sprite.bounds.size.x or var_408_3 / var_408_2.sprite.bounds.size.y, 0)
				end

				for iter_408_0, iter_408_1 in pairs(arg_405_1.bgs_) do
					if iter_408_0 ~= "ST22" then
						iter_408_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_408_4 = 4

			if 4 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.allBtn_.enabled = false
			end

			if arg_405_1.time_ >= var_408_4 + 0.3 and arg_405_1.time_ < var_408_4 + 0.3 + arg_408_0 then
				arg_405_1.allBtn_.enabled = true
			end

			local var_408_5 = 0

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_5 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_6 = 2

			if var_408_5 <= arg_405_1.time_ and arg_405_1.time_ < var_408_5 + var_408_6 then
				local var_408_7 = Color.New(0, 0, 0)

				var_408_7.a = Mathf.Lerp(0, 1, (arg_405_1.time_ - var_408_5) / var_408_6)
				arg_405_1.mask_.color = var_408_7
			end

			if arg_405_1.time_ >= var_408_5 + var_408_6 and arg_405_1.time_ < var_408_5 + var_408_6 + arg_408_0 then
				local var_408_8 = Color.New(0, 0, 0)

				var_408_8.a = 1
				arg_405_1.mask_.color = var_408_8
			end

			local var_408_9 = 2

			if 2 < arg_405_1.time_ and arg_405_1.time_ <= var_408_9 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_10 = 2

			if var_408_9 <= arg_405_1.time_ and arg_405_1.time_ < var_408_9 + var_408_10 then
				local var_408_11 = Color.New(0, 0, 0)

				var_408_11.a = Mathf.Lerp(1, 0, (arg_405_1.time_ - var_408_9) / var_408_10)
				arg_405_1.mask_.color = var_408_11
			end

			if arg_405_1.time_ >= var_408_9 + var_408_10 and arg_405_1.time_ < var_408_9 + var_408_10 + arg_408_0 then
				local var_408_12 = Color.New(0, 0, 0)

				arg_405_1.mask_.enabled = false
				var_408_12.a = 0
				arg_405_1.mask_.color = var_408_12
			end

			if 1.2 < arg_405_1.time_ and arg_405_1.time_ <= 1.2 + arg_408_0 then
				arg_405_1:AudioAction("stop", "effect", "se_story_147", "se_story_147_amb_rooftop", "")
			end

			if 0.1 < arg_405_1.time_ and arg_405_1.time_ <= 0.1 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street01", "")
			end

			if 1 < arg_405_1.time_ and arg_405_1.time_ <= 1 + arg_408_0 then
				arg_405_1:AudioAction("play", "music", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_408_17 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

				if "" ~= "" then
					if arg_405_1.bgmTxt_.text ~= var_408_17 and arg_405_1.bgmTxt_.text ~= "" then
						if arg_405_1.bgmTxt2_.text ~= "" then
							arg_405_1.bgmTxt_.text = arg_405_1.bgmTxt2_.text
						end

						arg_405_1.bgmTxt2_.text = var_408_17

						arg_405_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_405_1.bgmTxt_.text = var_408_17
						arg_405_1.bgmTxt2_.text = var_408_17
					end

					if arg_405_1.bgmTimer then
						arg_405_1.bgmTimer:Stop()

						arg_405_1.bgmTimer = nil
					end

					if arg_405_1.settingData.show_music_name == 1 then
						arg_405_1.musicController:SetSelectedState("show")
						arg_405_1.musicAnimator_:Play("open", 0, 0)

						if arg_405_1.settingData.music_time ~= 0 then
							arg_405_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_405_1.settingData.music_time), function()
								if arg_405_1 == nil or isNil(arg_405_1.bgmTxt_) then
									return
								end

								arg_405_1.musicController:SetSelectedState("hide")
								arg_405_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_405_1.frameCnt_ <= 1 then
				arg_405_1.dialog_:SetActive(false)
			end

			local var_408_18 = 4
			local var_408_19 = 1.2

			if 4 < arg_405_1.time_ and arg_405_1.time_ <= var_408_18 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				arg_405_1.dialog_:SetActive(true)

				arg_405_1.dialogCg_.alpha = 0

				local var_408_20 = LeanTween.value(arg_405_1.dialog_, 0, 1, 0.3)

				var_408_20:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_405_1.dialogCg_.alpha = arg_410_0
				end))
				var_408_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_405_1.dialog_)
					var_408_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_405_1.duration_ = arg_405_1.duration_ + 0.3

				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_21 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(1104701100).content)

				arg_405_1.text_.text = var_408_21

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_23 = 48 <= 0 and var_408_19 or var_408_19 * (utf8.len(var_408_21) / 48)

				if (48 <= 0 and var_408_19 or var_408_19 * (utf8.len(var_408_21) / 48)) > 0 and var_408_19 < var_408_23 then
					arg_405_1.talkMaxDuration = var_408_23
					var_408_18 = var_408_18 + 0.3

					if var_408_23 + var_408_18 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_23 + var_408_18
					end
				end

				arg_405_1.text_.text = var_408_21
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_24 = var_408_18 + 0.3
			local var_408_25 = math.max(var_408_19, arg_405_1.talkMaxDuration)

			if var_408_18 + 0.3 <= arg_405_1.time_ and arg_405_1.time_ < var_408_24 + var_408_25 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_24) / var_408_25

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_24 + var_408_25 and arg_405_1.time_ < var_408_24 + var_408_25 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1104701101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1104701101
		arg_412_1.duration_ = 6.53

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1104701102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.75

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_1 = arg_412_1:GetWordFromCfg(1104701101)
				local var_415_2 = arg_412_1:FormatText(var_415_1.content)

				arg_412_1.text_.text = var_415_2

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 30 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 30)

				if (30 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 30)) > 0 and var_415_0 < var_415_4 then
					arg_412_1.talkMaxDuration = var_415_4

					if var_415_4 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_4 + 0
					end
				end

				arg_412_1.text_.text = var_415_2
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb") ~= 0 then
					local var_415_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb") / 1000

					if var_415_5 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + 0
					end

					if var_415_1.prefab_name ~= "" and arg_412_1.actors_[var_415_1.prefab_name] ~= nil then
						local var_415_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_1.prefab_name].transform, "story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb")

						arg_412_1:RecordAudio("1104701101", var_415_6)
						arg_412_1:RecordAudio("1104701101", var_415_6)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701101", "story_v_side_new_1104701.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_7 and arg_412_1.time_ < 0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1104701102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1104701102
		arg_416_1.duration_ = 7.27

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1104701103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.525

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:GetWordFromCfg(1104701102)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 21 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 21)

				if (21 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 21)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb")

						arg_416_1:RecordAudio("1104701102", var_419_6)
						arg_416_1:RecordAudio("1104701102", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701102", "story_v_side_new_1104701.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1104701103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1104701103
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1104701104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 1.2

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_1 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(1104701103).content)

				arg_420_1.text_.text = var_423_1

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_3 = 48 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_1) / 48)

				if (48 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_1) / 48)) > 0 and var_423_0 < var_423_3 then
					arg_420_1.talkMaxDuration = var_423_3

					if var_423_3 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_3 + 0
					end
				end

				arg_420_1.text_.text = var_423_1
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_4 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_4

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1104701104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1104701104
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1104701105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 1.075

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_1 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(1104701104).content)

				arg_424_1.text_.text = var_427_1

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_3 = 43 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 43)

				if (43 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 43)) > 0 and var_427_0 < var_427_3 then
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
	Play1104701105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1104701105
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1104701106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.175

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
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_1 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(1104701105).content)

				arg_428_1.text_.text = var_431_1

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_3 = 7 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 7)

				if (7 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 7)) > 0 and var_431_0 < var_431_3 then
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
	Play1104701106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1104701106
		arg_432_1.duration_ = 6.47

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1104701107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0.5

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_1 = arg_432_1:GetWordFromCfg(1104701106)
				local var_435_2 = arg_432_1:FormatText(var_435_1.content)

				arg_432_1.text_.text = var_435_2

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 20 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 20)

				if (20 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 20)) > 0 and var_435_0 < var_435_4 then
					arg_432_1.talkMaxDuration = var_435_4

					if var_435_4 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_4 + 0
					end
				end

				arg_432_1.text_.text = var_435_2
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb") ~= 0 then
					local var_435_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb") / 1000

					if var_435_5 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + 0
					end

					if var_435_1.prefab_name ~= "" and arg_432_1.actors_[var_435_1.prefab_name] ~= nil then
						local var_435_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_1.prefab_name].transform, "story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb")

						arg_432_1:RecordAudio("1104701106", var_435_6)
						arg_432_1:RecordAudio("1104701106", var_435_6)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701106", "story_v_side_new_1104701.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_7 and arg_432_1.time_ < 0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1104701107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1104701107
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1104701108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 1.025

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_1 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(1104701107).content)

				arg_436_1.text_.text = var_439_1

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_3 = 41 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 41)

				if (41 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 41)) > 0 and var_439_0 < var_439_3 then
					arg_436_1.talkMaxDuration = var_439_3

					if var_439_3 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_3 + 0
					end
				end

				arg_436_1.text_.text = var_439_1
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_4 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_4

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1104701108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1104701108
		arg_440_1.duration_ = 6.8

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1104701109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1047ui_story = arg_440_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_443_0 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 then
				arg_440_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_440_1.time_ - 0) / var_443_0)
				arg_440_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1047ui_story"].transform.position).z)
				arg_440_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1047ui_story"].transform.localEulerAngles = arg_440_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 then
				arg_440_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_440_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1047ui_story"].transform.position).z)
				arg_440_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1047ui_story"].transform.localEulerAngles = arg_440_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_443_1 = arg_440_1.actors_["1047ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1047ui_story == nil then
				arg_440_1.var_.characterEffect1047ui_story = var_443_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_2 and not isNil(var_443_1) then
				if arg_440_1.var_.characterEffect1047ui_story and not isNil(var_443_1) then
					arg_440_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_2 and arg_440_1.time_ < 0 + var_443_2 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1047ui_story then
				arg_440_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_443_4 = 0
			local var_443_5 = 0.775

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_6 = arg_440_1:GetWordFromCfg(1104701108)
				local var_443_7 = arg_440_1:FormatText(var_443_6.content)

				arg_440_1.text_.text = var_443_7

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_9 = 31 <= 0 and var_443_5 or var_443_5 * (utf8.len(var_443_7) / 31)

				if (31 <= 0 and var_443_5 or var_443_5 * (utf8.len(var_443_7) / 31)) > 0 and var_443_5 < var_443_9 then
					arg_440_1.talkMaxDuration = var_443_9

					if var_443_9 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_9 + var_443_4
					end
				end

				arg_440_1.text_.text = var_443_7
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb") ~= 0 then
					local var_443_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb") / 1000

					if var_443_10 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_10 + var_443_4
					end

					if var_443_6.prefab_name ~= "" and arg_440_1.actors_[var_443_6.prefab_name] ~= nil then
						local var_443_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_6.prefab_name].transform, "story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb")

						arg_440_1:RecordAudio("1104701108", var_443_11)
						arg_440_1:RecordAudio("1104701108", var_443_11)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701108", "story_v_side_new_1104701.awb")
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
				actorName = "1047ui_story",
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
	Play1104701109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1104701109
		arg_444_1.duration_ = 2.83

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1104701110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos1047ui_story = arg_444_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_447_0 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 then
				arg_444_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_444_1.time_ - 0) / var_447_0)
				arg_444_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1047ui_story"].transform.position).z)
				arg_444_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1047ui_story"].transform.localEulerAngles = arg_444_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 then
				arg_444_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_444_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1047ui_story"].transform.position).z)
				arg_444_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1047ui_story"].transform.localEulerAngles = arg_444_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_447_1 = 0
			local var_447_2 = 0.225

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_3 = arg_444_1:GetWordFromCfg(1104701109)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_6 = 9 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_4) / 9)

				if (9 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_4) / 9)) > 0 and var_447_2 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_1
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb") ~= 0 then
					local var_447_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb") / 1000

					if var_447_7 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_1
					end

					if var_447_3.prefab_name ~= "" and arg_444_1.actors_[var_447_3.prefab_name] ~= nil then
						local var_447_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_3.prefab_name].transform, "story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb")

						arg_444_1:RecordAudio("1104701109", var_447_8)
						arg_444_1:RecordAudio("1104701109", var_447_8)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701109", "story_v_side_new_1104701.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_9 = math.max(var_447_2, arg_444_1.talkMaxDuration)

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_9 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_1) / var_447_9

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_1 + var_447_9 and arg_444_1.time_ < var_447_1 + var_447_9 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1104701110
		arg_448_1.duration_ = 2.22

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1104701111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["1047ui_story"]) and arg_448_1.var_.characterEffect1047ui_story == nil then
				arg_448_1.var_.characterEffect1047ui_story = arg_448_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["1047ui_story"]) then
				if arg_448_1.var_.characterEffect1047ui_story and not isNil(arg_448_1.actors_["1047ui_story"]) then
					arg_448_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_448_1.time_ - 0) / var_451_0)
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["1047ui_story"]) and arg_448_1.var_.characterEffect1047ui_story then
				arg_448_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_451_1 = arg_448_1.actors_["1047ui_story"].transform

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos1047ui_story = var_451_1.localPosition
			end

			local var_451_2 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_2 then
				var_451_1.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_448_1.time_ - 0) / var_451_2)
				var_451_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_451_1.position).x, (manager.ui.mainCamera.transform.position - var_451_1.position).y, (manager.ui.mainCamera.transform.position - var_451_1.position).z)
				var_451_1.localEulerAngles.z = 0
				var_451_1.localEulerAngles.x = 0
				var_451_1.localEulerAngles = var_451_1.localEulerAngles
			end

			if arg_448_1.time_ >= 0 + var_451_2 and arg_448_1.time_ < 0 + var_451_2 + arg_451_0 then
				var_451_1.localPosition = Vector3.New(0, 100, 0)
				var_451_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_451_1.position).x, (manager.ui.mainCamera.transform.position - var_451_1.position).y, (manager.ui.mainCamera.transform.position - var_451_1.position).z)
				var_451_1.localEulerAngles.z = 0
				var_451_1.localEulerAngles.x = 0
				var_451_1.localEulerAngles = var_451_1.localEulerAngles
			end

			local var_451_3 = 0

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_3 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_4 = 0.125

			if var_451_3 <= arg_448_1.time_ and arg_448_1.time_ < var_451_3 + var_451_4 then
				local var_451_5 = Color.New(1, 1, 1)

				var_451_5.a = Mathf.Lerp(0, 1, (arg_448_1.time_ - var_451_3) / var_451_4)
				arg_448_1.mask_.color = var_451_5
			end

			if arg_448_1.time_ >= var_451_3 + var_451_4 and arg_448_1.time_ < var_451_3 + var_451_4 + arg_451_0 then
				local var_451_6 = Color.New(1, 1, 1)

				var_451_6.a = 1
				arg_448_1.mask_.color = var_451_6
			end

			local var_451_7 = 0.125

			if 0.125 < arg_448_1.time_ and arg_448_1.time_ <= var_451_7 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_8 = 0.0750000029802322

			if var_451_7 <= arg_448_1.time_ and arg_448_1.time_ < var_451_7 + var_451_8 then
				local var_451_9 = Color.New(1, 1, 1)

				var_451_9.a = Mathf.Lerp(1, 0, (arg_448_1.time_ - var_451_7) / var_451_8)
				arg_448_1.mask_.color = var_451_9
			end

			if arg_448_1.time_ >= var_451_7 + var_451_8 and arg_448_1.time_ < var_451_7 + var_451_8 + arg_451_0 then
				local var_451_10 = Color.New(1, 1, 1)

				arg_448_1.mask_.enabled = false
				var_451_10.a = 0
				arg_448_1.mask_.color = var_451_10
			end

			local var_451_11 = 0.291666666666667

			if 0.291666666666667 < arg_448_1.time_ and arg_448_1.time_ <= var_451_11 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_12 = 0.0750000000000001

			if var_451_11 <= arg_448_1.time_ and arg_448_1.time_ < var_451_11 + var_451_12 then
				local var_451_13 = Color.New(1, 1, 1)

				var_451_13.a = Mathf.Lerp(1, 0, (arg_448_1.time_ - var_451_11) / var_451_12)
				arg_448_1.mask_.color = var_451_13
			end

			if arg_448_1.time_ >= var_451_11 + var_451_12 and arg_448_1.time_ < var_451_11 + var_451_12 + arg_451_0 then
				local var_451_14 = Color.New(1, 1, 1)

				arg_448_1.mask_.enabled = false
				var_451_14.a = 0
				arg_448_1.mask_.color = var_451_14
			end

			local var_451_15 = 0

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_15 + arg_451_0 then
				arg_448_1.allBtn_.enabled = false
			end

			if arg_448_1.time_ >= var_451_15 + 0.366666666666667 and arg_448_1.time_ < var_451_15 + 0.366666666666667 + arg_451_0 then
				arg_448_1.allBtn_.enabled = true
			end

			if arg_448_1.frameCnt_ <= 1 then
				arg_448_1.dialog_:SetActive(false)
			end

			local var_451_16 = 0.316666666666667
			local var_451_17 = 0.125

			if 0.316666666666667 < arg_448_1.time_ and arg_448_1.time_ <= var_451_16 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0

				arg_448_1.dialog_:SetActive(true)

				arg_448_1.dialogCg_.alpha = 0

				local var_451_18 = LeanTween.value(arg_448_1.dialog_, 0, 1, 0.3)

				var_451_18:setOnUpdate(LuaHelper.FloatAction(function(arg_452_0)
					arg_448_1.dialogCg_.alpha = arg_452_0
				end))
				var_451_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_448_1.dialog_)
					var_451_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_448_1.duration_ = arg_448_1.duration_ + 0.3

				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_19 = arg_448_1:GetWordFromCfg(1104701110)
				local var_451_20 = arg_448_1:FormatText(var_451_19.content)

				arg_448_1.text_.text = var_451_20

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_22 = 5 <= 0 and var_451_17 or var_451_17 * (utf8.len(var_451_20) / 5)

				if (5 <= 0 and var_451_17 or var_451_17 * (utf8.len(var_451_20) / 5)) > 0 and var_451_17 < var_451_22 then
					arg_448_1.talkMaxDuration = var_451_22
					var_451_16 = var_451_16 + 0.3

					if var_451_22 + var_451_16 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_22 + var_451_16
					end
				end

				arg_448_1.text_.text = var_451_20
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb") ~= 0 then
					local var_451_23 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb") / 1000

					if var_451_23 + var_451_16 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_23 + var_451_16
					end

					if var_451_19.prefab_name ~= "" and arg_448_1.actors_[var_451_19.prefab_name] ~= nil then
						local var_451_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_19.prefab_name].transform, "story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb")

						arg_448_1:RecordAudio("1104701110", var_451_24)
						arg_448_1:RecordAudio("1104701110", var_451_24)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701110", "story_v_side_new_1104701.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_25 = var_451_16 + 0.3
			local var_451_26 = math.max(var_451_17, arg_448_1.talkMaxDuration)

			if var_451_16 + 0.3 <= arg_448_1.time_ and arg_448_1.time_ < var_451_25 + var_451_26 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_25) / var_451_26

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_25 + var_451_26 and arg_448_1.time_ < var_451_25 + var_451_26 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play1104701111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1104701111
		arg_454_1.duration_ = 4.73

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1104701112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.675

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_1 = arg_454_1:GetWordFromCfg(1104701111)
				local var_457_2 = arg_454_1:FormatText(var_457_1.content)

				arg_454_1.text_.text = var_457_2

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 27 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 27)

				if (27 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 27)) > 0 and var_457_0 < var_457_4 then
					arg_454_1.talkMaxDuration = var_457_4

					if var_457_4 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_4 + 0
					end
				end

				arg_454_1.text_.text = var_457_2
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb") ~= 0 then
					local var_457_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb") / 1000

					if var_457_5 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_5 + 0
					end

					if var_457_1.prefab_name ~= "" and arg_454_1.actors_[var_457_1.prefab_name] ~= nil then
						local var_457_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_1.prefab_name].transform, "story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb")

						arg_454_1:RecordAudio("1104701111", var_457_6)
						arg_454_1:RecordAudio("1104701111", var_457_6)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701111", "story_v_side_new_1104701.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_7 and arg_454_1.time_ < 0 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1104701112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1104701112
		arg_458_1.duration_ = 2.67

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1104701113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos1047ui_story = arg_458_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_461_0 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 then
				arg_458_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_458_1.time_ - 0) / var_461_0)
				arg_458_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["1047ui_story"].transform.position).z)
				arg_458_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["1047ui_story"].transform.localEulerAngles = arg_458_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 then
				arg_458_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_458_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_458_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_458_1.actors_["1047ui_story"].transform.position).z)
				arg_458_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_458_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_458_1.actors_["1047ui_story"].transform.localEulerAngles = arg_458_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_461_1 = arg_458_1.actors_["1047ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_1) and arg_458_1.var_.characterEffect1047ui_story == nil then
				arg_458_1.var_.characterEffect1047ui_story = var_461_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_2 and not isNil(var_461_1) then
				if arg_458_1.var_.characterEffect1047ui_story and not isNil(var_461_1) then
					arg_458_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_2 and arg_458_1.time_ < 0 + var_461_2 + arg_461_0 and not isNil(var_461_1) and arg_458_1.var_.characterEffect1047ui_story then
				arg_458_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_461_4 = 0
			local var_461_5 = 0.175

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_6 = arg_458_1:GetWordFromCfg(1104701112)
				local var_461_7 = arg_458_1:FormatText(var_461_6.content)

				arg_458_1.text_.text = var_461_7

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_9 = 7 <= 0 and var_461_5 or var_461_5 * (utf8.len(var_461_7) / 7)

				if (7 <= 0 and var_461_5 or var_461_5 * (utf8.len(var_461_7) / 7)) > 0 and var_461_5 < var_461_9 then
					arg_458_1.talkMaxDuration = var_461_9

					if var_461_9 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_9 + var_461_4
					end
				end

				arg_458_1.text_.text = var_461_7
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb") ~= 0 then
					local var_461_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb") / 1000

					if var_461_10 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_10 + var_461_4
					end

					if var_461_6.prefab_name ~= "" and arg_458_1.actors_[var_461_6.prefab_name] ~= nil then
						local var_461_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_6.prefab_name].transform, "story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb")

						arg_458_1:RecordAudio("1104701112", var_461_11)
						arg_458_1:RecordAudio("1104701112", var_461_11)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701112", "story_v_side_new_1104701.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_12 = math.max(var_461_5, arg_458_1.talkMaxDuration)

			if var_461_4 <= arg_458_1.time_ and arg_458_1.time_ < var_461_4 + var_461_12 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_4) / var_461_12

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_4 + var_461_12 and arg_458_1.time_ < var_461_4 + var_461_12 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play1104701113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1104701113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1104701114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1047ui_story"]) and arg_462_1.var_.characterEffect1047ui_story == nil then
				arg_462_1.var_.characterEffect1047ui_story = arg_462_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1047ui_story"]) then
				if arg_462_1.var_.characterEffect1047ui_story and not isNil(arg_462_1.actors_["1047ui_story"]) then
					arg_462_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_462_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_462_1.time_ - 0) / var_465_0)
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1047ui_story"]) and arg_462_1.var_.characterEffect1047ui_story then
				arg_462_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_462_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_465_1 = arg_462_1.actors_["1047ui_story"].transform

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos1047ui_story = var_465_1.localPosition
			end

			local var_465_2 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_2 then
				var_465_1.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_462_1.time_ - 0) / var_465_2)
				var_465_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_465_1.position).x, (manager.ui.mainCamera.transform.position - var_465_1.position).y, (manager.ui.mainCamera.transform.position - var_465_1.position).z)
				var_465_1.localEulerAngles.z = 0
				var_465_1.localEulerAngles.x = 0
				var_465_1.localEulerAngles = var_465_1.localEulerAngles
			end

			if arg_462_1.time_ >= 0 + var_465_2 and arg_462_1.time_ < 0 + var_465_2 + arg_465_0 then
				var_465_1.localPosition = Vector3.New(0, 100, 0)
				var_465_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_465_1.position).x, (manager.ui.mainCamera.transform.position - var_465_1.position).y, (manager.ui.mainCamera.transform.position - var_465_1.position).z)
				var_465_1.localEulerAngles.z = 0
				var_465_1.localEulerAngles.x = 0
				var_465_1.localEulerAngles = var_465_1.localEulerAngles
			end

			if 0.1 < arg_462_1.time_ and arg_462_1.time_ <= 0.1 + arg_465_0 then
				arg_462_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_465_4 = 0
			local var_465_5 = 0.925

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_6 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(1104701113).content)

				arg_462_1.text_.text = var_465_6

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_8 = 37 <= 0 and var_465_5 or var_465_5 * (utf8.len(var_465_6) / 37)

				if (37 <= 0 and var_465_5 or var_465_5 * (utf8.len(var_465_6) / 37)) > 0 and var_465_5 < var_465_8 then
					arg_462_1.talkMaxDuration = var_465_8

					if var_465_8 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_4
					end
				end

				arg_462_1.text_.text = var_465_6
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_9 = math.max(var_465_5, arg_462_1.talkMaxDuration)

			if var_465_4 <= arg_462_1.time_ and arg_462_1.time_ < var_465_4 + var_465_9 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_4) / var_465_9

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_4 + var_465_9 and arg_462_1.time_ < var_465_4 + var_465_9 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play1104701114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1104701114
		arg_466_1.duration_ = 5.63

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1104701115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0.575

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_1 = arg_466_1:GetWordFromCfg(1104701114)
				local var_469_2 = arg_466_1:FormatText(var_469_1.content)

				arg_466_1.text_.text = var_469_2

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_4 = 23 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 23)

				if (23 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 23)) > 0 and var_469_0 < var_469_4 then
					arg_466_1.talkMaxDuration = var_469_4

					if var_469_4 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_4 + 0
					end
				end

				arg_466_1.text_.text = var_469_2
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb") ~= 0 then
					local var_469_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb") / 1000

					if var_469_5 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + 0
					end

					if var_469_1.prefab_name ~= "" and arg_466_1.actors_[var_469_1.prefab_name] ~= nil then
						local var_469_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_1.prefab_name].transform, "story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb")

						arg_466_1:RecordAudio("1104701114", var_469_6)
						arg_466_1:RecordAudio("1104701114", var_469_6)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701114", "story_v_side_new_1104701.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_7 and arg_466_1.time_ < 0 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1104701115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1104701115
		arg_470_1.duration_ = 14.43

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1104701116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1047ui_story = arg_470_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1047ui_story"].transform.position).z)
				arg_470_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1047ui_story"].transform.localEulerAngles = arg_470_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_470_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1047ui_story"].transform.position).z)
				arg_470_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1047ui_story"].transform.localEulerAngles = arg_470_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_473_1 = arg_470_1.actors_["1047ui_story"]

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1047ui_story == nil then
				arg_470_1.var_.characterEffect1047ui_story = var_473_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_2 and not isNil(var_473_1) then
				if arg_470_1.var_.characterEffect1047ui_story and not isNil(var_473_1) then
					arg_470_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= 0 + var_473_2 and arg_470_1.time_ < 0 + var_473_2 + arg_473_0 and not isNil(var_473_1) and arg_470_1.var_.characterEffect1047ui_story then
				arg_470_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_473_4 = 0
			local var_473_5 = 1.65

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_4 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_6 = arg_470_1:GetWordFromCfg(1104701115)
				local var_473_7 = arg_470_1:FormatText(var_473_6.content)

				arg_470_1.text_.text = var_473_7

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_9 = 66 <= 0 and var_473_5 or var_473_5 * (utf8.len(var_473_7) / 66)

				if (66 <= 0 and var_473_5 or var_473_5 * (utf8.len(var_473_7) / 66)) > 0 and var_473_5 < var_473_9 then
					arg_470_1.talkMaxDuration = var_473_9

					if var_473_9 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_9 + var_473_4
					end
				end

				arg_470_1.text_.text = var_473_7
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb") ~= 0 then
					local var_473_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb") / 1000

					if var_473_10 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_10 + var_473_4
					end

					if var_473_6.prefab_name ~= "" and arg_470_1.actors_[var_473_6.prefab_name] ~= nil then
						local var_473_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_6.prefab_name].transform, "story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb")

						arg_470_1:RecordAudio("1104701115", var_473_11)
						arg_470_1:RecordAudio("1104701115", var_473_11)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701115", "story_v_side_new_1104701.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_12 = math.max(var_473_5, arg_470_1.talkMaxDuration)

			if var_473_4 <= arg_470_1.time_ and arg_470_1.time_ < var_473_4 + var_473_12 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_4) / var_473_12

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_4 + var_473_12 and arg_470_1.time_ < var_473_4 + var_473_12 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play1104701116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1104701116
		arg_474_1.duration_ = 6.27

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1104701117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1047ui_story = arg_474_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_477_0 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 then
				arg_474_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_474_1.time_ - 0) / var_477_0)
				arg_474_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1047ui_story"].transform.position).z)
				arg_474_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1047ui_story"].transform.localEulerAngles = arg_474_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 then
				arg_474_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_474_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1047ui_story"].transform.position).z)
				arg_474_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1047ui_story"].transform.localEulerAngles = arg_474_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_477_1 = 0
			local var_477_2 = 0.875

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_3 = arg_474_1:GetWordFromCfg(1104701116)
				local var_477_4 = arg_474_1:FormatText(var_477_3.content)

				arg_474_1.text_.text = var_477_4

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_6 = 35 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_4) / 35)

				if (35 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_4) / 35)) > 0 and var_477_2 < var_477_6 then
					arg_474_1.talkMaxDuration = var_477_6

					if var_477_6 + var_477_1 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_6 + var_477_1
					end
				end

				arg_474_1.text_.text = var_477_4
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb") ~= 0 then
					local var_477_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb") / 1000

					if var_477_7 + var_477_1 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_1
					end

					if var_477_3.prefab_name ~= "" and arg_474_1.actors_[var_477_3.prefab_name] ~= nil then
						local var_477_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_3.prefab_name].transform, "story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb")

						arg_474_1:RecordAudio("1104701116", var_477_8)
						arg_474_1:RecordAudio("1104701116", var_477_8)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701116", "story_v_side_new_1104701.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_9 = math.max(var_477_2, arg_474_1.talkMaxDuration)

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_9 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_1) / var_477_9

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_1 + var_477_9 and arg_474_1.time_ < var_477_1 + var_477_9 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play1104701117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1104701117
		arg_478_1.duration_ = 5.37

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1104701118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["1047ui_story"]) and arg_478_1.var_.characterEffect1047ui_story == nil then
				arg_478_1.var_.characterEffect1047ui_story = arg_478_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_0 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["1047ui_story"]) then
				if arg_478_1.var_.characterEffect1047ui_story and not isNil(arg_478_1.actors_["1047ui_story"]) then
					arg_478_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_478_1.time_ - 0) / var_481_0)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["1047ui_story"]) and arg_478_1.var_.characterEffect1047ui_story then
				arg_478_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_481_1 = arg_478_1.actors_["1047ui_story"].transform

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos1047ui_story = var_481_1.localPosition
			end

			local var_481_2 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_2 then
				var_481_1.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_478_1.time_ - 0) / var_481_2)
				var_481_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_481_1.position).x, (manager.ui.mainCamera.transform.position - var_481_1.position).y, (manager.ui.mainCamera.transform.position - var_481_1.position).z)
				var_481_1.localEulerAngles.z = 0
				var_481_1.localEulerAngles.x = 0
				var_481_1.localEulerAngles = var_481_1.localEulerAngles
			end

			if arg_478_1.time_ >= 0 + var_481_2 and arg_478_1.time_ < 0 + var_481_2 + arg_481_0 then
				var_481_1.localPosition = Vector3.New(0, 100, 0)
				var_481_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_481_1.position).x, (manager.ui.mainCamera.transform.position - var_481_1.position).y, (manager.ui.mainCamera.transform.position - var_481_1.position).z)
				var_481_1.localEulerAngles.z = 0
				var_481_1.localEulerAngles.x = 0
				var_481_1.localEulerAngles = var_481_1.localEulerAngles
			end

			local var_481_3 = 0
			local var_481_4 = 0.575

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_3 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_5 = arg_478_1:GetWordFromCfg(1104701117)
				local var_481_6 = arg_478_1:FormatText(var_481_5.content)

				arg_478_1.text_.text = var_481_6

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_8 = 23 <= 0 and var_481_4 or var_481_4 * (utf8.len(var_481_6) / 23)

				if (23 <= 0 and var_481_4 or var_481_4 * (utf8.len(var_481_6) / 23)) > 0 and var_481_4 < var_481_8 then
					arg_478_1.talkMaxDuration = var_481_8

					if var_481_8 + var_481_3 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_3
					end
				end

				arg_478_1.text_.text = var_481_6
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb") ~= 0 then
					local var_481_9 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb") / 1000

					if var_481_9 + var_481_3 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_9 + var_481_3
					end

					if var_481_5.prefab_name ~= "" and arg_478_1.actors_[var_481_5.prefab_name] ~= nil then
						local var_481_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_5.prefab_name].transform, "story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb")

						arg_478_1:RecordAudio("1104701117", var_481_10)
						arg_478_1:RecordAudio("1104701117", var_481_10)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701117", "story_v_side_new_1104701.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_11 = math.max(var_481_4, arg_478_1.talkMaxDuration)

			if var_481_3 <= arg_478_1.time_ and arg_478_1.time_ < var_481_3 + var_481_11 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_3) / var_481_11

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_3 + var_481_11 and arg_478_1.time_ < var_481_3 + var_481_11 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play1104701118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1104701118
		arg_482_1.duration_ = 5.7

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1104701119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.625

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_1 = arg_482_1:GetWordFromCfg(1104701118)
				local var_485_2 = arg_482_1:FormatText(var_485_1.content)

				arg_482_1.text_.text = var_485_2

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 25 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 25)

				if (25 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 25)) > 0 and var_485_0 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end

				arg_482_1.text_.text = var_485_2
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb") ~= 0 then
					local var_485_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb") / 1000

					if var_485_5 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + 0
					end

					if var_485_1.prefab_name ~= "" and arg_482_1.actors_[var_485_1.prefab_name] ~= nil then
						local var_485_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_1.prefab_name].transform, "story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb")

						arg_482_1:RecordAudio("1104701118", var_485_6)
						arg_482_1:RecordAudio("1104701118", var_485_6)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701118", "story_v_side_new_1104701.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1104701119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1104701119
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1104701120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 1.45

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_1 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(1104701119).content)

				arg_486_1.text_.text = var_489_1

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_3 = 58 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 58)

				if (58 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 58)) > 0 and var_489_0 < var_489_3 then
					arg_486_1.talkMaxDuration = var_489_3

					if var_489_3 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_3 + 0
					end
				end

				arg_486_1.text_.text = var_489_1
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_4 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_4 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_4

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_4 and arg_486_1.time_ < 0 + var_489_4 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1104701120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1104701120
		arg_490_1.duration_ = 8.97

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1104701121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos1047ui_story = arg_490_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_493_0 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 then
				arg_490_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_490_1.time_ - 0) / var_493_0)
				arg_490_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_490_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1047ui_story"].transform.position).z)
				arg_490_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_490_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_490_1.actors_["1047ui_story"].transform.localEulerAngles = arg_490_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 then
				arg_490_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_490_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_490_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["1047ui_story"].transform.position).z)
				arg_490_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_490_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_490_1.actors_["1047ui_story"].transform.localEulerAngles = arg_490_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_493_1 = arg_490_1.actors_["1047ui_story"]

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(var_493_1) and arg_490_1.var_.characterEffect1047ui_story == nil then
				arg_490_1.var_.characterEffect1047ui_story = var_493_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_2 and not isNil(var_493_1) then
				if arg_490_1.var_.characterEffect1047ui_story and not isNil(var_493_1) then
					arg_490_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_2 and arg_490_1.time_ < 0 + var_493_2 + arg_493_0 and not isNil(var_493_1) and arg_490_1.var_.characterEffect1047ui_story then
				arg_490_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_493_4 = 0
			local var_493_5 = 0.975

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_4 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_6 = arg_490_1:GetWordFromCfg(1104701120)
				local var_493_7 = arg_490_1:FormatText(var_493_6.content)

				arg_490_1.text_.text = var_493_7

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_9 = 39 <= 0 and var_493_5 or var_493_5 * (utf8.len(var_493_7) / 39)

				if (39 <= 0 and var_493_5 or var_493_5 * (utf8.len(var_493_7) / 39)) > 0 and var_493_5 < var_493_9 then
					arg_490_1.talkMaxDuration = var_493_9

					if var_493_9 + var_493_4 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_9 + var_493_4
					end
				end

				arg_490_1.text_.text = var_493_7
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb") ~= 0 then
					local var_493_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb") / 1000

					if var_493_10 + var_493_4 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_10 + var_493_4
					end

					if var_493_6.prefab_name ~= "" and arg_490_1.actors_[var_493_6.prefab_name] ~= nil then
						local var_493_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_6.prefab_name].transform, "story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb")

						arg_490_1:RecordAudio("1104701120", var_493_11)
						arg_490_1:RecordAudio("1104701120", var_493_11)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701120", "story_v_side_new_1104701.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_12 = math.max(var_493_5, arg_490_1.talkMaxDuration)

			if var_493_4 <= arg_490_1.time_ and arg_490_1.time_ < var_493_4 + var_493_12 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_4) / var_493_12

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_4 + var_493_12 and arg_490_1.time_ < var_493_4 + var_493_12 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play1104701121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1104701121
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1104701122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1047ui_story"]) and arg_494_1.var_.characterEffect1047ui_story == nil then
				arg_494_1.var_.characterEffect1047ui_story = arg_494_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_0 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1047ui_story"]) then
				if arg_494_1.var_.characterEffect1047ui_story and not isNil(arg_494_1.actors_["1047ui_story"]) then
					arg_494_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_0)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1047ui_story"]) and arg_494_1.var_.characterEffect1047ui_story then
				arg_494_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_497_1 = 0
			local var_497_2 = 0.4

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(1104701121).content)

				arg_494_1.text_.text = var_497_3

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 16 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 16)

				if (16 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 16)) > 0 and var_497_2 < var_497_5 then
					arg_494_1.talkMaxDuration = var_497_5

					if var_497_5 + var_497_1 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + var_497_1
					end
				end

				arg_494_1.text_.text = var_497_3
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_6 = math.max(var_497_2, arg_494_1.talkMaxDuration)

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_6 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_1) / var_497_6

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_1 + var_497_6 and arg_494_1.time_ < var_497_1 + var_497_6 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1104701122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1104701122
		arg_498_1.duration_ = 10.4

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1104701123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos1047ui_story = arg_498_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_501_0 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 then
				arg_498_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_498_1.time_ - 0) / var_501_0)
				arg_498_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).z)
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles = arg_498_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 then
				arg_498_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_498_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1047ui_story"].transform.position).z)
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1047ui_story"].transform.localEulerAngles = arg_498_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_501_1 = arg_498_1.actors_["1047ui_story"]

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(var_501_1) and arg_498_1.var_.characterEffect1047ui_story == nil then
				arg_498_1.var_.characterEffect1047ui_story = var_501_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_2 and not isNil(var_501_1) then
				if arg_498_1.var_.characterEffect1047ui_story and not isNil(var_501_1) then
					arg_498_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_2 and arg_498_1.time_ < 0 + var_501_2 + arg_501_0 and not isNil(var_501_1) and arg_498_1.var_.characterEffect1047ui_story then
				arg_498_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_501_4 = 0
			local var_501_5 = 1.05

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_6 = arg_498_1:GetWordFromCfg(1104701122)
				local var_501_7 = arg_498_1:FormatText(var_501_6.content)

				arg_498_1.text_.text = var_501_7

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 42 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 42)

				if (42 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 42)) > 0 and var_501_5 < var_501_9 then
					arg_498_1.talkMaxDuration = var_501_9

					if var_501_9 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_9 + var_501_4
					end
				end

				arg_498_1.text_.text = var_501_7
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb") ~= 0 then
					local var_501_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb") / 1000

					if var_501_10 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_10 + var_501_4
					end

					if var_501_6.prefab_name ~= "" and arg_498_1.actors_[var_501_6.prefab_name] ~= nil then
						local var_501_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_6.prefab_name].transform, "story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb")

						arg_498_1:RecordAudio("1104701122", var_501_11)
						arg_498_1:RecordAudio("1104701122", var_501_11)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701122", "story_v_side_new_1104701.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_12 = math.max(var_501_5, arg_498_1.talkMaxDuration)

			if var_501_4 <= arg_498_1.time_ and arg_498_1.time_ < var_501_4 + var_501_12 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_4) / var_501_12

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_4 + var_501_12 and arg_498_1.time_ < var_501_4 + var_501_12 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_498_1:InitPlayNodeList()
	end,
	Play1104701123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1104701123
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1104701124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["1047ui_story"]) and arg_502_1.var_.characterEffect1047ui_story == nil then
				arg_502_1.var_.characterEffect1047ui_story = arg_502_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_0 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["1047ui_story"]) then
				if arg_502_1.var_.characterEffect1047ui_story and not isNil(arg_502_1.actors_["1047ui_story"]) then
					arg_502_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_502_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_502_1.time_ - 0) / var_505_0)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["1047ui_story"]) and arg_502_1.var_.characterEffect1047ui_story then
				arg_502_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_502_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_505_1 = 0
			local var_505_2 = 0.575

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(1104701123).content)

				arg_502_1.text_.text = var_505_3

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 23 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_3) / 23)

				if (23 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_3) / 23)) > 0 and var_505_2 < var_505_5 then
					arg_502_1.talkMaxDuration = var_505_5

					if var_505_5 + var_505_1 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + var_505_1
					end
				end

				arg_502_1.text_.text = var_505_3
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_6 = math.max(var_505_2, arg_502_1.talkMaxDuration)

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_6 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_1) / var_505_6

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_1 + var_505_6 and arg_502_1.time_ < var_505_1 + var_505_6 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play1104701124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1104701124
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1104701125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0.95

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(1104701124).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 38 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 38)

				if (38 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 38)) > 0 and var_509_0 < var_509_3 then
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
	Play1104701125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1104701125
		arg_510_1.duration_ = 4.83

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1104701126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.var_.moveOldPos1047ui_story = arg_510_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_513_0 = 0.001

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 then
				arg_510_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_510_1.time_ - 0) / var_513_0)
				arg_510_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1047ui_story"].transform.position).z)
				arg_510_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["1047ui_story"].transform.localEulerAngles = arg_510_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 then
				arg_510_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_510_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1047ui_story"].transform.position).z)
				arg_510_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["1047ui_story"].transform.localEulerAngles = arg_510_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_513_1 = arg_510_1.actors_["1047ui_story"]

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect1047ui_story == nil then
				arg_510_1.var_.characterEffect1047ui_story = var_513_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_2 and not isNil(var_513_1) then
				if arg_510_1.var_.characterEffect1047ui_story and not isNil(var_513_1) then
					arg_510_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= 0 + var_513_2 and arg_510_1.time_ < 0 + var_513_2 + arg_513_0 and not isNil(var_513_1) and arg_510_1.var_.characterEffect1047ui_story then
				arg_510_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_513_4 = 0
			local var_513_5 = 0.425

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_4 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_6 = arg_510_1:GetWordFromCfg(1104701125)
				local var_513_7 = arg_510_1:FormatText(var_513_6.content)

				arg_510_1.text_.text = var_513_7

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_9 = 17 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 17)

				if (17 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 17)) > 0 and var_513_5 < var_513_9 then
					arg_510_1.talkMaxDuration = var_513_9

					if var_513_9 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_9 + var_513_4
					end
				end

				arg_510_1.text_.text = var_513_7
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb") ~= 0 then
					local var_513_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb") / 1000

					if var_513_10 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_10 + var_513_4
					end

					if var_513_6.prefab_name ~= "" and arg_510_1.actors_[var_513_6.prefab_name] ~= nil then
						local var_513_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_6.prefab_name].transform, "story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb")

						arg_510_1:RecordAudio("1104701125", var_513_11)
						arg_510_1:RecordAudio("1104701125", var_513_11)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701125", "story_v_side_new_1104701.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_12 = math.max(var_513_5, arg_510_1.talkMaxDuration)

			if var_513_4 <= arg_510_1.time_ and arg_510_1.time_ < var_513_4 + var_513_12 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_4) / var_513_12

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_4 + var_513_12 and arg_510_1.time_ < var_513_4 + var_513_12 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play1104701126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1104701126
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1104701127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(arg_514_1.actors_["1047ui_story"]) and arg_514_1.var_.characterEffect1047ui_story == nil then
				arg_514_1.var_.characterEffect1047ui_story = arg_514_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_0 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 and not isNil(arg_514_1.actors_["1047ui_story"]) then
				if arg_514_1.var_.characterEffect1047ui_story and not isNil(arg_514_1.actors_["1047ui_story"]) then
					arg_514_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_514_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_514_1.time_ - 0) / var_517_0)
				end
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 and not isNil(arg_514_1.actors_["1047ui_story"]) and arg_514_1.var_.characterEffect1047ui_story then
				arg_514_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_514_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_2")
			end

			local var_517_1 = 0
			local var_517_2 = 0.25

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_3 = arg_514_1:FormatText(arg_514_1:GetWordFromCfg(1104701126).content)

				arg_514_1.text_.text = var_517_3

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_5 = 10 <= 0 and var_517_2 or var_517_2 * (utf8.len(var_517_3) / 10)

				if (10 <= 0 and var_517_2 or var_517_2 * (utf8.len(var_517_3) / 10)) > 0 and var_517_2 < var_517_5 then
					arg_514_1.talkMaxDuration = var_517_5

					if var_517_5 + var_517_1 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_5 + var_517_1
					end
				end

				arg_514_1.text_.text = var_517_3
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_6 = math.max(var_517_2, arg_514_1.talkMaxDuration)

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_6 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_1) / var_517_6

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_1 + var_517_6 and arg_514_1.time_ < var_517_1 + var_517_6 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play1104701127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1104701127
		arg_518_1.duration_ = 2.77

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1104701128(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos1047ui_story = arg_518_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_521_0 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 then
				arg_518_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_518_1.time_ - 0) / var_521_0)
				arg_518_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_518_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["1047ui_story"].transform.position).z)
				arg_518_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_518_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_518_1.actors_["1047ui_story"].transform.localEulerAngles = arg_518_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 then
				arg_518_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_518_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_518_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["1047ui_story"].transform.position).z)
				arg_518_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_518_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_518_1.actors_["1047ui_story"].transform.localEulerAngles = arg_518_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_521_1 = arg_518_1.actors_["1047ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_1) and arg_518_1.var_.characterEffect1047ui_story == nil then
				arg_518_1.var_.characterEffect1047ui_story = var_521_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_2 and not isNil(var_521_1) then
				if arg_518_1.var_.characterEffect1047ui_story and not isNil(var_521_1) then
					arg_518_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= 0 + var_521_2 and arg_518_1.time_ < 0 + var_521_2 + arg_521_0 and not isNil(var_521_1) and arg_518_1.var_.characterEffect1047ui_story then
				arg_518_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_521_4 = 0
			local var_521_5 = 0.275

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_6 = arg_518_1:GetWordFromCfg(1104701127)
				local var_521_7 = arg_518_1:FormatText(var_521_6.content)

				arg_518_1.text_.text = var_521_7

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_9 = 11 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 11)

				if (11 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 11)) > 0 and var_521_5 < var_521_9 then
					arg_518_1.talkMaxDuration = var_521_9

					if var_521_9 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_9 + var_521_4
					end
				end

				arg_518_1.text_.text = var_521_7
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb") ~= 0 then
					local var_521_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb") / 1000

					if var_521_10 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_10 + var_521_4
					end

					if var_521_6.prefab_name ~= "" and arg_518_1.actors_[var_521_6.prefab_name] ~= nil then
						local var_521_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_6.prefab_name].transform, "story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb")

						arg_518_1:RecordAudio("1104701127", var_521_11)
						arg_518_1:RecordAudio("1104701127", var_521_11)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701127", "story_v_side_new_1104701.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_12 = math.max(var_521_5, arg_518_1.talkMaxDuration)

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_12 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_4) / var_521_12

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_4 + var_521_12 and arg_518_1.time_ < var_521_4 + var_521_12 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play1104701128 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1104701128
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1104701129(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["1047ui_story"]) and arg_522_1.var_.characterEffect1047ui_story == nil then
				arg_522_1.var_.characterEffect1047ui_story = arg_522_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_0 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["1047ui_story"]) then
				if arg_522_1.var_.characterEffect1047ui_story and not isNil(arg_522_1.actors_["1047ui_story"]) then
					arg_522_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 0) / var_525_0)
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["1047ui_story"]) and arg_522_1.var_.characterEffect1047ui_story then
				arg_522_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_525_1 = 0
			local var_525_2 = 0.95

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_3 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(1104701128).content)

				arg_522_1.text_.text = var_525_3

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 38 <= 0 and var_525_2 or var_525_2 * (utf8.len(var_525_3) / 38)

				if (38 <= 0 and var_525_2 or var_525_2 * (utf8.len(var_525_3) / 38)) > 0 and var_525_2 < var_525_5 then
					arg_522_1.talkMaxDuration = var_525_5

					if var_525_5 + var_525_1 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_5 + var_525_1
					end
				end

				arg_522_1.text_.text = var_525_3
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_6 = math.max(var_525_2, arg_522_1.talkMaxDuration)

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_6 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_1) / var_525_6

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_1 + var_525_6 and arg_522_1.time_ < var_525_1 + var_525_6 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play1104701129 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1104701129
		arg_526_1.duration_ = 6.2

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1104701130(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos1047ui_story = arg_526_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_529_0 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 then
				arg_526_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_526_1.time_ - 0) / var_529_0)
				arg_526_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1047ui_story"].transform.position).z)
				arg_526_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["1047ui_story"].transform.localEulerAngles = arg_526_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 then
				arg_526_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_526_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1047ui_story"].transform.position).z)
				arg_526_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["1047ui_story"].transform.localEulerAngles = arg_526_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_529_1 = arg_526_1.actors_["1047ui_story"]

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(var_529_1) and arg_526_1.var_.characterEffect1047ui_story == nil then
				arg_526_1.var_.characterEffect1047ui_story = var_529_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_2 and not isNil(var_529_1) then
				if arg_526_1.var_.characterEffect1047ui_story and not isNil(var_529_1) then
					arg_526_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= 0 + var_529_2 and arg_526_1.time_ < 0 + var_529_2 + arg_529_0 and not isNil(var_529_1) and arg_526_1.var_.characterEffect1047ui_story then
				arg_526_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_529_4 = 0
			local var_529_5 = 0.725

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_4 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_6 = arg_526_1:GetWordFromCfg(1104701129)
				local var_529_7 = arg_526_1:FormatText(var_529_6.content)

				arg_526_1.text_.text = var_529_7

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_9 = 28 <= 0 and var_529_5 or var_529_5 * (utf8.len(var_529_7) / 28)

				if (28 <= 0 and var_529_5 or var_529_5 * (utf8.len(var_529_7) / 28)) > 0 and var_529_5 < var_529_9 then
					arg_526_1.talkMaxDuration = var_529_9

					if var_529_9 + var_529_4 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_9 + var_529_4
					end
				end

				arg_526_1.text_.text = var_529_7
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb") ~= 0 then
					local var_529_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb") / 1000

					if var_529_10 + var_529_4 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_10 + var_529_4
					end

					if var_529_6.prefab_name ~= "" and arg_526_1.actors_[var_529_6.prefab_name] ~= nil then
						local var_529_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_6.prefab_name].transform, "story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb")

						arg_526_1:RecordAudio("1104701129", var_529_11)
						arg_526_1:RecordAudio("1104701129", var_529_11)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701129", "story_v_side_new_1104701.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_12 = math.max(var_529_5, arg_526_1.talkMaxDuration)

			if var_529_4 <= arg_526_1.time_ and arg_526_1.time_ < var_529_4 + var_529_12 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_4) / var_529_12

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_4 + var_529_12 and arg_526_1.time_ < var_529_4 + var_529_12 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play1104701130 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1104701130
		arg_530_1.duration_ = 9.6

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1104701131(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.var_.moveOldPos1047ui_story = arg_530_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_533_0 = 0.001

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 then
				arg_530_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_530_1.time_ - 0) / var_533_0)
				arg_530_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_530_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["1047ui_story"].transform.position).z)
				arg_530_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_530_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_530_1.actors_["1047ui_story"].transform.localEulerAngles = arg_530_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 then
				arg_530_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_530_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_530_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_530_1.actors_["1047ui_story"].transform.position).z)
				arg_530_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_530_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_530_1.actors_["1047ui_story"].transform.localEulerAngles = arg_530_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_533_1 = 0
			local var_533_2 = 0.95

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_3 = arg_530_1:GetWordFromCfg(1104701130)
				local var_533_4 = arg_530_1:FormatText(var_533_3.content)

				arg_530_1.text_.text = var_533_4

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_6 = 38 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_4) / 38)

				if (38 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_4) / 38)) > 0 and var_533_2 < var_533_6 then
					arg_530_1.talkMaxDuration = var_533_6

					if var_533_6 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_6 + var_533_1
					end
				end

				arg_530_1.text_.text = var_533_4
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb") ~= 0 then
					local var_533_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb") / 1000

					if var_533_7 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_7 + var_533_1
					end

					if var_533_3.prefab_name ~= "" and arg_530_1.actors_[var_533_3.prefab_name] ~= nil then
						local var_533_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_3.prefab_name].transform, "story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb")

						arg_530_1:RecordAudio("1104701130", var_533_8)
						arg_530_1:RecordAudio("1104701130", var_533_8)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701130", "story_v_side_new_1104701.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_9 = math.max(var_533_2, arg_530_1.talkMaxDuration)

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_9 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_1) / var_533_9

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_1 + var_533_9 and arg_530_1.time_ < var_533_1 + var_533_9 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_530_1:InitPlayNodeList()
	end,
	Play1104701131 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1104701131
		arg_534_1.duration_ = 1

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"

			SetActive(arg_534_1.choicesGo_, true)

			for iter_535_0, iter_535_1 in ipairs(arg_534_1.choices_) do
				SetActive(iter_535_1.go, iter_535_0 <= 2)
			end

			arg_534_1.choices_[1].txt.text = arg_534_1:FormatText(StoryChoiceCfg[1651].name)
			arg_534_1.choices_[2].txt.text = arg_534_1:FormatText(StoryChoiceCfg[1652].name)
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1104701132(arg_534_1)
			end

			if arg_536_0 == 2 then
				arg_534_0:Play1104701133(arg_534_1)
			end

			arg_534_1:RecordChoiceLog(1104701131, 1651, 1652)
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(arg_534_1.actors_["1047ui_story"]) and arg_534_1.var_.characterEffect1047ui_story == nil then
				arg_534_1.var_.characterEffect1047ui_story = arg_534_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_0 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 and not isNil(arg_534_1.actors_["1047ui_story"]) then
				if arg_534_1.var_.characterEffect1047ui_story and not isNil(arg_534_1.actors_["1047ui_story"]) then
					arg_534_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_534_1.time_ - 0) / var_537_0)
				end
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 and not isNil(arg_534_1.actors_["1047ui_story"]) and arg_534_1.var_.characterEffect1047ui_story then
				arg_534_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play1104701132 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1104701132
		arg_538_1.duration_ = 4.9

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1104701134(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.var_.moveOldPos1047ui_story = arg_538_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_541_0 = 0.001

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 then
				arg_538_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_538_1.time_ - 0) / var_541_0)
				arg_538_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1047ui_story"].transform.position).z)
				arg_538_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["1047ui_story"].transform.localEulerAngles = arg_538_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 then
				arg_538_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_538_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1047ui_story"].transform.position).z)
				arg_538_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["1047ui_story"].transform.localEulerAngles = arg_538_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_541_1 = arg_538_1.actors_["1047ui_story"]

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(var_541_1) and arg_538_1.var_.characterEffect1047ui_story == nil then
				arg_538_1.var_.characterEffect1047ui_story = var_541_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_2 and not isNil(var_541_1) then
				if arg_538_1.var_.characterEffect1047ui_story and not isNil(var_541_1) then
					arg_538_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= 0 + var_541_2 and arg_538_1.time_ < 0 + var_541_2 + arg_541_0 and not isNil(var_541_1) and arg_538_1.var_.characterEffect1047ui_story then
				arg_538_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_541_4 = 0
			local var_541_5 = 0.4

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_4 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_6 = arg_538_1:GetWordFromCfg(1104701132)
				local var_541_7 = arg_538_1:FormatText(var_541_6.content)

				arg_538_1.text_.text = var_541_7

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_9 = 16 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 16)

				if (16 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 16)) > 0 and var_541_5 < var_541_9 then
					arg_538_1.talkMaxDuration = var_541_9

					if var_541_9 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_9 + var_541_4
					end
				end

				arg_538_1.text_.text = var_541_7
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb") ~= 0 then
					local var_541_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb") / 1000

					if var_541_10 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_10 + var_541_4
					end

					if var_541_6.prefab_name ~= "" and arg_538_1.actors_[var_541_6.prefab_name] ~= nil then
						local var_541_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_6.prefab_name].transform, "story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb")

						arg_538_1:RecordAudio("1104701132", var_541_11)
						arg_538_1:RecordAudio("1104701132", var_541_11)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701132", "story_v_side_new_1104701.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_12 = math.max(var_541_5, arg_538_1.talkMaxDuration)

			if var_541_4 <= arg_538_1.time_ and arg_538_1.time_ < var_541_4 + var_541_12 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_4) / var_541_12

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_4 + var_541_12 and arg_538_1.time_ < var_541_4 + var_541_12 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play1104701134 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1104701134
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1104701135(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(arg_542_1.actors_["1047ui_story"]) and arg_542_1.var_.characterEffect1047ui_story == nil then
				arg_542_1.var_.characterEffect1047ui_story = arg_542_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_0 = 0.200000002980232

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 and not isNil(arg_542_1.actors_["1047ui_story"]) then
				if arg_542_1.var_.characterEffect1047ui_story and not isNil(arg_542_1.actors_["1047ui_story"]) then
					arg_542_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_542_1.time_ - 0) / var_545_0)
				end
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 and not isNil(arg_542_1.actors_["1047ui_story"]) and arg_542_1.var_.characterEffect1047ui_story then
				arg_542_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_545_1 = arg_542_1.actors_["1047ui_story"].transform

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.var_.moveOldPos1047ui_story = var_545_1.localPosition
			end

			local var_545_2 = 0.001

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_2 then
				var_545_1.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_542_1.time_ - 0) / var_545_2)
				var_545_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_545_1.position).x, (manager.ui.mainCamera.transform.position - var_545_1.position).y, (manager.ui.mainCamera.transform.position - var_545_1.position).z)
				var_545_1.localEulerAngles.z = 0
				var_545_1.localEulerAngles.x = 0
				var_545_1.localEulerAngles = var_545_1.localEulerAngles
			end

			if arg_542_1.time_ >= 0 + var_545_2 and arg_542_1.time_ < 0 + var_545_2 + arg_545_0 then
				var_545_1.localPosition = Vector3.New(0, 100, 0)
				var_545_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_545_1.position).x, (manager.ui.mainCamera.transform.position - var_545_1.position).y, (manager.ui.mainCamera.transform.position - var_545_1.position).z)
				var_545_1.localEulerAngles.z = 0
				var_545_1.localEulerAngles.x = 0
				var_545_1.localEulerAngles = var_545_1.localEulerAngles
			end

			local var_545_3 = 0
			local var_545_4 = 0.8

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_3 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_5 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(1104701134).content)

				arg_542_1.text_.text = var_545_5

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_7 = 32 <= 0 and var_545_4 or var_545_4 * (utf8.len(var_545_5) / 32)

				if (32 <= 0 and var_545_4 or var_545_4 * (utf8.len(var_545_5) / 32)) > 0 and var_545_4 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_3 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_3
					end
				end

				arg_542_1.text_.text = var_545_5
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_8 = math.max(var_545_4, arg_542_1.talkMaxDuration)

			if var_545_3 <= arg_542_1.time_ and arg_542_1.time_ < var_545_3 + var_545_8 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_3) / var_545_8

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_3 + var_545_8 and arg_542_1.time_ < var_545_3 + var_545_8 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_542_1:InitPlayNodeList()
	end,
	Play1104701135 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1104701135
		arg_546_1.duration_ = 2.2

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1104701136(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0.225

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_1 = arg_546_1:GetWordFromCfg(1104701135)
				local var_549_2 = arg_546_1:FormatText(var_549_1.content)

				arg_546_1.text_.text = var_549_2

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_4 = 9 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 9)

				if (9 <= 0 and var_549_0 or var_549_0 * (utf8.len(var_549_2) / 9)) > 0 and var_549_0 < var_549_4 then
					arg_546_1.talkMaxDuration = var_549_4

					if var_549_4 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_4 + 0
					end
				end

				arg_546_1.text_.text = var_549_2
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb") ~= 0 then
					local var_549_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb") / 1000

					if var_549_5 + 0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_5 + 0
					end

					if var_549_1.prefab_name ~= "" and arg_546_1.actors_[var_549_1.prefab_name] ~= nil then
						local var_549_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_1.prefab_name].transform, "story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb")

						arg_546_1:RecordAudio("1104701135", var_549_6)
						arg_546_1:RecordAudio("1104701135", var_549_6)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701135", "story_v_side_new_1104701.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_0, arg_546_1.talkMaxDuration)

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - 0) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= 0 + var_549_7 and arg_546_1.time_ < 0 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play1104701136 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 1104701136
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play1104701137(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0.75

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_1 = arg_550_1:FormatText(arg_550_1:GetWordFromCfg(1104701136).content)

				arg_550_1.text_.text = var_553_1

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_3 = 30 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_1) / 30)

				if (30 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_1) / 30)) > 0 and var_553_0 < var_553_3 then
					arg_550_1.talkMaxDuration = var_553_3

					if var_553_3 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_3 + 0
					end
				end

				arg_550_1.text_.text = var_553_1
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_4 = math.max(var_553_0, arg_550_1.talkMaxDuration)

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_4 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - 0) / var_553_4

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= 0 + var_553_4 and arg_550_1.time_ < 0 + var_553_4 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play1104701137 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 1104701137
		arg_554_1.duration_ = 4.43

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play1104701138(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.var_.moveOldPos1047ui_story = arg_554_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_557_0 = 0.001

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_0 then
				arg_554_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_554_1.time_ - 0) / var_557_0)
				arg_554_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_554_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1047ui_story"].transform.position).z)
				arg_554_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_554_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_554_1.actors_["1047ui_story"].transform.localEulerAngles = arg_554_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_554_1.time_ >= 0 + var_557_0 and arg_554_1.time_ < 0 + var_557_0 + arg_557_0 then
				arg_554_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_554_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_554_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1047ui_story"].transform.position).z)
				arg_554_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_554_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_554_1.actors_["1047ui_story"].transform.localEulerAngles = arg_554_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_557_1 = arg_554_1.actors_["1047ui_story"]

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(var_557_1) and arg_554_1.var_.characterEffect1047ui_story == nil then
				arg_554_1.var_.characterEffect1047ui_story = var_557_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_2 = 0.200000002980232

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_2 and not isNil(var_557_1) then
				if arg_554_1.var_.characterEffect1047ui_story and not isNil(var_557_1) then
					arg_554_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= 0 + var_557_2 and arg_554_1.time_ < 0 + var_557_2 + arg_557_0 and not isNil(var_557_1) and arg_554_1.var_.characterEffect1047ui_story then
				arg_554_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_557_4 = 0
			local var_557_5 = 0.525

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_4 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_6 = arg_554_1:GetWordFromCfg(1104701137)
				local var_557_7 = arg_554_1:FormatText(var_557_6.content)

				arg_554_1.text_.text = var_557_7

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_9 = 21 <= 0 and var_557_5 or var_557_5 * (utf8.len(var_557_7) / 21)

				if (21 <= 0 and var_557_5 or var_557_5 * (utf8.len(var_557_7) / 21)) > 0 and var_557_5 < var_557_9 then
					arg_554_1.talkMaxDuration = var_557_9

					if var_557_9 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_9 + var_557_4
					end
				end

				arg_554_1.text_.text = var_557_7
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb") ~= 0 then
					local var_557_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb") / 1000

					if var_557_10 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_10 + var_557_4
					end

					if var_557_6.prefab_name ~= "" and arg_554_1.actors_[var_557_6.prefab_name] ~= nil then
						local var_557_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_6.prefab_name].transform, "story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb")

						arg_554_1:RecordAudio("1104701137", var_557_11)
						arg_554_1:RecordAudio("1104701137", var_557_11)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701137", "story_v_side_new_1104701.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_12 = math.max(var_557_5, arg_554_1.talkMaxDuration)

			if var_557_4 <= arg_554_1.time_ and arg_554_1.time_ < var_557_4 + var_557_12 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_4) / var_557_12

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_4 + var_557_12 and arg_554_1.time_ < var_557_4 + var_557_12 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	Play1104701138 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1104701138
		arg_558_1.duration_ = 8.37

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1104701139(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(arg_558_1.actors_["1047ui_story"]) and arg_558_1.var_.characterEffect1047ui_story == nil then
				arg_558_1.var_.characterEffect1047ui_story = arg_558_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_0 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_0 and not isNil(arg_558_1.actors_["1047ui_story"]) then
				if arg_558_1.var_.characterEffect1047ui_story and not isNil(arg_558_1.actors_["1047ui_story"]) then
					arg_558_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_558_1.time_ - 0) / var_561_0)
				end
			end

			if arg_558_1.time_ >= 0 + var_561_0 and arg_558_1.time_ < 0 + var_561_0 + arg_561_0 and not isNil(arg_558_1.actors_["1047ui_story"]) and arg_558_1.var_.characterEffect1047ui_story then
				arg_558_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_561_1 = 0
			local var_561_2 = 1.025

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_3 = arg_558_1:GetWordFromCfg(1104701138)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_6 = 41 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_4) / 41)

				if (41 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_4) / 41)) > 0 and var_561_2 < var_561_6 then
					arg_558_1.talkMaxDuration = var_561_6

					if var_561_6 + var_561_1 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_6 + var_561_1
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb") ~= 0 then
					local var_561_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb") / 1000

					if var_561_7 + var_561_1 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_1
					end

					if var_561_3.prefab_name ~= "" and arg_558_1.actors_[var_561_3.prefab_name] ~= nil then
						local var_561_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_3.prefab_name].transform, "story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb")

						arg_558_1:RecordAudio("1104701138", var_561_8)
						arg_558_1:RecordAudio("1104701138", var_561_8)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701138", "story_v_side_new_1104701.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_9 = math.max(var_561_2, arg_558_1.talkMaxDuration)

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_9 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_1) / var_561_9

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_1 + var_561_9 and arg_558_1.time_ < var_561_1 + var_561_9 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play1104701139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1104701139
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1104701140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.var_.moveOldPos1047ui_story = arg_562_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_565_0 = 0.001

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_0 then
				arg_562_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_562_1.time_ - 0) / var_565_0)
				arg_562_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_562_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["1047ui_story"].transform.position).z)
				arg_562_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_562_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_562_1.actors_["1047ui_story"].transform.localEulerAngles = arg_562_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_562_1.time_ >= 0 + var_565_0 and arg_562_1.time_ < 0 + var_565_0 + arg_565_0 then
				arg_562_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_562_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_562_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["1047ui_story"].transform.position).z)
				arg_562_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_562_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_562_1.actors_["1047ui_story"].transform.localEulerAngles = arg_562_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_565_1 = 0
			local var_565_2 = 1.4

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_3 = arg_562_1:FormatText(arg_562_1:GetWordFromCfg(1104701139).content)

				arg_562_1.text_.text = var_565_3

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 56 <= 0 and var_565_2 or var_565_2 * (utf8.len(var_565_3) / 56)

				if (56 <= 0 and var_565_2 or var_565_2 * (utf8.len(var_565_3) / 56)) > 0 and var_565_2 < var_565_5 then
					arg_562_1.talkMaxDuration = var_565_5

					if var_565_5 + var_565_1 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_5 + var_565_1
					end
				end

				arg_562_1.text_.text = var_565_3
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_6 = math.max(var_565_2, arg_562_1.talkMaxDuration)

			if var_565_1 <= arg_562_1.time_ and arg_562_1.time_ < var_565_1 + var_565_6 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_1) / var_565_6

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_1 + var_565_6 and arg_562_1.time_ < var_565_1 + var_565_6 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play1104701140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1104701140
		arg_566_1.duration_ = 12.9

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1104701141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1.var_.moveOldPos1047ui_story = arg_566_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_569_0 = 0.001

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 then
				arg_566_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_566_1.time_ - 0) / var_569_0)
				arg_566_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_566_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1047ui_story"].transform.position).z)
				arg_566_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_566_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_566_1.actors_["1047ui_story"].transform.localEulerAngles = arg_566_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 then
				arg_566_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_566_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_566_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1047ui_story"].transform.position).z)
				arg_566_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_566_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_566_1.actors_["1047ui_story"].transform.localEulerAngles = arg_566_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_569_1 = arg_566_1.actors_["1047ui_story"]

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(var_569_1) and arg_566_1.var_.characterEffect1047ui_story == nil then
				arg_566_1.var_.characterEffect1047ui_story = var_569_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_2 = 0.200000002980232

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_2 and not isNil(var_569_1) then
				if arg_566_1.var_.characterEffect1047ui_story and not isNil(var_569_1) then
					arg_566_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= 0 + var_569_2 and arg_566_1.time_ < 0 + var_569_2 + arg_569_0 and not isNil(var_569_1) and arg_566_1.var_.characterEffect1047ui_story then
				arg_566_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_569_4 = 0
			local var_569_5 = 1.35

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_4 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_6 = arg_566_1:GetWordFromCfg(1104701140)
				local var_569_7 = arg_566_1:FormatText(var_569_6.content)

				arg_566_1.text_.text = var_569_7

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_9 = 54 <= 0 and var_569_5 or var_569_5 * (utf8.len(var_569_7) / 54)

				if (54 <= 0 and var_569_5 or var_569_5 * (utf8.len(var_569_7) / 54)) > 0 and var_569_5 < var_569_9 then
					arg_566_1.talkMaxDuration = var_569_9

					if var_569_9 + var_569_4 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_9 + var_569_4
					end
				end

				arg_566_1.text_.text = var_569_7
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb") ~= 0 then
					local var_569_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb") / 1000

					if var_569_10 + var_569_4 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_10 + var_569_4
					end

					if var_569_6.prefab_name ~= "" and arg_566_1.actors_[var_569_6.prefab_name] ~= nil then
						local var_569_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_6.prefab_name].transform, "story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb")

						arg_566_1:RecordAudio("1104701140", var_569_11)
						arg_566_1:RecordAudio("1104701140", var_569_11)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701140", "story_v_side_new_1104701.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_12 = math.max(var_569_5, arg_566_1.talkMaxDuration)

			if var_569_4 <= arg_566_1.time_ and arg_566_1.time_ < var_569_4 + var_569_12 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_4) / var_569_12

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_4 + var_569_12 and arg_566_1.time_ < var_569_4 + var_569_12 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play1104701141 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1104701141
		arg_570_1.duration_ = 9.7

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1104701142(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1.var_.moveOldPos1047ui_story = arg_570_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_573_0 = 0.001

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 then
				arg_570_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_570_1.time_ - 0) / var_573_0)
				arg_570_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_570_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["1047ui_story"].transform.position).z)
				arg_570_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_570_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_570_1.actors_["1047ui_story"].transform.localEulerAngles = arg_570_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 then
				arg_570_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_570_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_570_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["1047ui_story"].transform.position).z)
				arg_570_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_570_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_570_1.actors_["1047ui_story"].transform.localEulerAngles = arg_570_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_573_1 = 0
			local var_573_2 = 1.225

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_3 = arg_570_1:GetWordFromCfg(1104701141)
				local var_573_4 = arg_570_1:FormatText(var_573_3.content)

				arg_570_1.text_.text = var_573_4

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_6 = 49 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_4) / 49)

				if (49 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_4) / 49)) > 0 and var_573_2 < var_573_6 then
					arg_570_1.talkMaxDuration = var_573_6

					if var_573_6 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_6 + var_573_1
					end
				end

				arg_570_1.text_.text = var_573_4
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb") ~= 0 then
					local var_573_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb") / 1000

					if var_573_7 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_1
					end

					if var_573_3.prefab_name ~= "" and arg_570_1.actors_[var_573_3.prefab_name] ~= nil then
						local var_573_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_3.prefab_name].transform, "story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb")

						arg_570_1:RecordAudio("1104701141", var_573_8)
						arg_570_1:RecordAudio("1104701141", var_573_8)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701141", "story_v_side_new_1104701.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_9 = math.max(var_573_2, arg_570_1.talkMaxDuration)

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_9 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_1) / var_573_9

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_1 + var_573_9 and arg_570_1.time_ < var_573_1 + var_573_9 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701142 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1104701142
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1104701143(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["1047ui_story"]) and arg_574_1.var_.characterEffect1047ui_story == nil then
				arg_574_1.var_.characterEffect1047ui_story = arg_574_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_0 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["1047ui_story"]) then
				if arg_574_1.var_.characterEffect1047ui_story and not isNil(arg_574_1.actors_["1047ui_story"]) then
					arg_574_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_574_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_574_1.time_ - 0) / var_577_0)
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["1047ui_story"]) and arg_574_1.var_.characterEffect1047ui_story then
				arg_574_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_574_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_577_1 = arg_574_1.actors_["1047ui_story"].transform

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1.var_.moveOldPos1047ui_story = var_577_1.localPosition
			end

			local var_577_2 = 0.001

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_2 then
				var_577_1.localPosition = Vector3.Lerp(arg_574_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_574_1.time_ - 0) / var_577_2)
				var_577_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_577_1.position).x, (manager.ui.mainCamera.transform.position - var_577_1.position).y, (manager.ui.mainCamera.transform.position - var_577_1.position).z)
				var_577_1.localEulerAngles.z = 0
				var_577_1.localEulerAngles.x = 0
				var_577_1.localEulerAngles = var_577_1.localEulerAngles
			end

			if arg_574_1.time_ >= 0 + var_577_2 and arg_574_1.time_ < 0 + var_577_2 + arg_577_0 then
				var_577_1.localPosition = Vector3.New(0, 100, 0)
				var_577_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_577_1.position).x, (manager.ui.mainCamera.transform.position - var_577_1.position).y, (manager.ui.mainCamera.transform.position - var_577_1.position).z)
				var_577_1.localEulerAngles.z = 0
				var_577_1.localEulerAngles.x = 0
				var_577_1.localEulerAngles = var_577_1.localEulerAngles
			end

			local var_577_3 = 0
			local var_577_4 = 0.425

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_3 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, false)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_5 = arg_574_1:FormatText(arg_574_1:GetWordFromCfg(1104701142).content)

				arg_574_1.text_.text = var_577_5

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_7 = 17 <= 0 and var_577_4 or var_577_4 * (utf8.len(var_577_5) / 17)

				if (17 <= 0 and var_577_4 or var_577_4 * (utf8.len(var_577_5) / 17)) > 0 and var_577_4 < var_577_7 then
					arg_574_1.talkMaxDuration = var_577_7

					if var_577_7 + var_577_3 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_7 + var_577_3
					end
				end

				arg_574_1.text_.text = var_577_5
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_8 = math.max(var_577_4, arg_574_1.talkMaxDuration)

			if var_577_3 <= arg_574_1.time_ and arg_574_1.time_ < var_577_3 + var_577_8 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_3) / var_577_8

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_3 + var_577_8 and arg_574_1.time_ < var_577_3 + var_577_8 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_574_1:InitPlayNodeList()
	end,
	Play1104701143 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1104701143
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1104701144(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = 0.975

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, true)
				arg_578_1.iconController_:SetSelectedState("hero")

				arg_578_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_578_1.callingController_:SetSelectedState("normal")

				arg_578_1.keyicon_.color = Color.New(1, 1, 1)
				arg_578_1.icon_.color = Color.New(1, 1, 1)

				local var_581_1 = arg_578_1:FormatText(arg_578_1:GetWordFromCfg(1104701143).content)

				arg_578_1.text_.text = var_581_1

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_3 = 39 <= 0 and var_581_0 or var_581_0 * (utf8.len(var_581_1) / 39)

				if (39 <= 0 and var_581_0 or var_581_0 * (utf8.len(var_581_1) / 39)) > 0 and var_581_0 < var_581_3 then
					arg_578_1.talkMaxDuration = var_581_3

					if var_581_3 + 0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_3 + 0
					end
				end

				arg_578_1.text_.text = var_581_1
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_4 = math.max(var_581_0, arg_578_1.talkMaxDuration)

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_4 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - 0) / var_581_4

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= 0 + var_581_4 and arg_578_1.time_ < 0 + var_581_4 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play1104701144 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1104701144
		arg_582_1.duration_ = 7.83

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1104701145(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.var_.moveOldPos1047ui_story = arg_582_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_585_0 = 0.001

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 then
				arg_582_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_582_1.time_ - 0) / var_585_0)
				arg_582_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_582_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["1047ui_story"].transform.position).z)
				arg_582_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_582_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_582_1.actors_["1047ui_story"].transform.localEulerAngles = arg_582_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 then
				arg_582_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_582_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_582_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["1047ui_story"].transform.position).z)
				arg_582_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_582_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_582_1.actors_["1047ui_story"].transform.localEulerAngles = arg_582_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_585_1 = arg_582_1.actors_["1047ui_story"]

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(var_585_1) and arg_582_1.var_.characterEffect1047ui_story == nil then
				arg_582_1.var_.characterEffect1047ui_story = var_585_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_2 = 0.200000002980232

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_2 and not isNil(var_585_1) then
				if arg_582_1.var_.characterEffect1047ui_story and not isNil(var_585_1) then
					arg_582_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_582_1.time_ >= 0 + var_585_2 and arg_582_1.time_ < 0 + var_585_2 + arg_585_0 and not isNil(var_585_1) and arg_582_1.var_.characterEffect1047ui_story then
				arg_582_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.999999999998 < arg_582_1.time_ and arg_582_1.time_ <= 1.999999999998 + arg_585_0 then
				arg_582_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_2")
			end

			local var_585_4 = 0
			local var_585_5 = 0.85

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_4 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_6 = arg_582_1:GetWordFromCfg(1104701144)
				local var_585_7 = arg_582_1:FormatText(var_585_6.content)

				arg_582_1.text_.text = var_585_7

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_9 = 34 <= 0 and var_585_5 or var_585_5 * (utf8.len(var_585_7) / 34)

				if (34 <= 0 and var_585_5 or var_585_5 * (utf8.len(var_585_7) / 34)) > 0 and var_585_5 < var_585_9 then
					arg_582_1.talkMaxDuration = var_585_9

					if var_585_9 + var_585_4 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_9 + var_585_4
					end
				end

				arg_582_1.text_.text = var_585_7
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb") ~= 0 then
					local var_585_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb") / 1000

					if var_585_10 + var_585_4 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_10 + var_585_4
					end

					if var_585_6.prefab_name ~= "" and arg_582_1.actors_[var_585_6.prefab_name] ~= nil then
						local var_585_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_6.prefab_name].transform, "story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb")

						arg_582_1:RecordAudio("1104701144", var_585_11)
						arg_582_1:RecordAudio("1104701144", var_585_11)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701144", "story_v_side_new_1104701.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_12 = math.max(var_585_5, arg_582_1.talkMaxDuration)

			if var_585_4 <= arg_582_1.time_ and arg_582_1.time_ < var_585_4 + var_585_12 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_4) / var_585_12

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_4 + var_585_12 and arg_582_1.time_ < var_585_4 + var_585_12 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play1104701145 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1104701145
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1104701146(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 and not isNil(arg_586_1.actors_["1047ui_story"]) and arg_586_1.var_.characterEffect1047ui_story == nil then
				arg_586_1.var_.characterEffect1047ui_story = arg_586_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_0 = 0.200000002980232

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 and not isNil(arg_586_1.actors_["1047ui_story"]) then
				if arg_586_1.var_.characterEffect1047ui_story and not isNil(arg_586_1.actors_["1047ui_story"]) then
					arg_586_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_586_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_586_1.time_ - 0) / var_589_0)
				end
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 and not isNil(arg_586_1.actors_["1047ui_story"]) and arg_586_1.var_.characterEffect1047ui_story then
				arg_586_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_586_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_589_1 = arg_586_1.actors_["1047ui_story"].transform

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.var_.moveOldPos1047ui_story = var_589_1.localPosition
			end

			local var_589_2 = 0.001

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_2 then
				var_589_1.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_586_1.time_ - 0) / var_589_2)
				var_589_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_589_1.position).x, (manager.ui.mainCamera.transform.position - var_589_1.position).y, (manager.ui.mainCamera.transform.position - var_589_1.position).z)
				var_589_1.localEulerAngles.z = 0
				var_589_1.localEulerAngles.x = 0
				var_589_1.localEulerAngles = var_589_1.localEulerAngles
			end

			if arg_586_1.time_ >= 0 + var_589_2 and arg_586_1.time_ < 0 + var_589_2 + arg_589_0 then
				var_589_1.localPosition = Vector3.New(0, 100, 0)
				var_589_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_589_1.position).x, (manager.ui.mainCamera.transform.position - var_589_1.position).y, (manager.ui.mainCamera.transform.position - var_589_1.position).z)
				var_589_1.localEulerAngles.z = 0
				var_589_1.localEulerAngles.x = 0
				var_589_1.localEulerAngles = var_589_1.localEulerAngles
			end

			local var_589_3 = 0
			local var_589_4 = 0.55

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_3 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, true)
				arg_586_1.iconController_:SetSelectedState("hero")

				arg_586_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_586_1.callingController_:SetSelectedState("normal")

				arg_586_1.keyicon_.color = Color.New(1, 1, 1)
				arg_586_1.icon_.color = Color.New(1, 1, 1)

				local var_589_5 = arg_586_1:FormatText(arg_586_1:GetWordFromCfg(1104701145).content)

				arg_586_1.text_.text = var_589_5

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_7 = 22 <= 0 and var_589_4 or var_589_4 * (utf8.len(var_589_5) / 22)

				if (22 <= 0 and var_589_4 or var_589_4 * (utf8.len(var_589_5) / 22)) > 0 and var_589_4 < var_589_7 then
					arg_586_1.talkMaxDuration = var_589_7

					if var_589_7 + var_589_3 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_7 + var_589_3
					end
				end

				arg_586_1.text_.text = var_589_5
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_8 = math.max(var_589_4, arg_586_1.talkMaxDuration)

			if var_589_3 <= arg_586_1.time_ and arg_586_1.time_ < var_589_3 + var_589_8 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_3) / var_589_8

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_3 + var_589_8 and arg_586_1.time_ < var_589_3 + var_589_8 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701146 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1104701146
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1104701147(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = 1.525

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, false)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_1 = arg_590_1:FormatText(arg_590_1:GetWordFromCfg(1104701146).content)

				arg_590_1.text_.text = var_593_1

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_3 = 61 <= 0 and var_593_0 or var_593_0 * (utf8.len(var_593_1) / 61)

				if (61 <= 0 and var_593_0 or var_593_0 * (utf8.len(var_593_1) / 61)) > 0 and var_593_0 < var_593_3 then
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
	Play1104701147 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1104701147
		arg_594_1.duration_ = 1

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1104701148(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = 0.05

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				arg_594_1.leftNameTxt_.text = arg_594_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, true)
				arg_594_1.iconController_:SetSelectedState("hero")

				arg_594_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_594_1.callingController_:SetSelectedState("normal")

				arg_594_1.keyicon_.color = Color.New(1, 1, 1)
				arg_594_1.icon_.color = Color.New(1, 1, 1)

				local var_597_1 = arg_594_1:GetWordFromCfg(1104701147)
				local var_597_2 = arg_594_1:FormatText(var_597_1.content)

				arg_594_1.text_.text = var_597_2

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_4 = 2 <= 0 and var_597_0 or var_597_0 * (utf8.len(var_597_2) / 2)

				if (2 <= 0 and var_597_0 or var_597_0 * (utf8.len(var_597_2) / 2)) > 0 and var_597_0 < var_597_4 then
					arg_594_1.talkMaxDuration = var_597_4

					if var_597_4 + 0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_4 + 0
					end
				end

				arg_594_1.text_.text = var_597_2
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb") ~= 0 then
					local var_597_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb") / 1000

					if var_597_5 + 0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_5 + 0
					end

					if var_597_1.prefab_name ~= "" and arg_594_1.actors_[var_597_1.prefab_name] ~= nil then
						local var_597_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_1.prefab_name].transform, "story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb")

						arg_594_1:RecordAudio("1104701147", var_597_6)
						arg_594_1:RecordAudio("1104701147", var_597_6)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701147", "story_v_side_new_1104701.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_7 = math.max(var_597_0, arg_594_1.talkMaxDuration)

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_7 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - 0) / var_597_7

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= 0 + var_597_7 and arg_594_1.time_ < 0 + var_597_7 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play1104701148 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1104701148
		arg_598_1.duration_ = 10.77

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1104701149(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1.var_.moveOldPos1047ui_story = arg_598_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_601_0 = 0.001

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_0 then
				arg_598_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_598_1.time_ - 0) / var_601_0)
				arg_598_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_598_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["1047ui_story"].transform.position).z)
				arg_598_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_598_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_598_1.actors_["1047ui_story"].transform.localEulerAngles = arg_598_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_598_1.time_ >= 0 + var_601_0 and arg_598_1.time_ < 0 + var_601_0 + arg_601_0 then
				arg_598_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_598_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_598_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["1047ui_story"].transform.position).z)
				arg_598_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_598_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_598_1.actors_["1047ui_story"].transform.localEulerAngles = arg_598_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_601_1 = arg_598_1.actors_["1047ui_story"]

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(var_601_1) and arg_598_1.var_.characterEffect1047ui_story == nil then
				arg_598_1.var_.characterEffect1047ui_story = var_601_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_2 = 0.200000002980232

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_2 and not isNil(var_601_1) then
				if arg_598_1.var_.characterEffect1047ui_story and not isNil(var_601_1) then
					arg_598_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= 0 + var_601_2 and arg_598_1.time_ < 0 + var_601_2 + arg_601_0 and not isNil(var_601_1) and arg_598_1.var_.characterEffect1047ui_story then
				arg_598_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_601_4 = 0
			local var_601_5 = 1.225

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_4 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_6 = arg_598_1:GetWordFromCfg(1104701148)
				local var_601_7 = arg_598_1:FormatText(var_601_6.content)

				arg_598_1.text_.text = var_601_7

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_9 = 49 <= 0 and var_601_5 or var_601_5 * (utf8.len(var_601_7) / 49)

				if (49 <= 0 and var_601_5 or var_601_5 * (utf8.len(var_601_7) / 49)) > 0 and var_601_5 < var_601_9 then
					arg_598_1.talkMaxDuration = var_601_9

					if var_601_9 + var_601_4 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_9 + var_601_4
					end
				end

				arg_598_1.text_.text = var_601_7
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb") ~= 0 then
					local var_601_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb") / 1000

					if var_601_10 + var_601_4 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_10 + var_601_4
					end

					if var_601_6.prefab_name ~= "" and arg_598_1.actors_[var_601_6.prefab_name] ~= nil then
						local var_601_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_6.prefab_name].transform, "story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb")

						arg_598_1:RecordAudio("1104701148", var_601_11)
						arg_598_1:RecordAudio("1104701148", var_601_11)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701148", "story_v_side_new_1104701.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_12 = math.max(var_601_5, arg_598_1.talkMaxDuration)

			if var_601_4 <= arg_598_1.time_ and arg_598_1.time_ < var_601_4 + var_601_12 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_4) / var_601_12

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_4 + var_601_12 and arg_598_1.time_ < var_601_4 + var_601_12 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104701149 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1104701149
		arg_602_1.duration_ = 8.1

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1104701150(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1.var_.moveOldPos1047ui_story = arg_602_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_605_0 = 0.001

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_0 then
				arg_602_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_602_1.time_ - 0) / var_605_0)
				arg_602_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_602_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["1047ui_story"].transform.position).z)
				arg_602_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_602_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_602_1.actors_["1047ui_story"].transform.localEulerAngles = arg_602_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_602_1.time_ >= 0 + var_605_0 and arg_602_1.time_ < 0 + var_605_0 + arg_605_0 then
				arg_602_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_602_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_602_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["1047ui_story"].transform.position).z)
				arg_602_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_602_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_602_1.actors_["1047ui_story"].transform.localEulerAngles = arg_602_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_605_1 = 0
			local var_605_2 = 0.825

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_3 = arg_602_1:GetWordFromCfg(1104701149)
				local var_605_4 = arg_602_1:FormatText(var_605_3.content)

				arg_602_1.text_.text = var_605_4

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_6 = 33 <= 0 and var_605_2 or var_605_2 * (utf8.len(var_605_4) / 33)

				if (33 <= 0 and var_605_2 or var_605_2 * (utf8.len(var_605_4) / 33)) > 0 and var_605_2 < var_605_6 then
					arg_602_1.talkMaxDuration = var_605_6

					if var_605_6 + var_605_1 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_6 + var_605_1
					end
				end

				arg_602_1.text_.text = var_605_4
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb") ~= 0 then
					local var_605_7 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb") / 1000

					if var_605_7 + var_605_1 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_7 + var_605_1
					end

					if var_605_3.prefab_name ~= "" and arg_602_1.actors_[var_605_3.prefab_name] ~= nil then
						local var_605_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_3.prefab_name].transform, "story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb")

						arg_602_1:RecordAudio("1104701149", var_605_8)
						arg_602_1:RecordAudio("1104701149", var_605_8)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701149", "story_v_side_new_1104701.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_9 = math.max(var_605_2, arg_602_1.talkMaxDuration)

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_9 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_1) / var_605_9

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_1 + var_605_9 and arg_602_1.time_ < var_605_1 + var_605_9 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_602_1:InitPlayNodeList()
	end,
	Play1104701150 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1104701150
		arg_606_1.duration_ = 2.37

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1104701151(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 and not isNil(arg_606_1.actors_["1047ui_story"]) and arg_606_1.var_.characterEffect1047ui_story == nil then
				arg_606_1.var_.characterEffect1047ui_story = arg_606_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_0 = 0.200000002980232

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_0 and not isNil(arg_606_1.actors_["1047ui_story"]) then
				if arg_606_1.var_.characterEffect1047ui_story and not isNil(arg_606_1.actors_["1047ui_story"]) then
					arg_606_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_606_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_606_1.time_ - 0) / var_609_0)
				end
			end

			if arg_606_1.time_ >= 0 + var_609_0 and arg_606_1.time_ < 0 + var_609_0 + arg_609_0 and not isNil(arg_606_1.actors_["1047ui_story"]) and arg_606_1.var_.characterEffect1047ui_story then
				arg_606_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_606_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_609_1 = arg_606_1.actors_["1047ui_story"].transform

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1.var_.moveOldPos1047ui_story = var_609_1.localPosition
			end

			local var_609_2 = 0.001

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_2 then
				var_609_1.localPosition = Vector3.Lerp(arg_606_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_606_1.time_ - 0) / var_609_2)
				var_609_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_609_1.position).x, (manager.ui.mainCamera.transform.position - var_609_1.position).y, (manager.ui.mainCamera.transform.position - var_609_1.position).z)
				var_609_1.localEulerAngles.z = 0
				var_609_1.localEulerAngles.x = 0
				var_609_1.localEulerAngles = var_609_1.localEulerAngles
			end

			if arg_606_1.time_ >= 0 + var_609_2 and arg_606_1.time_ < 0 + var_609_2 + arg_609_0 then
				var_609_1.localPosition = Vector3.New(0, 100, 0)
				var_609_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_609_1.position).x, (manager.ui.mainCamera.transform.position - var_609_1.position).y, (manager.ui.mainCamera.transform.position - var_609_1.position).z)
				var_609_1.localEulerAngles.z = 0
				var_609_1.localEulerAngles.x = 0
				var_609_1.localEulerAngles = var_609_1.localEulerAngles
			end

			local var_609_3 = 0
			local var_609_4 = 0.25

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_3 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				arg_606_1.leftNameTxt_.text = arg_606_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, true)
				arg_606_1.iconController_:SetSelectedState("hero")

				arg_606_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_606_1.callingController_:SetSelectedState("normal")

				arg_606_1.keyicon_.color = Color.New(1, 1, 1)
				arg_606_1.icon_.color = Color.New(1, 1, 1)

				local var_609_5 = arg_606_1:GetWordFromCfg(1104701150)
				local var_609_6 = arg_606_1:FormatText(var_609_5.content)

				arg_606_1.text_.text = var_609_6

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_8 = 10 <= 0 and var_609_4 or var_609_4 * (utf8.len(var_609_6) / 10)

				if (10 <= 0 and var_609_4 or var_609_4 * (utf8.len(var_609_6) / 10)) > 0 and var_609_4 < var_609_8 then
					arg_606_1.talkMaxDuration = var_609_8

					if var_609_8 + var_609_3 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_8 + var_609_3
					end
				end

				arg_606_1.text_.text = var_609_6
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb") ~= 0 then
					local var_609_9 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb") / 1000

					if var_609_9 + var_609_3 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_9 + var_609_3
					end

					if var_609_5.prefab_name ~= "" and arg_606_1.actors_[var_609_5.prefab_name] ~= nil then
						local var_609_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_5.prefab_name].transform, "story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb")

						arg_606_1:RecordAudio("1104701150", var_609_10)
						arg_606_1:RecordAudio("1104701150", var_609_10)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701150", "story_v_side_new_1104701.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_11 = math.max(var_609_4, arg_606_1.talkMaxDuration)

			if var_609_3 <= arg_606_1.time_ and arg_606_1.time_ < var_609_3 + var_609_11 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_3) / var_609_11

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_3 + var_609_11 and arg_606_1.time_ < var_609_3 + var_609_11 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_606_1:InitPlayNodeList()
	end,
	Play1104701151 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1104701151
		arg_610_1.duration_ = 5

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1104701152(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = 0.625

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, false)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_1 = arg_610_1:FormatText(arg_610_1:GetWordFromCfg(1104701151).content)

				arg_610_1.text_.text = var_613_1

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_3 = 25 <= 0 and var_613_0 or var_613_0 * (utf8.len(var_613_1) / 25)

				if (25 <= 0 and var_613_0 or var_613_0 * (utf8.len(var_613_1) / 25)) > 0 and var_613_0 < var_613_3 then
					arg_610_1.talkMaxDuration = var_613_3

					if var_613_3 + 0 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_3 + 0
					end
				end

				arg_610_1.text_.text = var_613_1
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)
				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_4 = math.max(var_613_0, arg_610_1.talkMaxDuration)

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_4 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - 0) / var_613_4

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= 0 + var_613_4 and arg_610_1.time_ < 0 + var_613_4 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play1104701152 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1104701152
		arg_614_1.duration_ = 3.03

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1104701153(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = 0.35

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, true)
				arg_614_1.iconController_:SetSelectedState("hero")

				arg_614_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_614_1.callingController_:SetSelectedState("normal")

				arg_614_1.keyicon_.color = Color.New(1, 1, 1)
				arg_614_1.icon_.color = Color.New(1, 1, 1)

				local var_617_1 = arg_614_1:GetWordFromCfg(1104701152)
				local var_617_2 = arg_614_1:FormatText(var_617_1.content)

				arg_614_1.text_.text = var_617_2

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_4 = 14 <= 0 and var_617_0 or var_617_0 * (utf8.len(var_617_2) / 14)

				if (14 <= 0 and var_617_0 or var_617_0 * (utf8.len(var_617_2) / 14)) > 0 and var_617_0 < var_617_4 then
					arg_614_1.talkMaxDuration = var_617_4

					if var_617_4 + 0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_4 + 0
					end
				end

				arg_614_1.text_.text = var_617_2
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb") ~= 0 then
					local var_617_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb") / 1000

					if var_617_5 + 0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_5 + 0
					end

					if var_617_1.prefab_name ~= "" and arg_614_1.actors_[var_617_1.prefab_name] ~= nil then
						local var_617_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_1.prefab_name].transform, "story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb")

						arg_614_1:RecordAudio("1104701152", var_617_6)
						arg_614_1:RecordAudio("1104701152", var_617_6)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701152", "story_v_side_new_1104701.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_7 = math.max(var_617_0, arg_614_1.talkMaxDuration)

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_7 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - 0) / var_617_7

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= 0 + var_617_7 and arg_614_1.time_ < 0 + var_617_7 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play1104701153 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1104701153
		arg_618_1.duration_ = 6.07

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1104701154(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1.var_.moveOldPos1047ui_story = arg_618_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_621_0 = 0.001

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_0 then
				arg_618_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_618_1.time_ - 0) / var_621_0)
				arg_618_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_618_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1047ui_story"].transform.position).z)
				arg_618_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_618_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_618_1.actors_["1047ui_story"].transform.localEulerAngles = arg_618_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_618_1.time_ >= 0 + var_621_0 and arg_618_1.time_ < 0 + var_621_0 + arg_621_0 then
				arg_618_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_618_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_618_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1047ui_story"].transform.position).z)
				arg_618_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_618_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_618_1.actors_["1047ui_story"].transform.localEulerAngles = arg_618_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_621_1 = arg_618_1.actors_["1047ui_story"]

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 and not isNil(var_621_1) and arg_618_1.var_.characterEffect1047ui_story == nil then
				arg_618_1.var_.characterEffect1047ui_story = var_621_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_621_2 = 0.200000002980232

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_2 and not isNil(var_621_1) then
				if arg_618_1.var_.characterEffect1047ui_story and not isNil(var_621_1) then
					arg_618_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_618_1.time_ >= 0 + var_621_2 and arg_618_1.time_ < 0 + var_621_2 + arg_621_0 and not isNil(var_621_1) and arg_618_1.var_.characterEffect1047ui_story then
				arg_618_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_621_4 = 0
			local var_621_5 = 0.725

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= var_621_4 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				arg_618_1.leftNameTxt_.text = arg_618_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_6 = arg_618_1:GetWordFromCfg(1104701153)
				local var_621_7 = arg_618_1:FormatText(var_621_6.content)

				arg_618_1.text_.text = var_621_7

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_9 = 29 <= 0 and var_621_5 or var_621_5 * (utf8.len(var_621_7) / 29)

				if (29 <= 0 and var_621_5 or var_621_5 * (utf8.len(var_621_7) / 29)) > 0 and var_621_5 < var_621_9 then
					arg_618_1.talkMaxDuration = var_621_9

					if var_621_9 + var_621_4 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_9 + var_621_4
					end
				end

				arg_618_1.text_.text = var_621_7
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb") ~= 0 then
					local var_621_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb") / 1000

					if var_621_10 + var_621_4 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_10 + var_621_4
					end

					if var_621_6.prefab_name ~= "" and arg_618_1.actors_[var_621_6.prefab_name] ~= nil then
						local var_621_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_6.prefab_name].transform, "story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb")

						arg_618_1:RecordAudio("1104701153", var_621_11)
						arg_618_1:RecordAudio("1104701153", var_621_11)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701153", "story_v_side_new_1104701.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_12 = math.max(var_621_5, arg_618_1.talkMaxDuration)

			if var_621_4 <= arg_618_1.time_ and arg_618_1.time_ < var_621_4 + var_621_12 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_4) / var_621_12

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_4 + var_621_12 and arg_618_1.time_ < var_621_4 + var_621_12 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_618_1:InitPlayNodeList()
	end,
	Play1104701154 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1104701154
		arg_622_1.duration_ = 1

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1104701155(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 and not isNil(arg_622_1.actors_["1047ui_story"]) and arg_622_1.var_.characterEffect1047ui_story == nil then
				arg_622_1.var_.characterEffect1047ui_story = arg_622_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_625_0 = 0.200000002980232

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_0 and not isNil(arg_622_1.actors_["1047ui_story"]) then
				if arg_622_1.var_.characterEffect1047ui_story and not isNil(arg_622_1.actors_["1047ui_story"]) then
					arg_622_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_622_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_622_1.time_ - 0) / var_625_0)
				end
			end

			if arg_622_1.time_ >= 0 + var_625_0 and arg_622_1.time_ < 0 + var_625_0 + arg_625_0 and not isNil(arg_622_1.actors_["1047ui_story"]) and arg_622_1.var_.characterEffect1047ui_story then
				arg_622_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_622_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_625_1 = arg_622_1.actors_["1047ui_story"].transform

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.var_.moveOldPos1047ui_story = var_625_1.localPosition
			end

			local var_625_2 = 0.001

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_2 then
				var_625_1.localPosition = Vector3.Lerp(arg_622_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_622_1.time_ - 0) / var_625_2)
				var_625_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_625_1.position).x, (manager.ui.mainCamera.transform.position - var_625_1.position).y, (manager.ui.mainCamera.transform.position - var_625_1.position).z)
				var_625_1.localEulerAngles.z = 0
				var_625_1.localEulerAngles.x = 0
				var_625_1.localEulerAngles = var_625_1.localEulerAngles
			end

			if arg_622_1.time_ >= 0 + var_625_2 and arg_622_1.time_ < 0 + var_625_2 + arg_625_0 then
				var_625_1.localPosition = Vector3.New(0, 100, 0)
				var_625_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_625_1.position).x, (manager.ui.mainCamera.transform.position - var_625_1.position).y, (manager.ui.mainCamera.transform.position - var_625_1.position).z)
				var_625_1.localEulerAngles.z = 0
				var_625_1.localEulerAngles.x = 0
				var_625_1.localEulerAngles = var_625_1.localEulerAngles
			end

			local var_625_3 = 0
			local var_625_4 = 0.05

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= var_625_3 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_5 = arg_622_1:GetWordFromCfg(1104701154)
				local var_625_6 = arg_622_1:FormatText(var_625_5.content)

				arg_622_1.text_.text = var_625_6

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_8 = 2 <= 0 and var_625_4 or var_625_4 * (utf8.len(var_625_6) / 2)

				if (2 <= 0 and var_625_4 or var_625_4 * (utf8.len(var_625_6) / 2)) > 0 and var_625_4 < var_625_8 then
					arg_622_1.talkMaxDuration = var_625_8

					if var_625_8 + var_625_3 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_8 + var_625_3
					end
				end

				arg_622_1.text_.text = var_625_6
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb") ~= 0 then
					local var_625_9 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb") / 1000

					if var_625_9 + var_625_3 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_9 + var_625_3
					end

					if var_625_5.prefab_name ~= "" and arg_622_1.actors_[var_625_5.prefab_name] ~= nil then
						local var_625_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_5.prefab_name].transform, "story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb")

						arg_622_1:RecordAudio("1104701154", var_625_10)
						arg_622_1:RecordAudio("1104701154", var_625_10)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701154", "story_v_side_new_1104701.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_11 = math.max(var_625_4, arg_622_1.talkMaxDuration)

			if var_625_3 <= arg_622_1.time_ and arg_622_1.time_ < var_625_3 + var_625_11 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_3) / var_625_11

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_3 + var_625_11 and arg_622_1.time_ < var_625_3 + var_625_11 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_622_1:InitPlayNodeList()
	end,
	Play1104701155 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1104701155
		arg_626_1.duration_ = 5

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1104701156(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0.65

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, false)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_1 = arg_626_1:FormatText(arg_626_1:GetWordFromCfg(1104701155).content)

				arg_626_1.text_.text = var_629_1

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_3 = 26 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_1) / 26)

				if (26 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_1) / 26)) > 0 and var_629_0 < var_629_3 then
					arg_626_1.talkMaxDuration = var_629_3

					if var_629_3 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_3 + 0
					end
				end

				arg_626_1.text_.text = var_629_1
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)
				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_4 = math.max(var_629_0, arg_626_1.talkMaxDuration)

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_4 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - 0) / var_629_4

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= 0 + var_629_4 and arg_626_1.time_ < 0 + var_629_4 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play1104701156 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1104701156
		arg_630_1.duration_ = 6.03

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1104701157(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1.var_.moveOldPos1047ui_story = arg_630_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_633_0 = 0.001

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_0 then
				arg_630_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_630_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_630_1.time_ - 0) / var_633_0)
				arg_630_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_630_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_630_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_630_1.actors_["1047ui_story"].transform.position).z)
				arg_630_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_630_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_630_1.actors_["1047ui_story"].transform.localEulerAngles = arg_630_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_630_1.time_ >= 0 + var_633_0 and arg_630_1.time_ < 0 + var_633_0 + arg_633_0 then
				arg_630_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_630_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_630_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_630_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_630_1.actors_["1047ui_story"].transform.position).z)
				arg_630_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_630_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_630_1.actors_["1047ui_story"].transform.localEulerAngles = arg_630_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_633_1 = arg_630_1.actors_["1047ui_story"]

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 and not isNil(var_633_1) and arg_630_1.var_.characterEffect1047ui_story == nil then
				arg_630_1.var_.characterEffect1047ui_story = var_633_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_633_2 = 0.200000002980232

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_2 and not isNil(var_633_1) then
				if arg_630_1.var_.characterEffect1047ui_story and not isNil(var_633_1) then
					arg_630_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_630_1.time_ >= 0 + var_633_2 and arg_630_1.time_ < 0 + var_633_2 + arg_633_0 and not isNil(var_633_1) and arg_630_1.var_.characterEffect1047ui_story then
				arg_630_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_633_4 = 0
			local var_633_5 = 0.7

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= var_633_4 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				arg_630_1.leftNameTxt_.text = arg_630_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_6 = arg_630_1:GetWordFromCfg(1104701156)
				local var_633_7 = arg_630_1:FormatText(var_633_6.content)

				arg_630_1.text_.text = var_633_7

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_9 = 28 <= 0 and var_633_5 or var_633_5 * (utf8.len(var_633_7) / 28)

				if (28 <= 0 and var_633_5 or var_633_5 * (utf8.len(var_633_7) / 28)) > 0 and var_633_5 < var_633_9 then
					arg_630_1.talkMaxDuration = var_633_9

					if var_633_9 + var_633_4 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_9 + var_633_4
					end
				end

				arg_630_1.text_.text = var_633_7
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb") ~= 0 then
					local var_633_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb") / 1000

					if var_633_10 + var_633_4 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_10 + var_633_4
					end

					if var_633_6.prefab_name ~= "" and arg_630_1.actors_[var_633_6.prefab_name] ~= nil then
						local var_633_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_6.prefab_name].transform, "story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb")

						arg_630_1:RecordAudio("1104701156", var_633_11)
						arg_630_1:RecordAudio("1104701156", var_633_11)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701156", "story_v_side_new_1104701.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_12 = math.max(var_633_5, arg_630_1.talkMaxDuration)

			if var_633_4 <= arg_630_1.time_ and arg_630_1.time_ < var_633_4 + var_633_12 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_4) / var_633_12

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_4 + var_633_12 and arg_630_1.time_ < var_633_4 + var_633_12 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_630_1:InitPlayNodeList()
	end,
	Play1104701157 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1104701157
		arg_634_1.duration_ = 5

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play1104701158(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 and not isNil(arg_634_1.actors_["1047ui_story"]) and arg_634_1.var_.characterEffect1047ui_story == nil then
				arg_634_1.var_.characterEffect1047ui_story = arg_634_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_0 = 0.200000002980232

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_0 and not isNil(arg_634_1.actors_["1047ui_story"]) then
				if arg_634_1.var_.characterEffect1047ui_story and not isNil(arg_634_1.actors_["1047ui_story"]) then
					arg_634_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_634_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_634_1.time_ - 0) / var_637_0)
				end
			end

			if arg_634_1.time_ >= 0 + var_637_0 and arg_634_1.time_ < 0 + var_637_0 + arg_637_0 and not isNil(arg_634_1.actors_["1047ui_story"]) and arg_634_1.var_.characterEffect1047ui_story then
				arg_634_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_634_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_637_1 = 0
			local var_637_2 = 0.25

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_1 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, true)
				arg_634_1.iconController_:SetSelectedState("hero")

				arg_634_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_634_1.callingController_:SetSelectedState("normal")

				arg_634_1.keyicon_.color = Color.New(1, 1, 1)
				arg_634_1.icon_.color = Color.New(1, 1, 1)

				local var_637_3 = arg_634_1:FormatText(arg_634_1:GetWordFromCfg(1104701157).content)

				arg_634_1.text_.text = var_637_3

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_5 = 10 <= 0 and var_637_2 or var_637_2 * (utf8.len(var_637_3) / 10)

				if (10 <= 0 and var_637_2 or var_637_2 * (utf8.len(var_637_3) / 10)) > 0 and var_637_2 < var_637_5 then
					arg_634_1.talkMaxDuration = var_637_5

					if var_637_5 + var_637_1 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_5 + var_637_1
					end
				end

				arg_634_1.text_.text = var_637_3
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)
				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_6 = math.max(var_637_2, arg_634_1.talkMaxDuration)

			if var_637_1 <= arg_634_1.time_ and arg_634_1.time_ < var_637_1 + var_637_6 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_1) / var_637_6

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_1 + var_637_6 and arg_634_1.time_ < var_637_1 + var_637_6 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play1104701158 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 1104701158
		arg_638_1.duration_ = 6.53

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play1104701159(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1.var_.moveOldPos1047ui_story = arg_638_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_641_0 = 0.001

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_0 then
				arg_638_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_638_1.time_ - 0) / var_641_0)
				arg_638_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_638_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["1047ui_story"].transform.position).z)
				arg_638_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_638_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_638_1.actors_["1047ui_story"].transform.localEulerAngles = arg_638_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_638_1.time_ >= 0 + var_641_0 and arg_638_1.time_ < 0 + var_641_0 + arg_641_0 then
				arg_638_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_638_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_638_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_638_1.actors_["1047ui_story"].transform.position).z)
				arg_638_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_638_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_638_1.actors_["1047ui_story"].transform.localEulerAngles = arg_638_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_641_1 = arg_638_1.actors_["1047ui_story"]

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 and not isNil(var_641_1) and arg_638_1.var_.characterEffect1047ui_story == nil then
				arg_638_1.var_.characterEffect1047ui_story = var_641_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_641_2 = 0.200000002980232

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_2 and not isNil(var_641_1) then
				if arg_638_1.var_.characterEffect1047ui_story and not isNil(var_641_1) then
					arg_638_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_638_1.time_ >= 0 + var_641_2 and arg_638_1.time_ < 0 + var_641_2 + arg_641_0 and not isNil(var_641_1) and arg_638_1.var_.characterEffect1047ui_story then
				arg_638_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_641_4 = 0
			local var_641_5 = 0.7

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_4 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, true)

				arg_638_1.leftNameTxt_.text = arg_638_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_638_1.leftNameTxt_.transform)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1.leftNameTxt_.text)
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_6 = arg_638_1:GetWordFromCfg(1104701158)
				local var_641_7 = arg_638_1:FormatText(var_641_6.content)

				arg_638_1.text_.text = var_641_7

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_9 = 28 <= 0 and var_641_5 or var_641_5 * (utf8.len(var_641_7) / 28)

				if (28 <= 0 and var_641_5 or var_641_5 * (utf8.len(var_641_7) / 28)) > 0 and var_641_5 < var_641_9 then
					arg_638_1.talkMaxDuration = var_641_9

					if var_641_9 + var_641_4 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_9 + var_641_4
					end
				end

				arg_638_1.text_.text = var_641_7
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb") ~= 0 then
					local var_641_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb") / 1000

					if var_641_10 + var_641_4 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_10 + var_641_4
					end

					if var_641_6.prefab_name ~= "" and arg_638_1.actors_[var_641_6.prefab_name] ~= nil then
						local var_641_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_6.prefab_name].transform, "story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb")

						arg_638_1:RecordAudio("1104701158", var_641_11)
						arg_638_1:RecordAudio("1104701158", var_641_11)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701158", "story_v_side_new_1104701.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_12 = math.max(var_641_5, arg_638_1.talkMaxDuration)

			if var_641_4 <= arg_638_1.time_ and arg_638_1.time_ < var_641_4 + var_641_12 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_4) / var_641_12

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_4 + var_641_12 and arg_638_1.time_ < var_641_4 + var_641_12 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_638_1:InitPlayNodeList()
	end,
	Play1104701159 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1104701159
		arg_642_1.duration_ = 5

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1104701160(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 and not isNil(arg_642_1.actors_["1047ui_story"]) and arg_642_1.var_.characterEffect1047ui_story == nil then
				arg_642_1.var_.characterEffect1047ui_story = arg_642_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_0 = 0.200000002980232

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_0 and not isNil(arg_642_1.actors_["1047ui_story"]) then
				if arg_642_1.var_.characterEffect1047ui_story and not isNil(arg_642_1.actors_["1047ui_story"]) then
					arg_642_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_642_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_642_1.time_ - 0) / var_645_0)
				end
			end

			if arg_642_1.time_ >= 0 + var_645_0 and arg_642_1.time_ < 0 + var_645_0 + arg_645_0 and not isNil(arg_642_1.actors_["1047ui_story"]) and arg_642_1.var_.characterEffect1047ui_story then
				arg_642_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_642_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_645_1 = 0
			local var_645_2 = 0.4

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_1 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				arg_642_1.leftNameTxt_.text = arg_642_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, true)
				arg_642_1.iconController_:SetSelectedState("hero")

				arg_642_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_642_1.callingController_:SetSelectedState("normal")

				arg_642_1.keyicon_.color = Color.New(1, 1, 1)
				arg_642_1.icon_.color = Color.New(1, 1, 1)

				local var_645_3 = arg_642_1:FormatText(arg_642_1:GetWordFromCfg(1104701159).content)

				arg_642_1.text_.text = var_645_3

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_5 = 16 <= 0 and var_645_2 or var_645_2 * (utf8.len(var_645_3) / 16)

				if (16 <= 0 and var_645_2 or var_645_2 * (utf8.len(var_645_3) / 16)) > 0 and var_645_2 < var_645_5 then
					arg_642_1.talkMaxDuration = var_645_5

					if var_645_5 + var_645_1 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_5 + var_645_1
					end
				end

				arg_642_1.text_.text = var_645_3
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_6 = math.max(var_645_2, arg_642_1.talkMaxDuration)

			if var_645_1 <= arg_642_1.time_ and arg_642_1.time_ < var_645_1 + var_645_6 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_1) / var_645_6

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_1 + var_645_6 and arg_642_1.time_ < var_645_1 + var_645_6 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play1104701160 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1104701160
		arg_646_1.duration_ = 5

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1104701161(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1.var_.moveOldPos1047ui_story = arg_646_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_649_0 = 0.001

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_0 then
				arg_646_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_646_1.time_ - 0) / var_649_0)
				arg_646_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_646_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["1047ui_story"].transform.position).z)
				arg_646_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_646_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_646_1.actors_["1047ui_story"].transform.localEulerAngles = arg_646_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_646_1.time_ >= 0 + var_649_0 and arg_646_1.time_ < 0 + var_649_0 + arg_649_0 then
				arg_646_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_646_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_646_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_646_1.actors_["1047ui_story"].transform.position).z)
				arg_646_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_646_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_646_1.actors_["1047ui_story"].transform.localEulerAngles = arg_646_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_649_1 = 0
			local var_649_2 = 0.35

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_1 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_3 = arg_646_1:FormatText(arg_646_1:GetWordFromCfg(1104701160).content)

				arg_646_1.text_.text = var_649_3

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_5 = 14 <= 0 and var_649_2 or var_649_2 * (utf8.len(var_649_3) / 14)

				if (14 <= 0 and var_649_2 or var_649_2 * (utf8.len(var_649_3) / 14)) > 0 and var_649_2 < var_649_5 then
					arg_646_1.talkMaxDuration = var_649_5

					if var_649_5 + var_649_1 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_5 + var_649_1
					end
				end

				arg_646_1.text_.text = var_649_3
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_6 = math.max(var_649_2, arg_646_1.talkMaxDuration)

			if var_649_1 <= arg_646_1.time_ and arg_646_1.time_ < var_649_1 + var_649_6 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_1) / var_649_6

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_1 + var_649_6 and arg_646_1.time_ < var_649_1 + var_649_6 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_646_1:InitPlayNodeList()
	end,
	Play1104701161 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 1104701161
		arg_650_1.duration_ = 9.03

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play1104701162(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1.var_.moveOldPos1047ui_story = arg_650_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_653_0 = 0.001

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_0 then
				arg_650_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_650_1.time_ - 0) / var_653_0)
				arg_650_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_650_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["1047ui_story"].transform.position).z)
				arg_650_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_650_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_650_1.actors_["1047ui_story"].transform.localEulerAngles = arg_650_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_650_1.time_ >= 0 + var_653_0 and arg_650_1.time_ < 0 + var_653_0 + arg_653_0 then
				arg_650_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_650_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_650_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_650_1.actors_["1047ui_story"].transform.position).z)
				arg_650_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_650_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_650_1.actors_["1047ui_story"].transform.localEulerAngles = arg_650_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_653_1 = arg_650_1.actors_["1047ui_story"]

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 and not isNil(var_653_1) and arg_650_1.var_.characterEffect1047ui_story == nil then
				arg_650_1.var_.characterEffect1047ui_story = var_653_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_653_2 = 0.200000002980232

			if 0 <= arg_650_1.time_ and arg_650_1.time_ < 0 + var_653_2 and not isNil(var_653_1) then
				if arg_650_1.var_.characterEffect1047ui_story and not isNil(var_653_1) then
					arg_650_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_650_1.time_ >= 0 + var_653_2 and arg_650_1.time_ < 0 + var_653_2 + arg_653_0 and not isNil(var_653_1) and arg_650_1.var_.characterEffect1047ui_story then
				arg_650_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action476")
			end

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= 0 + arg_653_0 then
				arg_650_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_653_4 = 0
			local var_653_5 = 0.8

			if 0 < arg_650_1.time_ and arg_650_1.time_ <= var_653_4 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				arg_650_1.leftNameTxt_.text = arg_650_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, false)
				arg_650_1.callingController_:SetSelectedState("normal")

				local var_653_6 = arg_650_1:GetWordFromCfg(1104701161)
				local var_653_7 = arg_650_1:FormatText(var_653_6.content)

				arg_650_1.text_.text = var_653_7

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_9 = 32 <= 0 and var_653_5 or var_653_5 * (utf8.len(var_653_7) / 32)

				if (32 <= 0 and var_653_5 or var_653_5 * (utf8.len(var_653_7) / 32)) > 0 and var_653_5 < var_653_9 then
					arg_650_1.talkMaxDuration = var_653_9

					if var_653_9 + var_653_4 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_9 + var_653_4
					end
				end

				arg_650_1.text_.text = var_653_7
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb") ~= 0 then
					local var_653_10 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb") / 1000

					if var_653_10 + var_653_4 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_10 + var_653_4
					end

					if var_653_6.prefab_name ~= "" and arg_650_1.actors_[var_653_6.prefab_name] ~= nil then
						local var_653_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_6.prefab_name].transform, "story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb")

						arg_650_1:RecordAudio("1104701161", var_653_11)
						arg_650_1:RecordAudio("1104701161", var_653_11)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701161", "story_v_side_new_1104701.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_12 = math.max(var_653_5, arg_650_1.talkMaxDuration)

			if var_653_4 <= arg_650_1.time_ and arg_650_1.time_ < var_653_4 + var_653_12 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_4) / var_653_12

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_4 + var_653_12 and arg_650_1.time_ < var_653_4 + var_653_12 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_650_1:InitPlayNodeList()
	end,
	Play1104701162 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 1104701162
		arg_654_1.duration_ = 5

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play1104701163(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			if 0 < arg_654_1.time_ and arg_654_1.time_ <= 0 + arg_657_0 and not isNil(arg_654_1.actors_["1047ui_story"]) and arg_654_1.var_.characterEffect1047ui_story == nil then
				arg_654_1.var_.characterEffect1047ui_story = arg_654_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_657_0 = 0.200000002980232

			if 0 <= arg_654_1.time_ and arg_654_1.time_ < 0 + var_657_0 and not isNil(arg_654_1.actors_["1047ui_story"]) then
				if arg_654_1.var_.characterEffect1047ui_story and not isNil(arg_654_1.actors_["1047ui_story"]) then
					arg_654_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_654_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_654_1.time_ - 0) / var_657_0)
				end
			end

			if arg_654_1.time_ >= 0 + var_657_0 and arg_654_1.time_ < 0 + var_657_0 + arg_657_0 and not isNil(arg_654_1.actors_["1047ui_story"]) and arg_654_1.var_.characterEffect1047ui_story then
				arg_654_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_654_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_657_1 = 0
			local var_657_2 = 0.75

			if 0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_1 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				arg_654_1.leftNameTxt_.text = arg_654_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, true)
				arg_654_1.iconController_:SetSelectedState("hero")

				arg_654_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_654_1.callingController_:SetSelectedState("normal")

				arg_654_1.keyicon_.color = Color.New(1, 1, 1)
				arg_654_1.icon_.color = Color.New(1, 1, 1)

				local var_657_3 = arg_654_1:FormatText(arg_654_1:GetWordFromCfg(1104701162).content)

				arg_654_1.text_.text = var_657_3

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_5 = 30 <= 0 and var_657_2 or var_657_2 * (utf8.len(var_657_3) / 30)

				if (30 <= 0 and var_657_2 or var_657_2 * (utf8.len(var_657_3) / 30)) > 0 and var_657_2 < var_657_5 then
					arg_654_1.talkMaxDuration = var_657_5

					if var_657_5 + var_657_1 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_5 + var_657_1
					end
				end

				arg_654_1.text_.text = var_657_3
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)
				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_6 = math.max(var_657_2, arg_654_1.talkMaxDuration)

			if var_657_1 <= arg_654_1.time_ and arg_654_1.time_ < var_657_1 + var_657_6 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_1) / var_657_6

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_1 + var_657_6 and arg_654_1.time_ < var_657_1 + var_657_6 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play1104701163 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 1104701163
		arg_658_1.duration_ = 4.43

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play1104701164(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 and not isNil(arg_658_1.actors_["1047ui_story"]) and arg_658_1.var_.characterEffect1047ui_story == nil then
				arg_658_1.var_.characterEffect1047ui_story = arg_658_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_661_0 = 0.200000002980232

			if 0 <= arg_658_1.time_ and arg_658_1.time_ < 0 + var_661_0 and not isNil(arg_658_1.actors_["1047ui_story"]) then
				if arg_658_1.var_.characterEffect1047ui_story and not isNil(arg_658_1.actors_["1047ui_story"]) then
					arg_658_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_658_1.time_ >= 0 + var_661_0 and arg_658_1.time_ < 0 + var_661_0 + arg_661_0 and not isNil(arg_658_1.actors_["1047ui_story"]) and arg_658_1.var_.characterEffect1047ui_story then
				arg_658_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= 0 + arg_661_0 then
				arg_658_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_661_2 = 0
			local var_661_3 = 0.45

			if 0 < arg_658_1.time_ and arg_658_1.time_ <= var_661_2 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				arg_658_1.leftNameTxt_.text = arg_658_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, false)
				arg_658_1.callingController_:SetSelectedState("normal")

				local var_661_4 = arg_658_1:GetWordFromCfg(1104701163)
				local var_661_5 = arg_658_1:FormatText(var_661_4.content)

				arg_658_1.text_.text = var_661_5

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_7 = 18 <= 0 and var_661_3 or var_661_3 * (utf8.len(var_661_5) / 18)

				if (18 <= 0 and var_661_3 or var_661_3 * (utf8.len(var_661_5) / 18)) > 0 and var_661_3 < var_661_7 then
					arg_658_1.talkMaxDuration = var_661_7

					if var_661_7 + var_661_2 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_7 + var_661_2
					end
				end

				arg_658_1.text_.text = var_661_5
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb") ~= 0 then
					local var_661_8 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb") / 1000

					if var_661_8 + var_661_2 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_8 + var_661_2
					end

					if var_661_4.prefab_name ~= "" and arg_658_1.actors_[var_661_4.prefab_name] ~= nil then
						local var_661_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_658_1.actors_[var_661_4.prefab_name].transform, "story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb")

						arg_658_1:RecordAudio("1104701163", var_661_9)
						arg_658_1:RecordAudio("1104701163", var_661_9)
					else
						arg_658_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb")
					end

					arg_658_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701163", "story_v_side_new_1104701.awb")
				end

				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_10 = math.max(var_661_3, arg_658_1.talkMaxDuration)

			if var_661_2 <= arg_658_1.time_ and arg_658_1.time_ < var_661_2 + var_661_10 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_2) / var_661_10

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_2 + var_661_10 and arg_658_1.time_ < var_661_2 + var_661_10 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {}

		arg_658_1:InitPlayNodeList()
	end,
	Play1104701164 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 1104701164
		arg_662_1.duration_ = 5.23

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play1104701165(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			local var_665_0 = 0.55

			if 0 < arg_662_1.time_ and arg_662_1.time_ <= 0 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				arg_662_1.leftNameTxt_.text = arg_662_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_1 = arg_662_1:GetWordFromCfg(1104701164)
				local var_665_2 = arg_662_1:FormatText(var_665_1.content)

				arg_662_1.text_.text = var_665_2

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_4 = 22 <= 0 and var_665_0 or var_665_0 * (utf8.len(var_665_2) / 22)

				if (22 <= 0 and var_665_0 or var_665_0 * (utf8.len(var_665_2) / 22)) > 0 and var_665_0 < var_665_4 then
					arg_662_1.talkMaxDuration = var_665_4

					if var_665_4 + 0 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_4 + 0
					end
				end

				arg_662_1.text_.text = var_665_2
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb") ~= 0 then
					local var_665_5 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb") / 1000

					if var_665_5 + 0 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_5 + 0
					end

					if var_665_1.prefab_name ~= "" and arg_662_1.actors_[var_665_1.prefab_name] ~= nil then
						local var_665_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_1.prefab_name].transform, "story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb")

						arg_662_1:RecordAudio("1104701164", var_665_6)
						arg_662_1:RecordAudio("1104701164", var_665_6)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701164", "story_v_side_new_1104701.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_7 = math.max(var_665_0, arg_662_1.talkMaxDuration)

			if 0 <= arg_662_1.time_ and arg_662_1.time_ < 0 + var_665_7 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - 0) / var_665_7

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= 0 + var_665_7 and arg_662_1.time_ < 0 + var_665_7 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play1104701165 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 1104701165
		arg_666_1.duration_ = 5

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play1104701166(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 and not isNil(arg_666_1.actors_["1047ui_story"]) and arg_666_1.var_.characterEffect1047ui_story == nil then
				arg_666_1.var_.characterEffect1047ui_story = arg_666_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_669_0 = 0.200000002980232

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_0 and not isNil(arg_666_1.actors_["1047ui_story"]) then
				if arg_666_1.var_.characterEffect1047ui_story and not isNil(arg_666_1.actors_["1047ui_story"]) then
					arg_666_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_666_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_666_1.time_ - 0) / var_669_0)
				end
			end

			if arg_666_1.time_ >= 0 + var_669_0 and arg_666_1.time_ < 0 + var_669_0 + arg_669_0 and not isNil(arg_666_1.actors_["1047ui_story"]) and arg_666_1.var_.characterEffect1047ui_story then
				arg_666_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_666_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_669_1 = arg_666_1.actors_["1047ui_story"].transform

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= 0 + arg_669_0 then
				arg_666_1.var_.moveOldPos1047ui_story = var_669_1.localPosition
			end

			local var_669_2 = 0.001

			if 0 <= arg_666_1.time_ and arg_666_1.time_ < 0 + var_669_2 then
				var_669_1.localPosition = Vector3.Lerp(arg_666_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_666_1.time_ - 0) / var_669_2)
				var_669_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_669_1.position).x, (manager.ui.mainCamera.transform.position - var_669_1.position).y, (manager.ui.mainCamera.transform.position - var_669_1.position).z)
				var_669_1.localEulerAngles.z = 0
				var_669_1.localEulerAngles.x = 0
				var_669_1.localEulerAngles = var_669_1.localEulerAngles
			end

			if arg_666_1.time_ >= 0 + var_669_2 and arg_666_1.time_ < 0 + var_669_2 + arg_669_0 then
				var_669_1.localPosition = Vector3.New(0, 100, 0)
				var_669_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_669_1.position).x, (manager.ui.mainCamera.transform.position - var_669_1.position).y, (manager.ui.mainCamera.transform.position - var_669_1.position).z)
				var_669_1.localEulerAngles.z = 0
				var_669_1.localEulerAngles.x = 0
				var_669_1.localEulerAngles = var_669_1.localEulerAngles
			end

			local var_669_3 = 0
			local var_669_4 = 1.35

			if 0 < arg_666_1.time_ and arg_666_1.time_ <= var_669_3 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, false)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_666_1.iconTrs_.gameObject, false)
				arg_666_1.callingController_:SetSelectedState("normal")

				local var_669_5 = arg_666_1:FormatText(arg_666_1:GetWordFromCfg(1104701165).content)

				arg_666_1.text_.text = var_669_5

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_7 = 54 <= 0 and var_669_4 or var_669_4 * (utf8.len(var_669_5) / 54)

				if (54 <= 0 and var_669_4 or var_669_4 * (utf8.len(var_669_5) / 54)) > 0 and var_669_4 < var_669_7 then
					arg_666_1.talkMaxDuration = var_669_7

					if var_669_7 + var_669_3 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_7 + var_669_3
					end
				end

				arg_666_1.text_.text = var_669_5
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)
				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_8 = math.max(var_669_4, arg_666_1.talkMaxDuration)

			if var_669_3 <= arg_666_1.time_ and arg_666_1.time_ < var_669_3 + var_669_8 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_3) / var_669_8

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_3 + var_669_8 and arg_666_1.time_ < var_669_3 + var_669_8 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_666_1:InitPlayNodeList()
	end,
	Play1104701166 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 1104701166
		arg_670_1.duration_ = 5

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play1104701167(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			local var_673_0 = 0.35

			if 0 < arg_670_1.time_ and arg_670_1.time_ <= 0 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, false)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_1 = arg_670_1:FormatText(arg_670_1:GetWordFromCfg(1104701166).content)

				arg_670_1.text_.text = var_673_1

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_3 = 14 <= 0 and var_673_0 or var_673_0 * (utf8.len(var_673_1) / 14)

				if (14 <= 0 and var_673_0 or var_673_0 * (utf8.len(var_673_1) / 14)) > 0 and var_673_0 < var_673_3 then
					arg_670_1.talkMaxDuration = var_673_3

					if var_673_3 + 0 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_3 + 0
					end
				end

				arg_670_1.text_.text = var_673_1
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)
				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_4 = math.max(var_673_0, arg_670_1.talkMaxDuration)

			if 0 <= arg_670_1.time_ and arg_670_1.time_ < 0 + var_673_4 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - 0) / var_673_4

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= 0 + var_673_4 and arg_670_1.time_ < 0 + var_673_4 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {}

		arg_670_1:InitPlayNodeList()
	end,
	Play1104701167 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 1104701167
		arg_674_1.duration_ = 2.67

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
			arg_674_1.auto_ = false
		end

		function arg_674_1.playNext_(arg_676_0)
			arg_674_1.onStoryFinished_()
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1.var_.moveOldPos1047ui_story = arg_674_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_677_0 = 0.001

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_0 then
				arg_674_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_674_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_674_1.time_ - 0) / var_677_0)
				arg_674_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_674_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1047ui_story"].transform.position).z)
				arg_674_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_674_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_674_1.actors_["1047ui_story"].transform.localEulerAngles = arg_674_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_674_1.time_ >= 0 + var_677_0 and arg_674_1.time_ < 0 + var_677_0 + arg_677_0 then
				arg_674_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_674_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_674_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_674_1.actors_["1047ui_story"].transform.position).z)
				arg_674_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_674_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_674_1.actors_["1047ui_story"].transform.localEulerAngles = arg_674_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_677_1 = arg_674_1.actors_["1047ui_story"]

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 and not isNil(var_677_1) and arg_674_1.var_.characterEffect1047ui_story == nil then
				arg_674_1.var_.characterEffect1047ui_story = var_677_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_677_2 = 0.200000002980232

			if 0 <= arg_674_1.time_ and arg_674_1.time_ < 0 + var_677_2 and not isNil(var_677_1) then
				if arg_674_1.var_.characterEffect1047ui_story and not isNil(var_677_1) then
					arg_674_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_674_1.time_ >= 0 + var_677_2 and arg_674_1.time_ < 0 + var_677_2 + arg_677_0 and not isNil(var_677_1) and arg_674_1.var_.characterEffect1047ui_story then
				arg_674_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= 0 + arg_677_0 then
				arg_674_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_677_5 = 0
			local var_677_6 = 0.475

			if 0 < arg_674_1.time_ and arg_674_1.time_ <= var_677_5 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				arg_674_1.leftNameTxt_.text = arg_674_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_7 = arg_674_1:GetWordFromCfg(1104701167)
				local var_677_8 = arg_674_1:FormatText(var_677_7.content)

				arg_674_1.text_.text = var_677_8

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_10 = 19 <= 0 and var_677_6 or var_677_6 * (utf8.len(var_677_8) / 19)

				if (19 <= 0 and var_677_6 or var_677_6 * (utf8.len(var_677_8) / 19)) > 0 and var_677_6 < var_677_10 then
					arg_674_1.talkMaxDuration = var_677_10

					if var_677_10 + var_677_5 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_10 + var_677_5
					end
				end

				arg_674_1.text_.text = var_677_8
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb") ~= 0 then
					local var_677_11 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb") / 1000

					if var_677_11 + var_677_5 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_11 + var_677_5
					end

					if var_677_7.prefab_name ~= "" and arg_674_1.actors_[var_677_7.prefab_name] ~= nil then
						local var_677_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_7.prefab_name].transform, "story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb")

						arg_674_1:RecordAudio("1104701167", var_677_12)
						arg_674_1:RecordAudio("1104701167", var_677_12)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701167", "story_v_side_new_1104701.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_13 = math.max(var_677_6, arg_674_1.talkMaxDuration)

			if var_677_5 <= arg_674_1.time_ and arg_674_1.time_ < var_677_5 + var_677_13 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_5) / var_677_13

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_5 + var_677_13 and arg_674_1.time_ < var_677_5 + var_677_13 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_674_1:InitPlayNodeList()
	end,
	Play1104701133 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 1104701133
		arg_678_1.duration_ = 6.93

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play1104701134(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 then
				arg_678_1.var_.moveOldPos1047ui_story = arg_678_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_681_0 = 0.001

			if 0 <= arg_678_1.time_ and arg_678_1.time_ < 0 + var_681_0 then
				arg_678_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_678_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_678_1.time_ - 0) / var_681_0)
				arg_678_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_678_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_678_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_678_1.actors_["1047ui_story"].transform.position).z)
				arg_678_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_678_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_678_1.actors_["1047ui_story"].transform.localEulerAngles = arg_678_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_678_1.time_ >= 0 + var_681_0 and arg_678_1.time_ < 0 + var_681_0 + arg_681_0 then
				arg_678_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_678_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_678_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_678_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_678_1.actors_["1047ui_story"].transform.position).z)
				arg_678_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_678_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_678_1.actors_["1047ui_story"].transform.localEulerAngles = arg_678_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_681_1 = "1047ui_story"

			if arg_678_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_681_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_678_1.stage_.transform)

				var_681_2.name = var_681_1
				var_681_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_678_1.actors_[var_681_1] = var_681_2

				local var_681_3 = var_681_2:GetComponentInChildren(typeof(CharacterEffect))

				var_681_3.enabled = true

				local var_681_4 = GameObjectTools.GetOrAddComponent(var_681_2, typeof(DynamicBoneHelper))

				if var_681_4 then
					var_681_4:EnableDynamicBone(false)
				end

				arg_678_1:ShowWeapon(var_681_3.transform, false)

				arg_678_1.var_[var_681_1 .. "Animator"] = var_681_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_678_1.var_[var_681_1 .. "Animator"].applyRootMotion = true
				arg_678_1.var_[var_681_1 .. "LipSync"] = var_681_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 then
				arg_678_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_681_5 = "1047ui_story"

			if arg_678_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_681_6 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_678_1.stage_.transform)

				var_681_6.name = var_681_5
				var_681_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_678_1.actors_[var_681_5] = var_681_6

				local var_681_7 = var_681_6:GetComponentInChildren(typeof(CharacterEffect))

				var_681_7.enabled = true

				local var_681_8 = GameObjectTools.GetOrAddComponent(var_681_6, typeof(DynamicBoneHelper))

				if var_681_8 then
					var_681_8:EnableDynamicBone(false)
				end

				arg_678_1:ShowWeapon(var_681_7.transform, false)

				arg_678_1.var_[var_681_5 .. "Animator"] = var_681_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_678_1.var_[var_681_5 .. "Animator"].applyRootMotion = true
				arg_678_1.var_[var_681_5 .. "LipSync"] = var_681_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 then
				arg_678_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_681_9 = arg_678_1.actors_["1047ui_story"]

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= 0 + arg_681_0 and not isNil(var_681_9) and arg_678_1.var_.characterEffect1047ui_story == nil then
				arg_678_1.var_.characterEffect1047ui_story = var_681_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_681_10 = 0.200000002980232

			if 0 <= arg_678_1.time_ and arg_678_1.time_ < 0 + var_681_10 and not isNil(var_681_9) then
				if arg_678_1.var_.characterEffect1047ui_story and not isNil(var_681_9) then
					arg_678_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_678_1.time_ >= 0 + var_681_10 and arg_678_1.time_ < 0 + var_681_10 + arg_681_0 and not isNil(var_681_9) and arg_678_1.var_.characterEffect1047ui_story then
				arg_678_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_681_12 = 0
			local var_681_13 = 0.65

			if 0 < arg_678_1.time_ and arg_678_1.time_ <= var_681_12 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				arg_678_1.leftNameTxt_.text = arg_678_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, false)
				arg_678_1.callingController_:SetSelectedState("normal")

				local var_681_14 = arg_678_1:GetWordFromCfg(1104701133)
				local var_681_15 = arg_678_1:FormatText(var_681_14.content)

				arg_678_1.text_.text = var_681_15

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_17 = 26 <= 0 and var_681_13 or var_681_13 * (utf8.len(var_681_15) / 26)

				if (26 <= 0 and var_681_13 or var_681_13 * (utf8.len(var_681_15) / 26)) > 0 and var_681_13 < var_681_17 then
					arg_678_1.talkMaxDuration = var_681_17

					if var_681_17 + var_681_12 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_17 + var_681_12
					end
				end

				arg_678_1.text_.text = var_681_15
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb") ~= 0 then
					local var_681_18 = manager.audio:GetVoiceLength("story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb") / 1000

					if var_681_18 + var_681_12 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_18 + var_681_12
					end

					if var_681_14.prefab_name ~= "" and arg_678_1.actors_[var_681_14.prefab_name] ~= nil then
						local var_681_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_678_1.actors_[var_681_14.prefab_name].transform, "story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb")

						arg_678_1:RecordAudio("1104701133", var_681_19)
						arg_678_1:RecordAudio("1104701133", var_681_19)
					else
						arg_678_1:AudioAction("play", "voice", "story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb")
					end

					arg_678_1:RecordHistoryTalkVoice("story_v_side_new_1104701", "1104701133", "story_v_side_new_1104701.awb")
				end

				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_20 = math.max(var_681_13, arg_678_1.talkMaxDuration)

			if var_681_12 <= arg_678_1.time_ and arg_678_1.time_ < var_681_12 + var_681_20 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_12) / var_681_20

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_12 + var_681_20 and arg_678_1.time_ < var_681_12 + var_681_20 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_678_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST05a",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/B13b",
		"TextureConfig/Background/ST22"
	},
	voices = {
		"story_v_side_new_1104701.awb"
	}
}
