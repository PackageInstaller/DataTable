return {
	Play122541001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122541001
		arg_1_1.duration_ = 4.03

		local var_1_0 = {
			ja = 4.033,
			ko = 3.3,
			zh = 3.3
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122541002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_14 = arg_1_1:GetWordFromCfg(122541001)
				local var_4_15 = arg_1_1:FormatText(var_4_14.content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 5 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_15) / 5)

				if (5 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_15) / 5)) > 0 and var_4_12 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_11 = var_4_11 + 0.3

					if var_4_17 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541001", "story_v_out_122541.awb") ~= 0 then
					local var_4_18 = manager.audio:GetVoiceLength("story_v_out_122541", "122541001", "story_v_out_122541.awb") / 1000

					if var_4_18 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_11
					end

					if var_4_14.prefab_name ~= "" and arg_1_1.actors_[var_4_14.prefab_name] ~= nil then
						local var_4_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_14.prefab_name].transform, "story_v_out_122541", "122541001", "story_v_out_122541.awb")

						arg_1_1:RecordAudio("122541001", var_4_19)
						arg_1_1:RecordAudio("122541001", var_4_19)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122541", "122541001", "story_v_out_122541.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122541", "122541001", "story_v_out_122541.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_11 + 0.3
			local var_4_21 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
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
	Play122541002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 122541002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play122541003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.725

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(122541002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 29 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 29)

				if (29 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 29)) > 0 and var_11_0 < var_11_3 then
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
	Play122541003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 122541003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play122541004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.025

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(122541003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 41 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 41)

				if (41 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 41)) > 0 and var_15_0 < var_15_3 then
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
	Play122541004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 122541004
		arg_16_1.duration_ = 6.93

		local var_16_0 = {
			ja = 6.933,
			ko = 5.533999999999,
			zh = 5.533999999999
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play122541005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.bgs_.XH0606 == nil then
				local var_19_0 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0606")
				var_19_0.name = "XH0606"
				var_19_0.transform.parent = arg_16_1.stage_.transform
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_.XH0606 = var_19_0
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				local var_19_1 = arg_16_1.bgs_.XH0606

				arg_16_1.bgs_.XH0606.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_2 = var_19_1:GetComponent("SpriteRenderer")

				if var_19_2 and var_19_2.sprite then
					local var_19_3 = 2 * (var_19_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_1.transform.localScale = Vector3.New(var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "XH0606" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_4 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_5 = 2

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_5 then
				local var_19_6 = Color.New(0, 0, 0)

				var_19_6.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_4) / var_19_5)
				arg_16_1.mask_.color = var_19_6
			end

			if arg_16_1.time_ >= var_19_4 + var_19_5 and arg_16_1.time_ < var_19_4 + var_19_5 + arg_19_0 then
				local var_19_7 = Color.New(0, 0, 0)

				arg_16_1.mask_.enabled = false
				var_19_7.a = 0
				arg_16_1.mask_.color = var_19_7
			end

			local var_19_8 = arg_16_1.bgs_.XH0606.transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPosXH0606 = var_19_8.localPosition
			end

			local var_19_9 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_9 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPosXH0606, Vector3.New(0, -0.3, -4.5), (arg_16_1.time_ - 0) / var_19_9)
			end

			if arg_16_1.time_ >= 0 + var_19_9 and arg_16_1.time_ < 0 + var_19_9 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0, -0.3, -4.5)
			end

			local var_19_10 = arg_16_1.bgs_.XH0606.transform

			if 0.034 < arg_16_1.time_ and arg_16_1.time_ <= 0.034 + arg_19_0 then
				arg_16_1.var_.moveOldPosXH0606 = var_19_10.localPosition
			end

			local var_19_11 = 5.5

			if 0.034 <= arg_16_1.time_ and arg_16_1.time_ < 0.034 + var_19_11 then
				var_19_10.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPosXH0606, Vector3.New(0, -0.3, -3.9), (arg_16_1.time_ - 0.034) / var_19_11)
			end

			if arg_16_1.time_ >= 0.034 + var_19_11 and arg_16_1.time_ < 0.034 + var_19_11 + arg_19_0 then
				var_19_10.localPosition = Vector3.New(0, -0.3, -3.9)
			end

			local var_19_12 = 2

			if 2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_12 + 3.533999999999 and arg_16_1.time_ < var_19_12 + 3.533999999999 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			if 4.533999999999 < arg_16_1.time_ and arg_16_1.time_ <= 4.533999999999 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "bgm_activity_2_2_story_meeting", "bgm_activity_2_2_story_meeting", "bgm_activity_2_2_story_meeting.awb")

				local var_19_15 = manager.audio:GetAudioName("bgm_activity_2_2_story_meeting", "bgm_activity_2_2_story_meeting")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_15 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_15

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_15
						arg_16_1.bgmTxt2_.text = var_19_15
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

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_16 = 2
			local var_19_17 = 0.2

			if 2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_18 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_18:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_16_1.dialogCg_.alpha = arg_21_0
				end))
				var_19_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_19 = arg_16_1:GetWordFromCfg(122541004)
				local var_19_20 = arg_16_1:FormatText(var_19_19.content)

				arg_16_1.text_.text = var_19_20

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_22 = 8 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_20) / 8)

				if (8 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_20) / 8)) > 0 and var_19_17 < var_19_22 then
					arg_16_1.talkMaxDuration = var_19_22
					var_19_16 = var_19_16 + 0.3

					if var_19_22 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_16
					end
				end

				arg_16_1.text_.text = var_19_20
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541004", "story_v_out_122541.awb") ~= 0 then
					local var_19_23 = manager.audio:GetVoiceLength("story_v_out_122541", "122541004", "story_v_out_122541.awb") / 1000

					if var_19_23 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_16
					end

					if var_19_19.prefab_name ~= "" and arg_16_1.actors_[var_19_19.prefab_name] ~= nil then
						local var_19_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_19.prefab_name].transform, "story_v_out_122541", "122541004", "story_v_out_122541.awb")

						arg_16_1:RecordAudio("122541004", var_19_24)
						arg_16_1:RecordAudio("122541004", var_19_24)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_122541", "122541004", "story_v_out_122541.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_122541", "122541004", "story_v_out_122541.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_25 = var_19_16 + 0.3
			local var_19_26 = math.max(var_19_17, arg_16_1.talkMaxDuration)

			if var_19_16 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_25 + var_19_26 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_25) / var_19_26

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_25 + var_19_26 and arg_16_1.time_ < var_19_25 + var_19_26 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0606",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0606",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play122541005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 122541005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play122541006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.3

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(122541005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 52 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 52)

				if (52 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 52)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play122541006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 122541006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play122541007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 1.15

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(122541006).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 46 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 46)

				if (46 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 46)) > 0 and var_30_0 < var_30_3 then
					arg_27_1.talkMaxDuration = var_30_3

					if var_30_3 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_3 + 0
					end
				end

				arg_27_1.text_.text = var_30_1
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_4 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_4

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play122541007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 122541007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play122541008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 1

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(122541007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 40 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 40)

				if (40 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 40)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play122541008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122541008
		arg_35_1.duration_ = 5.9

		local var_35_0 = {
			ja = 5.9,
			ko = 5.516666666666,
			zh = 5.516666666666
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
				arg_35_0:Play122541009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_0 = 2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				local var_38_1 = Color.New(0, 0, 0)

				var_38_1.a = Mathf.Lerp(0, 1, (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.mask_.color = var_38_1
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				local var_38_2 = Color.New(0, 0, 0)

				var_38_2.a = 1
				arg_35_1.mask_.color = var_38_2
			end

			local var_38_3 = 2

			if 2 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_4 = 2

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_4 then
				local var_38_5 = Color.New(0, 0, 0)

				var_38_5.a = Mathf.Lerp(1, 0, (arg_35_1.time_ - var_38_3) / var_38_4)
				arg_35_1.mask_.color = var_38_5
			end

			if arg_35_1.time_ >= var_38_3 + var_38_4 and arg_35_1.time_ < var_38_3 + var_38_4 + arg_38_0 then
				local var_38_6 = Color.New(0, 0, 0)

				arg_35_1.mask_.enabled = false
				var_38_6.a = 0
				arg_35_1.mask_.color = var_38_6
			end

			local var_38_7 = arg_35_1.bgs_.XH0606.transform

			if 2 < arg_35_1.time_ and arg_35_1.time_ <= 2 + arg_38_0 then
				arg_35_1.var_.moveOldPosXH0606 = var_38_7.localPosition
			end

			local var_38_8 = 0.001

			if 2 <= arg_35_1.time_ and arg_35_1.time_ < 2 + var_38_8 then
				var_38_7.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPosXH0606, Vector3.New(-5.5, 0.5, -2.74), (arg_35_1.time_ - 2) / var_38_8)
			end

			if arg_35_1.time_ >= 2 + var_38_8 and arg_35_1.time_ < 2 + var_38_8 + arg_38_0 then
				var_38_7.localPosition = Vector3.New(-5.5, 0.5, -2.74)
			end

			local var_38_9 = arg_35_1.bgs_.XH0606.transform

			if 2.01666666666667 < arg_35_1.time_ and arg_35_1.time_ <= 2.01666666666667 + arg_38_0 then
				arg_35_1.var_.moveOldPosXH0606 = var_38_9.localPosition
			end

			local var_38_10 = 3.5

			if 2.01666666666667 <= arg_35_1.time_ and arg_35_1.time_ < 2.01666666666667 + var_38_10 then
				var_38_9.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPosXH0606, Vector3.New(-6, 0.5, -2.74), (arg_35_1.time_ - 2.01666666666667) / var_38_10)
			end

			if arg_35_1.time_ >= 2.01666666666667 + var_38_10 and arg_35_1.time_ < 2.01666666666667 + var_38_10 + arg_38_0 then
				var_38_9.localPosition = Vector3.New(-6, 0.5, -2.74)
			end

			local var_38_11 = 4

			if 4 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				arg_35_1.allBtn_.enabled = false
			end

			if arg_35_1.time_ >= var_38_11 + 1.51666666666667 and arg_35_1.time_ < var_38_11 + 1.51666666666667 + arg_38_0 then
				arg_35_1.allBtn_.enabled = true
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_12 = 3.8
			local var_38_13 = 0.075

			if 3.8 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_14 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_14:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_15 = arg_35_1:GetWordFromCfg(122541008)
				local var_38_16 = arg_35_1:FormatText(var_38_15.content)

				arg_35_1.text_.text = var_38_16

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_18 = 3 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_16) / 3)

				if (3 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_16) / 3)) > 0 and var_38_13 < var_38_18 then
					arg_35_1.talkMaxDuration = var_38_18
					var_38_12 = var_38_12 + 0.3

					if var_38_18 + var_38_12 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_12
					end
				end

				arg_35_1.text_.text = var_38_16
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541008", "story_v_out_122541.awb") ~= 0 then
					local var_38_19 = manager.audio:GetVoiceLength("story_v_out_122541", "122541008", "story_v_out_122541.awb") / 1000

					if var_38_19 + var_38_12 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_19 + var_38_12
					end

					if var_38_15.prefab_name ~= "" and arg_35_1.actors_[var_38_15.prefab_name] ~= nil then
						local var_38_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_15.prefab_name].transform, "story_v_out_122541", "122541008", "story_v_out_122541.awb")

						arg_35_1:RecordAudio("122541008", var_38_20)
						arg_35_1:RecordAudio("122541008", var_38_20)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_122541", "122541008", "story_v_out_122541.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_122541", "122541008", "story_v_out_122541.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_21 = var_38_12 + 0.3
			local var_38_22 = math.max(var_38_13, arg_35_1.talkMaxDuration)

			if var_38_12 + 0.3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_21 + var_38_22 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_21) / var_38_22

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_21 + var_38_22 and arg_35_1.time_ < var_38_21 + var_38_22 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0606",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0606",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play122541009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122541009
		arg_41_1.duration_ = 1.33

		local var_41_0 = {
			ja = 1.333,
			ko = 1.133,
			zh = 1.133
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
				arg_41_0:Play122541010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.05

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(122541009)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 2 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 2)

				if (2 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 2)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541009", "story_v_out_122541.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541009", "story_v_out_122541.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_122541", "122541009", "story_v_out_122541.awb")

						arg_41_1:RecordAudio("122541009", var_44_6)
						arg_41_1:RecordAudio("122541009", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_122541", "122541009", "story_v_out_122541.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_122541", "122541009", "story_v_out_122541.awb")
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
	Play122541010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122541010
		arg_45_1.duration_ = 7.8

		local var_45_0 = {
			ja = 7.8,
			ko = 6.266666666666,
			zh = 6.266666666666
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
				arg_45_0:Play122541011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 2 < arg_45_1.time_ and arg_45_1.time_ <= 2 + arg_48_0 then
				arg_45_1.var_.moveOldPosXH0606 = arg_45_1.bgs_.XH0606.transform.localPosition
			end

			local var_48_0 = 0.001

			if 2 <= arg_45_1.time_ and arg_45_1.time_ < 2 + var_48_0 then
				arg_45_1.bgs_.XH0606.transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPosXH0606, Vector3.New(4.5, -0.35, -2.74), (arg_45_1.time_ - 2) / var_48_0)
			end

			if arg_45_1.time_ >= 2 + var_48_0 and arg_45_1.time_ < 2 + var_48_0 + arg_48_0 then
				arg_45_1.bgs_.XH0606.transform.localPosition = Vector3.New(4.5, -0.35, -2.74)
			end

			local var_48_1 = arg_45_1.bgs_.XH0606.transform

			if 2.01666666666667 < arg_45_1.time_ and arg_45_1.time_ <= 2.01666666666667 + arg_48_0 then
				arg_45_1.var_.moveOldPosXH0606 = var_48_1.localPosition
			end

			local var_48_2 = 4

			if 2.01666666666667 <= arg_45_1.time_ and arg_45_1.time_ < 2.01666666666667 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPosXH0606, Vector3.New(5, -0.35, -2.74), (arg_45_1.time_ - 2.01666666666667) / var_48_2)
			end

			if arg_45_1.time_ >= 2.01666666666667 + var_48_2 and arg_45_1.time_ < 2.01666666666667 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(5, -0.35, -2.74)
			end

			local var_48_3 = 0

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_4 = 2

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_4 then
				local var_48_5 = Color.New(0, 0, 0)

				var_48_5.a = Mathf.Lerp(0, 1, (arg_45_1.time_ - var_48_3) / var_48_4)
				arg_45_1.mask_.color = var_48_5
			end

			if arg_45_1.time_ >= var_48_3 + var_48_4 and arg_45_1.time_ < var_48_3 + var_48_4 + arg_48_0 then
				local var_48_6 = Color.New(0, 0, 0)

				var_48_6.a = 1
				arg_45_1.mask_.color = var_48_6
			end

			local var_48_7 = 2

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_8 = 2

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 then
				local var_48_9 = Color.New(0, 0, 0)

				var_48_9.a = Mathf.Lerp(1, 0, (arg_45_1.time_ - var_48_7) / var_48_8)
				arg_45_1.mask_.color = var_48_9
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 then
				local var_48_10 = Color.New(0, 0, 0)

				arg_45_1.mask_.enabled = false
				var_48_10.a = 0
				arg_45_1.mask_.color = var_48_10
			end

			local var_48_11 = 4

			if 4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			if arg_45_1.time_ >= var_48_11 + 2.01666666666667 and arg_45_1.time_ < var_48_11 + 2.01666666666667 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_12 = 3.8
			local var_48_13 = 0.075

			if 3.8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_14 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_14:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:GetWordFromCfg(122541010)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_18 = 3 <= 0 and var_48_13 or var_48_13 * (utf8.len(var_48_16) / 3)

				if (3 <= 0 and var_48_13 or var_48_13 * (utf8.len(var_48_16) / 3)) > 0 and var_48_13 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18
					var_48_12 = var_48_12 + 0.3

					if var_48_18 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541010", "story_v_out_122541.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_122541", "122541010", "story_v_out_122541.awb") / 1000

					if var_48_19 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_12
					end

					if var_48_15.prefab_name ~= "" and arg_45_1.actors_[var_48_15.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_15.prefab_name].transform, "story_v_out_122541", "122541010", "story_v_out_122541.awb")

						arg_45_1:RecordAudio("122541010", var_48_20)
						arg_45_1:RecordAudio("122541010", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122541", "122541010", "story_v_out_122541.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122541", "122541010", "story_v_out_122541.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = var_48_12 + 0.3
			local var_48_22 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 + 0.3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_21) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_21 + var_48_22 and arg_45_1.time_ < var_48_21 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0606",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0606",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play122541011 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 122541011
		arg_51_1.duration_ = 1.63

		local var_51_0 = {
			ja = 1.466,
			ko = 1.633,
			zh = 1.633
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
				arg_51_0:Play122541012(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.05

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(122541011)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 2 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 2)

				if (2 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 2)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541011", "story_v_out_122541.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541011", "story_v_out_122541.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_122541", "122541011", "story_v_out_122541.awb")

						arg_51_1:RecordAudio("122541011", var_54_6)
						arg_51_1:RecordAudio("122541011", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_122541", "122541011", "story_v_out_122541.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_122541", "122541011", "story_v_out_122541.awb")
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
	Play122541012 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 122541012
		arg_55_1.duration_ = 5.63

		local var_55_0 = {
			ja = 5.633,
			ko = 5.033,
			zh = 5.033
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play122541013(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.6

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(122541012)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 24 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 24)

				if (24 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 24)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541012", "story_v_out_122541.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541012", "story_v_out_122541.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_122541", "122541012", "story_v_out_122541.awb")

						arg_55_1:RecordAudio("122541012", var_58_6)
						arg_55_1:RecordAudio("122541012", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_122541", "122541012", "story_v_out_122541.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_122541", "122541012", "story_v_out_122541.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play122541013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 122541013
		arg_59_1.duration_ = 10.77

		local var_59_0 = {
			ja = 10.766,
			ko = 7.266,
			zh = 7.266
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
				arg_59_0:Play122541014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.75

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(122541013)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 30 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 30)

				if (30 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 30)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541013", "story_v_out_122541.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541013", "story_v_out_122541.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_122541", "122541013", "story_v_out_122541.awb")

						arg_59_1:RecordAudio("122541013", var_62_6)
						arg_59_1:RecordAudio("122541013", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_122541", "122541013", "story_v_out_122541.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_122541", "122541013", "story_v_out_122541.awb")
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
	Play122541014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 122541014
		arg_63_1.duration_ = 8.8

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play122541015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_0 = arg_63_1.bgs_.XH0606

				arg_63_1.bgs_.XH0606.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_1 = var_66_0:GetComponent("SpriteRenderer")

				if var_66_1 and var_66_1.sprite then
					local var_66_2 = 2 * (var_66_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_0.transform.localScale = Vector3.New(var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "XH0606" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_3 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_3 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_4 = 2

			if var_66_3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_3 + var_66_4 then
				local var_66_5 = Color.New(0, 0, 0)

				var_66_5.a = Mathf.Lerp(0, 1, (arg_63_1.time_ - var_66_3) / var_66_4)
				arg_63_1.mask_.color = var_66_5
			end

			if arg_63_1.time_ >= var_66_3 + var_66_4 and arg_63_1.time_ < var_66_3 + var_66_4 + arg_66_0 then
				local var_66_6 = Color.New(0, 0, 0)

				var_66_6.a = 1
				arg_63_1.mask_.color = var_66_6
			end

			local var_66_7 = 2

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_8 = 2

			if var_66_7 <= arg_63_1.time_ and arg_63_1.time_ < var_66_7 + var_66_8 then
				local var_66_9 = Color.New(0, 0, 0)

				var_66_9.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - var_66_7) / var_66_8)
				arg_63_1.mask_.color = var_66_9
			end

			if arg_63_1.time_ >= var_66_7 + var_66_8 and arg_63_1.time_ < var_66_7 + var_66_8 + arg_66_0 then
				local var_66_10 = Color.New(0, 0, 0)

				arg_63_1.mask_.enabled = false
				var_66_10.a = 0
				arg_63_1.mask_.color = var_66_10
			end

			local var_66_11 = arg_63_1.bgs_.XH0606.transform

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				arg_63_1.var_.moveOldPosXH0606 = var_66_11.localPosition
			end

			local var_66_12 = 0.001

			if 2 <= arg_63_1.time_ and arg_63_1.time_ < 2 + var_66_12 then
				var_66_11.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPosXH0606, Vector3.New(0, 1, 9.5), (arg_63_1.time_ - 2) / var_66_12)
			end

			if arg_63_1.time_ >= 2 + var_66_12 and arg_63_1.time_ < 2 + var_66_12 + arg_66_0 then
				var_66_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_66_13 = arg_63_1.bgs_.XH0606.transform

			if 2.01666666666667 < arg_63_1.time_ and arg_63_1.time_ <= 2.01666666666667 + arg_66_0 then
				arg_63_1.var_.moveOldPosXH0606 = var_66_13.localPosition
			end

			local var_66_14 = 4

			if 2.01666666666667 <= arg_63_1.time_ and arg_63_1.time_ < 2.01666666666667 + var_66_14 then
				var_66_13.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPosXH0606, Vector3.New(0, 1, 10), (arg_63_1.time_ - 2.01666666666667) / var_66_14)
			end

			if arg_63_1.time_ >= 2.01666666666667 + var_66_14 and arg_63_1.time_ < 2.01666666666667 + var_66_14 + arg_66_0 then
				var_66_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_66_15 = 4

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_15 + 2.01666666666667 and arg_63_1.time_ < var_66_15 + 2.01666666666667 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_16 = 3.8
			local var_66_17 = 1.675

			if 3.8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_18 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_18:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_19 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(122541014).content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_21 = 67 <= 0 and var_66_17 or var_66_17 * (utf8.len(var_66_19) / 67)

				if (67 <= 0 and var_66_17 or var_66_17 * (utf8.len(var_66_19) / 67)) > 0 and var_66_17 < var_66_21 then
					arg_63_1.talkMaxDuration = var_66_21
					var_66_16 = var_66_16 + 0.3

					if var_66_21 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_21 + var_66_16
					end
				end

				arg_63_1.text_.text = var_66_19
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_22 = var_66_16 + 0.3
			local var_66_23 = math.max(var_66_17, arg_63_1.talkMaxDuration)

			if var_66_16 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_22 + var_66_23 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_22) / var_66_23

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_22 + var_66_23 and arg_63_1.time_ < var_66_22 + var_66_23 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0606",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0606",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play122541015 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122541015
		arg_69_1.duration_ = 2.77

		local var_69_0 = {
			ja = 1.866,
			ko = 2.766,
			zh = 2.766
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
				arg_69_0:Play122541016(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(122541015)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 8 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 8)

				if (8 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 8)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541015", "story_v_out_122541.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541015", "story_v_out_122541.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_122541", "122541015", "story_v_out_122541.awb")

						arg_69_1:RecordAudio("122541015", var_72_6)
						arg_69_1:RecordAudio("122541015", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122541", "122541015", "story_v_out_122541.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122541", "122541015", "story_v_out_122541.awb")
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
	Play122541016 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122541016
		arg_73_1.duration_ = 7.4

		local var_73_0 = {
			ja = 7.4,
			ko = 4.366,
			zh = 4.366
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
				arg_73_0:Play122541017(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.5

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(122541016)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 20 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 20)

				if (20 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 20)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541016", "story_v_out_122541.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541016", "story_v_out_122541.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_122541", "122541016", "story_v_out_122541.awb")

						arg_73_1:RecordAudio("122541016", var_76_6)
						arg_73_1:RecordAudio("122541016", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_122541", "122541016", "story_v_out_122541.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_122541", "122541016", "story_v_out_122541.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play122541017 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122541017
		arg_77_1.duration_ = 10.93

		local var_77_0 = {
			ja = 10.933,
			ko = 9.366,
			zh = 9.366
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
				arg_77_0:Play122541018(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.675

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(122541017)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 27 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 27)

				if (27 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 27)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541017", "story_v_out_122541.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541017", "story_v_out_122541.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_122541", "122541017", "story_v_out_122541.awb")

						arg_77_1:RecordAudio("122541017", var_80_6)
						arg_77_1:RecordAudio("122541017", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122541", "122541017", "story_v_out_122541.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122541", "122541017", "story_v_out_122541.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play122541018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122541018
		arg_81_1.duration_ = 7.23

		local var_81_0 = {
			ja = 7.233,
			ko = 3.466,
			zh = 3.466
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
				arg_81_0:Play122541019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(122541018)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 15 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 15)

				if (15 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 15)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541018", "story_v_out_122541.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541018", "story_v_out_122541.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_122541", "122541018", "story_v_out_122541.awb")

						arg_81_1:RecordAudio("122541018", var_84_6)
						arg_81_1:RecordAudio("122541018", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_122541", "122541018", "story_v_out_122541.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_122541", "122541018", "story_v_out_122541.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play122541019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 122541019
		arg_85_1.duration_ = 8.67

		local var_85_0 = {
			ja = 8.5,
			ko = 8.666,
			zh = 8.666
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
				arg_85_0:Play122541020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.8

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(122541019)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 32 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 32)

				if (32 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 32)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541019", "story_v_out_122541.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541019", "story_v_out_122541.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_122541", "122541019", "story_v_out_122541.awb")

						arg_85_1:RecordAudio("122541019", var_88_6)
						arg_85_1:RecordAudio("122541019", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_122541", "122541019", "story_v_out_122541.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_122541", "122541019", "story_v_out_122541.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play122541020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 122541020
		arg_89_1.duration_ = 11.03

		local var_89_0 = {
			ja = 11.033,
			ko = 5.466,
			zh = 5.466
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
				arg_89_0:Play122541021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.6

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(122541020)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 24 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 24)

				if (24 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 24)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541020", "story_v_out_122541.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541020", "story_v_out_122541.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_122541", "122541020", "story_v_out_122541.awb")

						arg_89_1:RecordAudio("122541020", var_92_6)
						arg_89_1:RecordAudio("122541020", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_122541", "122541020", "story_v_out_122541.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_122541", "122541020", "story_v_out_122541.awb")
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
	Play122541021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 122541021
		arg_93_1.duration_ = 8.4

		local var_93_0 = {
			ja = 8.4,
			ko = 6.3,
			zh = 6.3
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
				arg_93_0:Play122541022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.8

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(122541021)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 32 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 32)

				if (32 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 32)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541021", "story_v_out_122541.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541021", "story_v_out_122541.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_122541", "122541021", "story_v_out_122541.awb")

						arg_93_1:RecordAudio("122541021", var_96_6)
						arg_93_1:RecordAudio("122541021", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_122541", "122541021", "story_v_out_122541.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_122541", "122541021", "story_v_out_122541.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play122541022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 122541022
		arg_97_1.duration_ = 12.23

		local var_97_0 = {
			ja = 12.233,
			ko = 11.533,
			zh = 11.533
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
				arg_97_0:Play122541023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(122541022)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 45 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 45)

				if (45 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 45)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541022", "story_v_out_122541.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541022", "story_v_out_122541.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_122541", "122541022", "story_v_out_122541.awb")

						arg_97_1:RecordAudio("122541022", var_100_6)
						arg_97_1:RecordAudio("122541022", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_122541", "122541022", "story_v_out_122541.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_122541", "122541022", "story_v_out_122541.awb")
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
	Play122541023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 122541023
		arg_101_1.duration_ = 7.2

		local var_101_0 = {
			ja = 7.2,
			ko = 6.033,
			zh = 6.033
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
				arg_101_0:Play122541024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.65

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(122541023)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 26 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 26)

				if (26 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 26)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541023", "story_v_out_122541.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541023", "story_v_out_122541.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_122541", "122541023", "story_v_out_122541.awb")

						arg_101_1:RecordAudio("122541023", var_104_6)
						arg_101_1:RecordAudio("122541023", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_122541", "122541023", "story_v_out_122541.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_122541", "122541023", "story_v_out_122541.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play122541024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 122541024
		arg_105_1.duration_ = 10.63

		local var_105_0 = {
			ja = 10.633,
			ko = 6.9,
			zh = 6.9
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
				arg_105_0:Play122541025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.75

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(122541024)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 30 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 30)

				if (30 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 30)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541024", "story_v_out_122541.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541024", "story_v_out_122541.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_122541", "122541024", "story_v_out_122541.awb")

						arg_105_1:RecordAudio("122541024", var_108_6)
						arg_105_1:RecordAudio("122541024", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_122541", "122541024", "story_v_out_122541.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_122541", "122541024", "story_v_out_122541.awb")
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
	Play122541025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 122541025
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play122541026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(122541025).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 54 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 54)

				if (54 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 54)) > 0 and var_112_0 < var_112_3 then
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
	Play122541026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 122541026
		arg_113_1.duration_ = 13.23

		local var_113_0 = {
			ja = 12.033,
			ko = 13.233,
			zh = 13.233
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
				arg_113_0:Play122541027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.95

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(122541026)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 38 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 38)

				if (38 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 38)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541026", "story_v_out_122541.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541026", "story_v_out_122541.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_122541", "122541026", "story_v_out_122541.awb")

						arg_113_1:RecordAudio("122541026", var_116_6)
						arg_113_1:RecordAudio("122541026", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_122541", "122541026", "story_v_out_122541.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_122541", "122541026", "story_v_out_122541.awb")
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
	Play122541027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 122541027
		arg_117_1.duration_ = 20

		local var_117_0 = {
			ja = 20,
			ko = 11.466,
			zh = 11.466
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
				arg_117_0:Play122541028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.125

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(122541027)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 45 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 45)

				if (45 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 45)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541027", "story_v_out_122541.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541027", "story_v_out_122541.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_122541", "122541027", "story_v_out_122541.awb")

						arg_117_1:RecordAudio("122541027", var_120_6)
						arg_117_1:RecordAudio("122541027", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_122541", "122541027", "story_v_out_122541.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_122541", "122541027", "story_v_out_122541.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play122541028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 122541028
		arg_121_1.duration_ = 15.87

		local var_121_0 = {
			ja = 15.866,
			ko = 9.266,
			zh = 9.266
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
				arg_121_0:Play122541029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.875

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(122541028)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 35 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 35)

				if (35 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 35)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541028", "story_v_out_122541.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541028", "story_v_out_122541.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_122541", "122541028", "story_v_out_122541.awb")

						arg_121_1:RecordAudio("122541028", var_124_6)
						arg_121_1:RecordAudio("122541028", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_122541", "122541028", "story_v_out_122541.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_122541", "122541028", "story_v_out_122541.awb")
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
	Play122541029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 122541029
		arg_125_1.duration_ = 17.43

		local var_125_0 = {
			ja = 17.433,
			ko = 12.6,
			zh = 12.6
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
				arg_125_0:Play122541030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.325

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(122541029)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 53 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 53)

				if (53 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 53)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541029", "story_v_out_122541.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541029", "story_v_out_122541.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_122541", "122541029", "story_v_out_122541.awb")

						arg_125_1:RecordAudio("122541029", var_128_6)
						arg_125_1:RecordAudio("122541029", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_122541", "122541029", "story_v_out_122541.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_122541", "122541029", "story_v_out_122541.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play122541030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 122541030
		arg_129_1.duration_ = 13.33

		local var_129_0 = {
			ja = 13.333,
			ko = 13.233,
			zh = 13.233
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
				arg_129_0:Play122541031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.225

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(122541030)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 49 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 49)

				if (49 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 49)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541030", "story_v_out_122541.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541030", "story_v_out_122541.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_122541", "122541030", "story_v_out_122541.awb")

						arg_129_1:RecordAudio("122541030", var_132_6)
						arg_129_1:RecordAudio("122541030", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_122541", "122541030", "story_v_out_122541.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_122541", "122541030", "story_v_out_122541.awb")
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
	Play122541031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 122541031
		arg_133_1.duration_ = 4.73

		local var_133_0 = {
			ja = 4.733,
			ko = 3.566,
			zh = 3.566
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
				arg_133_0:Play122541032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.3

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(122541031)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 12 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 12)

				if (12 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 12)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541031", "story_v_out_122541.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541031", "story_v_out_122541.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_122541", "122541031", "story_v_out_122541.awb")

						arg_133_1:RecordAudio("122541031", var_136_6)
						arg_133_1:RecordAudio("122541031", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_122541", "122541031", "story_v_out_122541.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_122541", "122541031", "story_v_out_122541.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play122541032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 122541032
		arg_137_1.duration_ = 8.2

		local var_137_0 = {
			ja = 6.666,
			ko = 8.2,
			zh = 8.2
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play122541033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.8

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(122541032)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 32 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 32)

				if (32 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 32)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541032", "story_v_out_122541.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541032", "story_v_out_122541.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_122541", "122541032", "story_v_out_122541.awb")

						arg_137_1:RecordAudio("122541032", var_140_6)
						arg_137_1:RecordAudio("122541032", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_122541", "122541032", "story_v_out_122541.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_122541", "122541032", "story_v_out_122541.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play122541033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 122541033
		arg_141_1.duration_ = 17.57

		local var_141_0 = {
			ja = 17.566,
			ko = 15.5,
			zh = 15.5
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
				arg_141_0:Play122541034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.375

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:GetWordFromCfg(122541033)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 55 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 55)

				if (55 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 55)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541033", "story_v_out_122541.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541033", "story_v_out_122541.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_122541", "122541033", "story_v_out_122541.awb")

						arg_141_1:RecordAudio("122541033", var_144_6)
						arg_141_1:RecordAudio("122541033", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_122541", "122541033", "story_v_out_122541.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_122541", "122541033", "story_v_out_122541.awb")
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
	Play122541034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 122541034
		arg_145_1.duration_ = 14.1

		local var_145_0 = {
			ja = 14.1,
			ko = 10.033,
			zh = 10.033
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play122541035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.075

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(122541034)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 43 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 43)

				if (43 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 43)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541034", "story_v_out_122541.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541034", "story_v_out_122541.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_122541", "122541034", "story_v_out_122541.awb")

						arg_145_1:RecordAudio("122541034", var_148_6)
						arg_145_1:RecordAudio("122541034", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_122541", "122541034", "story_v_out_122541.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_122541", "122541034", "story_v_out_122541.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play122541035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 122541035
		arg_149_1.duration_ = 7.83

		local var_149_0 = {
			ja = 7.833,
			ko = 6.166,
			zh = 6.166
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
				arg_149_0:Play122541036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.4

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(122541035)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 16 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 16)

				if (16 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 16)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541035", "story_v_out_122541.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541035", "story_v_out_122541.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_122541", "122541035", "story_v_out_122541.awb")

						arg_149_1:RecordAudio("122541035", var_152_6)
						arg_149_1:RecordAudio("122541035", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_122541", "122541035", "story_v_out_122541.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_122541", "122541035", "story_v_out_122541.awb")
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
	Play122541036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 122541036
		arg_153_1.duration_ = 12.07

		local var_153_0 = {
			ja = 12.066,
			ko = 11.8,
			zh = 11.8
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
				arg_153_0:Play122541037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.3

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(122541036)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 50 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 50)

				if (50 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 50)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541036", "story_v_out_122541.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541036", "story_v_out_122541.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_122541", "122541036", "story_v_out_122541.awb")

						arg_153_1:RecordAudio("122541036", var_156_6)
						arg_153_1:RecordAudio("122541036", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_122541", "122541036", "story_v_out_122541.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_122541", "122541036", "story_v_out_122541.awb")
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
	Play122541037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 122541037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play122541038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.2

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(122541037).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 53 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 53)

				if (53 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 53)) > 0 and var_160_0 < var_160_3 then
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
	Play122541038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 122541038
		arg_161_1.duration_ = 2.37

		local var_161_0 = {
			ja = 2.366,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_161_0:Play122541039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.15

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(122541038)
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

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541038", "story_v_out_122541.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541038", "story_v_out_122541.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_122541", "122541038", "story_v_out_122541.awb")

						arg_161_1:RecordAudio("122541038", var_164_6)
						arg_161_1:RecordAudio("122541038", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_122541", "122541038", "story_v_out_122541.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_122541", "122541038", "story_v_out_122541.awb")
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
	Play122541039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 122541039
		arg_165_1.duration_ = 6.4

		local var_165_0 = {
			ja = 6.4,
			ko = 3.333,
			zh = 3.333
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play122541040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.325

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(122541039)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 13 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 13)

				if (13 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 13)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541039", "story_v_out_122541.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541039", "story_v_out_122541.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_122541", "122541039", "story_v_out_122541.awb")

						arg_165_1:RecordAudio("122541039", var_168_6)
						arg_165_1:RecordAudio("122541039", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_122541", "122541039", "story_v_out_122541.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_122541", "122541039", "story_v_out_122541.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play122541040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 122541040
		arg_169_1.duration_ = 8.9

		local var_169_0 = {
			ja = 8.9,
			ko = 7.133,
			zh = 7.133
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play122541041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.9

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(122541040)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 36 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 36)

				if (36 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 36)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541040", "story_v_out_122541.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541040", "story_v_out_122541.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_122541", "122541040", "story_v_out_122541.awb")

						arg_169_1:RecordAudio("122541040", var_172_6)
						arg_169_1:RecordAudio("122541040", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_122541", "122541040", "story_v_out_122541.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_122541", "122541040", "story_v_out_122541.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play122541041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 122541041
		arg_173_1.duration_ = 10.47

		local var_173_0 = {
			ja = 10.466,
			ko = 5.5,
			zh = 5.5
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
				arg_173_0:Play122541042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.75

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(122541041)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 30 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 30)

				if (30 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 30)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541041", "story_v_out_122541.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541041", "story_v_out_122541.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_122541", "122541041", "story_v_out_122541.awb")

						arg_173_1:RecordAudio("122541041", var_176_6)
						arg_173_1:RecordAudio("122541041", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_122541", "122541041", "story_v_out_122541.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_122541", "122541041", "story_v_out_122541.awb")
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
	Play122541042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 122541042
		arg_177_1.duration_ = 11.67

		local var_177_0 = {
			ja = 11.666,
			ko = 10.033,
			zh = 10.033
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
				arg_177_0:Play122541043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1.15

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(122541042)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 46 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 46)

				if (46 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 46)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541042", "story_v_out_122541.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541042", "story_v_out_122541.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_122541", "122541042", "story_v_out_122541.awb")

						arg_177_1:RecordAudio("122541042", var_180_6)
						arg_177_1:RecordAudio("122541042", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_122541", "122541042", "story_v_out_122541.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_122541", "122541042", "story_v_out_122541.awb")
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
	Play122541043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122541043
		arg_181_1.duration_ = 12.23

		local var_181_0 = {
			ja = 12.233,
			ko = 8.9,
			zh = 8.9
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
				arg_181_0:Play122541044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.175

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(122541043)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 47 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 47)

				if (47 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 47)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541043", "story_v_out_122541.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541043", "story_v_out_122541.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_122541", "122541043", "story_v_out_122541.awb")

						arg_181_1:RecordAudio("122541043", var_184_6)
						arg_181_1:RecordAudio("122541043", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_122541", "122541043", "story_v_out_122541.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_122541", "122541043", "story_v_out_122541.awb")
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
	Play122541044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122541044
		arg_185_1.duration_ = 9.07

		local var_185_0 = {
			ja = 9.066,
			ko = 7.366,
			zh = 7.366
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
				arg_185_0:Play122541045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.825

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(122541044)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 33 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 33)

				if (33 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 33)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541044", "story_v_out_122541.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541044", "story_v_out_122541.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_122541", "122541044", "story_v_out_122541.awb")

						arg_185_1:RecordAudio("122541044", var_188_6)
						arg_185_1:RecordAudio("122541044", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_122541", "122541044", "story_v_out_122541.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_122541", "122541044", "story_v_out_122541.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play122541045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122541045
		arg_189_1.duration_ = 11.97

		local var_189_0 = {
			ja = 11.966,
			ko = 7.033,
			zh = 7.033
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
				arg_189_0:Play122541046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.65

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(122541045)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 26 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 26)

				if (26 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 26)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541045", "story_v_out_122541.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541045", "story_v_out_122541.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_122541", "122541045", "story_v_out_122541.awb")

						arg_189_1:RecordAudio("122541045", var_192_6)
						arg_189_1:RecordAudio("122541045", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_122541", "122541045", "story_v_out_122541.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_122541", "122541045", "story_v_out_122541.awb")
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
	Play122541046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122541046
		arg_193_1.duration_ = 6.7

		local var_193_0 = {
			ja = 6.7,
			ko = 6.433,
			zh = 6.433
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play122541047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.525

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(122541046)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 21 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 21)

				if (21 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 21)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541046", "story_v_out_122541.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541046", "story_v_out_122541.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_122541", "122541046", "story_v_out_122541.awb")

						arg_193_1:RecordAudio("122541046", var_196_6)
						arg_193_1:RecordAudio("122541046", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_122541", "122541046", "story_v_out_122541.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_122541", "122541046", "story_v_out_122541.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play122541047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 122541047
		arg_197_1.duration_ = 10.3

		local var_197_0 = {
			ja = 10.3,
			ko = 7.666,
			zh = 7.666
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
				arg_197_0:Play122541048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.05

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(122541047)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 42 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 42)

				if (42 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 42)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541047", "story_v_out_122541.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541047", "story_v_out_122541.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_122541", "122541047", "story_v_out_122541.awb")

						arg_197_1:RecordAudio("122541047", var_200_6)
						arg_197_1:RecordAudio("122541047", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_122541", "122541047", "story_v_out_122541.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_122541", "122541047", "story_v_out_122541.awb")
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
	Play122541048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 122541048
		arg_201_1.duration_ = 9.17

		local var_201_0 = {
			ja = 9.166,
			ko = 7.666,
			zh = 7.666
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play122541049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.95

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(122541048)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 38 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 38)

				if (38 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 38)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541048", "story_v_out_122541.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541048", "story_v_out_122541.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_122541", "122541048", "story_v_out_122541.awb")

						arg_201_1:RecordAudio("122541048", var_204_6)
						arg_201_1:RecordAudio("122541048", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_122541", "122541048", "story_v_out_122541.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_122541", "122541048", "story_v_out_122541.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play122541049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 122541049
		arg_205_1.duration_ = 4.67

		local var_205_0 = {
			ja = 4.666,
			ko = 2.7,
			zh = 2.7
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
				arg_205_0:Play122541050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.175

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(122541049)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 7 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 7)

				if (7 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 7)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541049", "story_v_out_122541.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541049", "story_v_out_122541.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_122541", "122541049", "story_v_out_122541.awb")

						arg_205_1:RecordAudio("122541049", var_208_6)
						arg_205_1:RecordAudio("122541049", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_122541", "122541049", "story_v_out_122541.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_122541", "122541049", "story_v_out_122541.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play122541050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 122541050
		arg_209_1.duration_ = 3.07

		local var_209_0 = {
			ja = 3.066,
			ko = 3.033,
			zh = 3.033
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play122541051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.25

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:GetWordFromCfg(122541050)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 10 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 10)

				if (10 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 10)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541050", "story_v_out_122541.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541050", "story_v_out_122541.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_122541", "122541050", "story_v_out_122541.awb")

						arg_209_1:RecordAudio("122541050", var_212_6)
						arg_209_1:RecordAudio("122541050", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_122541", "122541050", "story_v_out_122541.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_122541", "122541050", "story_v_out_122541.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play122541051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 122541051
		arg_213_1.duration_ = 9.6

		local var_213_0 = {
			ja = 9.6,
			ko = 5.933,
			zh = 5.933
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
				arg_213_0:Play122541052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.7

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(122541051)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 28 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 28)

				if (28 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 28)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541051", "story_v_out_122541.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541051", "story_v_out_122541.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_122541", "122541051", "story_v_out_122541.awb")

						arg_213_1:RecordAudio("122541051", var_216_6)
						arg_213_1:RecordAudio("122541051", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_122541", "122541051", "story_v_out_122541.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_122541", "122541051", "story_v_out_122541.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play122541052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 122541052
		arg_217_1.duration_ = 4.4

		local var_217_0 = {
			ja = 4.4,
			ko = 4.166,
			zh = 4.166
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
				arg_217_0:Play122541053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.55

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(122541052)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 22 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 22)

				if (22 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 22)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541052", "story_v_out_122541.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541052", "story_v_out_122541.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_122541", "122541052", "story_v_out_122541.awb")

						arg_217_1:RecordAudio("122541052", var_220_6)
						arg_217_1:RecordAudio("122541052", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_122541", "122541052", "story_v_out_122541.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_122541", "122541052", "story_v_out_122541.awb")
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
	Play122541053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 122541053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play122541054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.4

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(122541053).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 56 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 56)

				if (56 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 56)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play122541054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 122541054
		arg_225_1.duration_ = 4.4

		local var_225_0 = {
			ja = 4.4,
			ko = 3.9,
			zh = 3.9
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
				arg_225_0:Play122541055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.175

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(122541054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 7 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 7)

				if (7 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 7)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541054", "story_v_out_122541.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541054", "story_v_out_122541.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_122541", "122541054", "story_v_out_122541.awb")

						arg_225_1:RecordAudio("122541054", var_228_6)
						arg_225_1:RecordAudio("122541054", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_122541", "122541054", "story_v_out_122541.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_122541", "122541054", "story_v_out_122541.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play122541055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 122541055
		arg_229_1.duration_ = 8.97

		local var_229_0 = {
			ja = 8.966,
			ko = 6.9,
			zh = 6.9
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
				arg_229_0:Play122541056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.825

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(122541055)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 33)

				if (33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 33)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541055", "story_v_out_122541.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541055", "story_v_out_122541.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_122541", "122541055", "story_v_out_122541.awb")

						arg_229_1:RecordAudio("122541055", var_232_6)
						arg_229_1:RecordAudio("122541055", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_122541", "122541055", "story_v_out_122541.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_122541", "122541055", "story_v_out_122541.awb")
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
	Play122541056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 122541056
		arg_233_1.duration_ = 9.03

		local var_233_0 = {
			ja = 9.033,
			ko = 4.733,
			zh = 4.733
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
				arg_233_0:Play122541057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.675

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:GetWordFromCfg(122541056)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 27 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 27)

				if (27 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 27)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541056", "story_v_out_122541.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541056", "story_v_out_122541.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_122541", "122541056", "story_v_out_122541.awb")

						arg_233_1:RecordAudio("122541056", var_236_6)
						arg_233_1:RecordAudio("122541056", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_122541", "122541056", "story_v_out_122541.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_122541", "122541056", "story_v_out_122541.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play122541057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 122541057
		arg_237_1.duration_ = 13.4

		local var_237_0 = {
			ja = 13.4,
			ko = 2.1,
			zh = 2.1
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
				arg_237_0:Play122541058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.225

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(122541057)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 9 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 9)

				if (9 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 9)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541057", "story_v_out_122541.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541057", "story_v_out_122541.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_122541", "122541057", "story_v_out_122541.awb")

						arg_237_1:RecordAudio("122541057", var_240_6)
						arg_237_1:RecordAudio("122541057", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_122541", "122541057", "story_v_out_122541.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_122541", "122541057", "story_v_out_122541.awb")
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
	Play122541058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 122541058
		arg_241_1.duration_ = 7.63

		local var_241_0 = {
			ja = 7.633,
			ko = 2.3,
			zh = 2.3
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
				arg_241_0:Play122541059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.325

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(122541058)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 13 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 13)

				if (13 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 13)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541058", "story_v_out_122541.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541058", "story_v_out_122541.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_122541", "122541058", "story_v_out_122541.awb")

						arg_241_1:RecordAudio("122541058", var_244_6)
						arg_241_1:RecordAudio("122541058", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_122541", "122541058", "story_v_out_122541.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_122541", "122541058", "story_v_out_122541.awb")
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
	Play122541059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 122541059
		arg_245_1.duration_ = 11.1

		local var_245_0 = {
			ja = 11.1,
			ko = 6.866,
			zh = 6.866
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
				arg_245_0:Play122541060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.6

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(122541059)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 24 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 24)

				if (24 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 24)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541059", "story_v_out_122541.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541059", "story_v_out_122541.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_122541", "122541059", "story_v_out_122541.awb")

						arg_245_1:RecordAudio("122541059", var_248_6)
						arg_245_1:RecordAudio("122541059", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_122541", "122541059", "story_v_out_122541.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_122541", "122541059", "story_v_out_122541.awb")
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
	Play122541060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 122541060
		arg_249_1.duration_ = 15.23

		local var_249_0 = {
			ja = 15.233,
			ko = 10.066,
			zh = 10.066
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play122541061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 1.05

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(122541060)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 42 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 42)

				if (42 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 42)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541060", "story_v_out_122541.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541060", "story_v_out_122541.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_122541", "122541060", "story_v_out_122541.awb")

						arg_249_1:RecordAudio("122541060", var_252_6)
						arg_249_1:RecordAudio("122541060", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_122541", "122541060", "story_v_out_122541.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_122541", "122541060", "story_v_out_122541.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play122541061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 122541061
		arg_253_1.duration_ = 14.23

		local var_253_0 = {
			ja = 14.233,
			ko = 8.266,
			zh = 8.266
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
				arg_253_0:Play122541062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.925

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:GetWordFromCfg(122541061)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 37 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 37)

				if (37 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 37)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541061", "story_v_out_122541.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541061", "story_v_out_122541.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_122541", "122541061", "story_v_out_122541.awb")

						arg_253_1:RecordAudio("122541061", var_256_6)
						arg_253_1:RecordAudio("122541061", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_122541", "122541061", "story_v_out_122541.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_122541", "122541061", "story_v_out_122541.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play122541062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 122541062
		arg_257_1.duration_ = 13.6

		local var_257_0 = {
			ja = 13.6,
			ko = 7.266,
			zh = 7.266
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
				arg_257_0:Play122541063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.925

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:GetWordFromCfg(122541062)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 37 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 37)

				if (37 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 37)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541062", "story_v_out_122541.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541062", "story_v_out_122541.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_122541", "122541062", "story_v_out_122541.awb")

						arg_257_1:RecordAudio("122541062", var_260_6)
						arg_257_1:RecordAudio("122541062", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_122541", "122541062", "story_v_out_122541.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_122541", "122541062", "story_v_out_122541.awb")
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
	Play122541063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 122541063
		arg_261_1.duration_ = 18.43

		local var_261_0 = {
			ja = 18.433,
			ko = 8.6,
			zh = 8.6
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play122541064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 1

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(122541063)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 40 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 40)

				if (40 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 40)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541063", "story_v_out_122541.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541063", "story_v_out_122541.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_122541", "122541063", "story_v_out_122541.awb")

						arg_261_1:RecordAudio("122541063", var_264_6)
						arg_261_1:RecordAudio("122541063", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_122541", "122541063", "story_v_out_122541.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_122541", "122541063", "story_v_out_122541.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play122541064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 122541064
		arg_265_1.duration_ = 15.17

		local var_265_0 = {
			ja = 15.166,
			ko = 7.6,
			zh = 7.6
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
				arg_265_0:Play122541065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.05

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:GetWordFromCfg(122541064)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 42 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 42)

				if (42 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 42)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541064", "story_v_out_122541.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541064", "story_v_out_122541.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_122541", "122541064", "story_v_out_122541.awb")

						arg_265_1:RecordAudio("122541064", var_268_6)
						arg_265_1:RecordAudio("122541064", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_122541", "122541064", "story_v_out_122541.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_122541", "122541064", "story_v_out_122541.awb")
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
	Play122541065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 122541065
		arg_269_1.duration_ = 5.1

		local var_269_0 = {
			ja = 5.1,
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
				arg_269_0:Play122541066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.325

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(122541065)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 13 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 13)

				if (13 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 13)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541065", "story_v_out_122541.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541065", "story_v_out_122541.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_122541", "122541065", "story_v_out_122541.awb")

						arg_269_1:RecordAudio("122541065", var_272_6)
						arg_269_1:RecordAudio("122541065", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_122541", "122541065", "story_v_out_122541.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_122541", "122541065", "story_v_out_122541.awb")
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
	Play122541066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 122541066
		arg_273_1.duration_ = 13.1

		local var_273_0 = {
			ja = 13.1,
			ko = 8.766,
			zh = 8.766
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
				arg_273_0:Play122541067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.9

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(122541066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 36 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 36)

				if (36 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 36)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541066", "story_v_out_122541.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541066", "story_v_out_122541.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_122541", "122541066", "story_v_out_122541.awb")

						arg_273_1:RecordAudio("122541066", var_276_6)
						arg_273_1:RecordAudio("122541066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_122541", "122541066", "story_v_out_122541.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_122541", "122541066", "story_v_out_122541.awb")
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
	Play122541067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 122541067
		arg_277_1.duration_ = 9.07

		local var_277_0 = {
			ja = 9.066,
			ko = 1.9,
			zh = 1.9
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
				arg_277_0:Play122541068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.2

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(122541067)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 8 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 8)

				if (8 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 8)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541067", "story_v_out_122541.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541067", "story_v_out_122541.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_122541", "122541067", "story_v_out_122541.awb")

						arg_277_1:RecordAudio("122541067", var_280_6)
						arg_277_1:RecordAudio("122541067", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_122541", "122541067", "story_v_out_122541.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_122541", "122541067", "story_v_out_122541.awb")
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
	Play122541068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 122541068
		arg_281_1.duration_ = 7.3

		local var_281_0 = {
			ja = 7.3,
			ko = 6.1,
			zh = 6.1
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
				arg_281_0:Play122541069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.725

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(122541068)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 28 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 28)

				if (28 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 28)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541068", "story_v_out_122541.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541068", "story_v_out_122541.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_122541", "122541068", "story_v_out_122541.awb")

						arg_281_1:RecordAudio("122541068", var_284_6)
						arg_281_1:RecordAudio("122541068", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_122541", "122541068", "story_v_out_122541.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_122541", "122541068", "story_v_out_122541.awb")
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
	Play122541069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 122541069
		arg_285_1.duration_ = 17.73

		local var_285_0 = {
			ja = 17.733,
			ko = 13.966,
			zh = 13.966
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
				arg_285_0:Play122541070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 1.675

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(122541069)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 67 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 67)

				if (67 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 67)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541069", "story_v_out_122541.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541069", "story_v_out_122541.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_122541", "122541069", "story_v_out_122541.awb")

						arg_285_1:RecordAudio("122541069", var_288_6)
						arg_285_1:RecordAudio("122541069", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_122541", "122541069", "story_v_out_122541.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_122541", "122541069", "story_v_out_122541.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play122541070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 122541070
		arg_289_1.duration_ = 13.73

		local var_289_0 = {
			ja = 12.333,
			ko = 13.733,
			zh = 13.733
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
				arg_289_0:Play122541071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.375

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(122541070)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 55 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 55)

				if (55 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 55)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541070", "story_v_out_122541.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541070", "story_v_out_122541.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_122541", "122541070", "story_v_out_122541.awb")

						arg_289_1:RecordAudio("122541070", var_292_6)
						arg_289_1:RecordAudio("122541070", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_122541", "122541070", "story_v_out_122541.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_122541", "122541070", "story_v_out_122541.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play122541071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 122541071
		arg_293_1.duration_ = 7.23

		local var_293_0 = {
			ja = 6.2,
			ko = 7.233,
			zh = 7.233
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
				arg_293_0:Play122541072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.725

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(122541071)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 29 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 29)

				if (29 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 29)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541071", "story_v_out_122541.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541071", "story_v_out_122541.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_122541", "122541071", "story_v_out_122541.awb")

						arg_293_1:RecordAudio("122541071", var_296_6)
						arg_293_1:RecordAudio("122541071", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_122541", "122541071", "story_v_out_122541.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_122541", "122541071", "story_v_out_122541.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play122541072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 122541072
		arg_297_1.duration_ = 5.2

		local var_297_0 = {
			ja = 5.2,
			ko = 2.966,
			zh = 2.966
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play122541073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.4

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:GetWordFromCfg(122541072)
				local var_300_2 = arg_297_1:FormatText(var_300_1.content)

				arg_297_1.text_.text = var_300_2

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 16 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 16)

				if (16 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 16)) > 0 and var_300_0 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end

				arg_297_1.text_.text = var_300_2
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541072", "story_v_out_122541.awb") ~= 0 then
					local var_300_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541072", "story_v_out_122541.awb") / 1000

					if var_300_5 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + 0
					end

					if var_300_1.prefab_name ~= "" and arg_297_1.actors_[var_300_1.prefab_name] ~= nil then
						local var_300_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_1.prefab_name].transform, "story_v_out_122541", "122541072", "story_v_out_122541.awb")

						arg_297_1:RecordAudio("122541072", var_300_6)
						arg_297_1:RecordAudio("122541072", var_300_6)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_122541", "122541072", "story_v_out_122541.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_122541", "122541072", "story_v_out_122541.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play122541073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 122541073
		arg_301_1.duration_ = 10.47

		local var_301_0 = {
			ja = 10.466,
			ko = 6.533,
			zh = 6.533
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
				arg_301_0:Play122541074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.775

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(122541073)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 31 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 31)

				if (31 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 31)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541073", "story_v_out_122541.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541073", "story_v_out_122541.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_122541", "122541073", "story_v_out_122541.awb")

						arg_301_1:RecordAudio("122541073", var_304_6)
						arg_301_1:RecordAudio("122541073", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_122541", "122541073", "story_v_out_122541.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_122541", "122541073", "story_v_out_122541.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play122541074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 122541074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play122541075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1.1

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(122541074).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 44 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 44)

				if (44 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 44)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play122541075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 122541075
		arg_309_1.duration_ = 7.07

		local var_309_0 = {
			ja = 7.066,
			ko = 5.066,
			zh = 5.066
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
				arg_309_0:Play122541076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.575

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(122541075)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 23 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 23)

				if (23 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 23)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541075", "story_v_out_122541.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541075", "story_v_out_122541.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_122541", "122541075", "story_v_out_122541.awb")

						arg_309_1:RecordAudio("122541075", var_312_6)
						arg_309_1:RecordAudio("122541075", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_122541", "122541075", "story_v_out_122541.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_122541", "122541075", "story_v_out_122541.awb")
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
	Play122541076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 122541076
		arg_313_1.duration_ = 2

		local var_313_0 = {
			ja = 2,
			ko = 1.8,
			zh = 1.8
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
				arg_313_0:Play122541077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.175

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:GetWordFromCfg(122541076)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 7 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 7)

				if (7 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 7)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541076", "story_v_out_122541.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541076", "story_v_out_122541.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_122541", "122541076", "story_v_out_122541.awb")

						arg_313_1:RecordAudio("122541076", var_316_6)
						arg_313_1:RecordAudio("122541076", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_122541", "122541076", "story_v_out_122541.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_122541", "122541076", "story_v_out_122541.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play122541077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 122541077
		arg_317_1.duration_ = 10

		local var_317_0 = {
			ja = 10,
			ko = 3.666,
			zh = 3.666
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
				arg_317_0:Play122541078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.325

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:GetWordFromCfg(122541077)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 13 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 13)

				if (13 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 13)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541077", "story_v_out_122541.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541077", "story_v_out_122541.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_122541", "122541077", "story_v_out_122541.awb")

						arg_317_1:RecordAudio("122541077", var_320_6)
						arg_317_1:RecordAudio("122541077", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_122541", "122541077", "story_v_out_122541.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_122541", "122541077", "story_v_out_122541.awb")
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
	Play122541078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 122541078
		arg_321_1.duration_ = 4.57

		local var_321_0 = {
			ja = 4.566,
			ko = 1.5,
			zh = 1.5
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
				arg_321_0:Play122541079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.1

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(122541078)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 4 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 4)

				if (4 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 4)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541078", "story_v_out_122541.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541078", "story_v_out_122541.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_122541", "122541078", "story_v_out_122541.awb")

						arg_321_1:RecordAudio("122541078", var_324_6)
						arg_321_1:RecordAudio("122541078", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_122541", "122541078", "story_v_out_122541.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_122541", "122541078", "story_v_out_122541.awb")
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
	Play122541079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 122541079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play122541080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.9

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

				local var_328_1 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(122541079).content)

				arg_325_1.text_.text = var_328_1

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_3 = 36 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 36)

				if (36 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 36)) > 0 and var_328_0 < var_328_3 then
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
	Play122541080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 122541080
		arg_329_1.duration_ = 9.63

		local var_329_0 = {
			ja = 9.633,
			ko = 6.166,
			zh = 6.166
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
				arg_329_0:Play122541081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.75

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:GetWordFromCfg(122541080)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 30 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 30)

				if (30 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 30)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541080", "story_v_out_122541.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541080", "story_v_out_122541.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_122541", "122541080", "story_v_out_122541.awb")

						arg_329_1:RecordAudio("122541080", var_332_6)
						arg_329_1:RecordAudio("122541080", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_122541", "122541080", "story_v_out_122541.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_122541", "122541080", "story_v_out_122541.awb")
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
	Play122541081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 122541081
		arg_333_1.duration_ = 7.7

		local var_333_0 = {
			ja = 7.7,
			ko = 7.266,
			zh = 7.266
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
				arg_333_0:Play122541082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.725

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:GetWordFromCfg(122541081)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 29 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 29)

				if (29 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 29)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541081", "story_v_out_122541.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541081", "story_v_out_122541.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_out_122541", "122541081", "story_v_out_122541.awb")

						arg_333_1:RecordAudio("122541081", var_336_6)
						arg_333_1:RecordAudio("122541081", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_122541", "122541081", "story_v_out_122541.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_122541", "122541081", "story_v_out_122541.awb")
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
	Play122541082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 122541082
		arg_337_1.duration_ = 1.67

		local var_337_0 = {
			ja = 1.666,
			ko = 0.999999999999,
			zh = 0.999999999999
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
				arg_337_0:Play122541083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.05

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:GetWordFromCfg(122541082)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 2 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 2)

				if (2 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 2)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541082", "story_v_out_122541.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541082", "story_v_out_122541.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_122541", "122541082", "story_v_out_122541.awb")

						arg_337_1:RecordAudio("122541082", var_340_6)
						arg_337_1:RecordAudio("122541082", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_122541", "122541082", "story_v_out_122541.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_122541", "122541082", "story_v_out_122541.awb")
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
	Play122541083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 122541083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play122541084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.875

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

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(122541083).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 35 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 35)

				if (35 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 35)) > 0 and var_344_0 < var_344_3 then
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
	Play122541084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 122541084
		arg_345_1.duration_ = 4.57

		local var_345_0 = {
			ja = 4.566,
			ko = 3.466,
			zh = 3.466
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
				arg_345_0:Play122541085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.3

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:GetWordFromCfg(122541084)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 13 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 13)

				if (13 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 13)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541084", "story_v_out_122541.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541084", "story_v_out_122541.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_122541", "122541084", "story_v_out_122541.awb")

						arg_345_1:RecordAudio("122541084", var_348_6)
						arg_345_1:RecordAudio("122541084", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_122541", "122541084", "story_v_out_122541.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_122541", "122541084", "story_v_out_122541.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play122541085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 122541085
		arg_349_1.duration_ = 9

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play122541086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if arg_349_1.bgs_.I05 == nil then
				local var_352_0 = Object.Instantiate(arg_349_1.paintGo_)

				var_352_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05")
				var_352_0.name = "I05"
				var_352_0.transform.parent = arg_349_1.stage_.transform
				var_352_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.bgs_.I05 = var_352_0
			end

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= 2 + arg_352_0 then
				local var_352_1 = arg_349_1.bgs_.I05

				arg_349_1.bgs_.I05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_352_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_352_2 = var_352_1:GetComponent("SpriteRenderer")

				if var_352_2 and var_352_2.sprite then
					local var_352_3 = 2 * (var_352_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_352_1.transform.localScale = Vector3.New(var_352_3 / var_352_2.sprite.bounds.size.y < var_352_3 * manager.ui.mainCameraCom_.aspect / var_352_2.sprite.bounds.size.x and var_352_3 * manager.ui.mainCameraCom_.aspect / var_352_2.sprite.bounds.size.x or var_352_3 / var_352_2.sprite.bounds.size.y, var_352_3 / var_352_2.sprite.bounds.size.y < var_352_3 * manager.ui.mainCameraCom_.aspect / var_352_2.sprite.bounds.size.x and var_352_3 * manager.ui.mainCameraCom_.aspect / var_352_2.sprite.bounds.size.x or var_352_3 / var_352_2.sprite.bounds.size.y, 0)
				end

				for iter_352_0, iter_352_1 in pairs(arg_349_1.bgs_) do
					if iter_352_0 ~= "I05" then
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

			if arg_349_1.frameCnt_ <= 1 then
				arg_349_1.dialog_:SetActive(false)
			end

			local var_352_12 = 4
			local var_352_13 = 1

			if 4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_12 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				arg_349_1.dialog_:SetActive(true)

				arg_349_1.dialogCg_.alpha = 0

				local var_352_14 = LeanTween.value(arg_349_1.dialog_, 0, 1, 0.3)

				var_352_14:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_349_1.dialogCg_.alpha = arg_353_0
				end))
				var_352_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_349_1.dialog_)
					var_352_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_349_1.duration_ = arg_349_1.duration_ + 0.3

				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_15 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(122541085).content)

				arg_349_1.text_.text = var_352_15

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_17 = 40 <= 0 and var_352_13 or var_352_13 * (utf8.len(var_352_15) / 40)

				if (40 <= 0 and var_352_13 or var_352_13 * (utf8.len(var_352_15) / 40)) > 0 and var_352_13 < var_352_17 then
					arg_349_1.talkMaxDuration = var_352_17
					var_352_12 = var_352_12 + 0.3

					if var_352_17 + var_352_12 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_17 + var_352_12
					end
				end

				arg_349_1.text_.text = var_352_15
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_18 = var_352_12 + 0.3
			local var_352_19 = math.max(var_352_13, arg_349_1.talkMaxDuration)

			if var_352_12 + 0.3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_18 + var_352_19 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_18) / var_352_19

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_18 + var_352_19 and arg_349_1.time_ < var_352_18 + var_352_19 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play122541086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 122541086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play122541087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.025

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(122541086).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 41 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 41)

				if (41 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 41)) > 0 and var_358_0 < var_358_3 then
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
	Play122541087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 122541087
		arg_359_1.duration_ = 4.17

		local var_359_0 = {
			ja = 4.166,
			ko = 2.933,
			zh = 2.933
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
				arg_359_0:Play122541088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if arg_359_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_362_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_359_1.stage_.transform)

				var_362_0.name = "1029ui_story"
				var_362_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.actors_["1029ui_story"] = var_362_0

				local var_362_1 = var_362_0:GetComponentInChildren(typeof(CharacterEffect))

				var_362_1.enabled = true

				local var_362_2 = GameObjectTools.GetOrAddComponent(var_362_0, typeof(DynamicBoneHelper))

				if var_362_2 then
					var_362_2:EnableDynamicBone(false)
				end

				arg_359_1:ShowWeapon(var_362_1.transform, false)

				arg_359_1.var_["1029ui_story" .. "Animator"] = var_362_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_359_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_359_1.var_["1029ui_story" .. "LipSync"] = var_362_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_362_3 = arg_359_1.actors_["1029ui_story"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1029ui_story = var_362_3.localPosition
			end

			local var_362_4 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				var_362_3.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_359_1.time_ - 0) / var_362_4)
				var_362_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_3.position).x, (manager.ui.mainCamera.transform.position - var_362_3.position).y, (manager.ui.mainCamera.transform.position - var_362_3.position).z)
				var_362_3.localEulerAngles.z = 0
				var_362_3.localEulerAngles.x = 0
				var_362_3.localEulerAngles = var_362_3.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				var_362_3.localPosition = Vector3.New(0, -1.09, -6.2)
				var_362_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_3.position).x, (manager.ui.mainCamera.transform.position - var_362_3.position).y, (manager.ui.mainCamera.transform.position - var_362_3.position).z)
				var_362_3.localEulerAngles.z = 0
				var_362_3.localEulerAngles.x = 0
				var_362_3.localEulerAngles = var_362_3.localEulerAngles
			end

			local var_362_5 = arg_359_1.actors_["1029ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_5) and arg_359_1.var_.characterEffect1029ui_story == nil then
				arg_359_1.var_.characterEffect1029ui_story = var_362_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_6 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_6 and not isNil(var_362_5) then
				if arg_359_1.var_.characterEffect1029ui_story and not isNil(var_362_5) then
					arg_359_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_6 and arg_359_1.time_ < 0 + var_362_6 + arg_362_0 and not isNil(var_362_5) and arg_359_1.var_.characterEffect1029ui_story then
				arg_359_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_362_8 = 0
			local var_362_9 = 0.3

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_10 = arg_359_1:GetWordFromCfg(122541087)
				local var_362_11 = arg_359_1:FormatText(var_362_10.content)

				arg_359_1.text_.text = var_362_11

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_13 = 12 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_11) / 12)

				if (12 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_11) / 12)) > 0 and var_362_9 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13

					if var_362_13 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_8
					end
				end

				arg_359_1.text_.text = var_362_11
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541087", "story_v_out_122541.awb") ~= 0 then
					local var_362_14 = manager.audio:GetVoiceLength("story_v_out_122541", "122541087", "story_v_out_122541.awb") / 1000

					if var_362_14 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_14 + var_362_8
					end

					if var_362_10.prefab_name ~= "" and arg_359_1.actors_[var_362_10.prefab_name] ~= nil then
						local var_362_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_10.prefab_name].transform, "story_v_out_122541", "122541087", "story_v_out_122541.awb")

						arg_359_1:RecordAudio("122541087", var_362_15)
						arg_359_1:RecordAudio("122541087", var_362_15)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_122541", "122541087", "story_v_out_122541.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_122541", "122541087", "story_v_out_122541.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_16 = math.max(var_362_9, arg_359_1.talkMaxDuration)

			if var_362_8 <= arg_359_1.time_ and arg_359_1.time_ < var_362_8 + var_362_16 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_8) / var_362_16

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_8 + var_362_16 and arg_359_1.time_ < var_362_8 + var_362_16 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play122541088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 122541088
		arg_363_1.duration_ = 4.2

		local var_363_0 = {
			ja = 4.2,
			ko = 3.766,
			zh = 3.766
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
				arg_363_0:Play122541089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1029ui_story"]) and arg_363_1.var_.characterEffect1029ui_story == nil then
				arg_363_1.var_.characterEffect1029ui_story = arg_363_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1029ui_story"]) then
				if arg_363_1.var_.characterEffect1029ui_story and not isNil(arg_363_1.actors_["1029ui_story"]) then
					arg_363_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1029ui_story"]) and arg_363_1.var_.characterEffect1029ui_story then
				arg_363_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0
			local var_366_2 = 0.4

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(122541088)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_6 = 16 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_4) / 16)

				if (16 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_4) / 16)) > 0 and var_366_2 < var_366_6 then
					arg_363_1.talkMaxDuration = var_366_6

					if var_366_6 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541088", "story_v_out_122541.awb") ~= 0 then
					local var_366_7 = manager.audio:GetVoiceLength("story_v_out_122541", "122541088", "story_v_out_122541.awb") / 1000

					if var_366_7 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_1
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_122541", "122541088", "story_v_out_122541.awb")

						arg_363_1:RecordAudio("122541088", var_366_8)
						arg_363_1:RecordAudio("122541088", var_366_8)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_122541", "122541088", "story_v_out_122541.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_122541", "122541088", "story_v_out_122541.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_9 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_9 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_9

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_9 and arg_363_1.time_ < var_366_1 + var_366_9 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play122541089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 122541089
		arg_367_1.duration_ = 2.23

		local var_367_0 = {
			ja = 2,
			ko = 2.233,
			zh = 2.233
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
				arg_367_0:Play122541090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1029ui_story = arg_367_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1029ui_story"].transform.position).z)
				arg_367_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1029ui_story"].transform.localEulerAngles = arg_367_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, -1.09, -6.2)
				arg_367_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1029ui_story"].transform.position).z)
				arg_367_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1029ui_story"].transform.localEulerAngles = arg_367_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1029ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1029ui_story == nil then
				arg_367_1.var_.characterEffect1029ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1029ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1029ui_story then
				arg_367_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_370_4 = 0
			local var_370_5 = 0.075

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(122541089)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 3 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 3)

				if (3 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 3)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541089", "story_v_out_122541.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_out_122541", "122541089", "story_v_out_122541.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_out_122541", "122541089", "story_v_out_122541.awb")

						arg_367_1:RecordAudio("122541089", var_370_11)
						arg_367_1:RecordAudio("122541089", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_122541", "122541089", "story_v_out_122541.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_122541", "122541089", "story_v_out_122541.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play122541090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 122541090
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play122541091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1029ui_story = arg_371_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1029ui_story"].transform.position).z)
				arg_371_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1029ui_story"].transform.localEulerAngles = arg_371_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1029ui_story"].transform.position).z)
				arg_371_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1029ui_story"].transform.localEulerAngles = arg_371_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1029ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1029ui_story == nil then
				arg_371_1.var_.characterEffect1029ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1029ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_2)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1029ui_story then
				arg_371_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_374_3 = 0
			local var_374_4 = 0.8

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_3 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_5 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(122541090).content)

				arg_371_1.text_.text = var_374_5

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_7 = 32 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_5) / 32)

				if (32 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_5) / 32)) > 0 and var_374_4 < var_374_7 then
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
				actorName = "1029ui_story",
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
	Play122541091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 122541091
		arg_375_1.duration_ = 14.93

		local var_375_0 = {
			ja = 14.933,
			ko = 10.2,
			zh = 10.2
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
				arg_375_0:Play122541092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if arg_375_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_378_0 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_375_1.stage_.transform)

				var_378_0.name = "10014ui_story"
				var_378_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_375_1.actors_["10014ui_story"] = var_378_0

				local var_378_1 = var_378_0:GetComponentInChildren(typeof(CharacterEffect))

				var_378_1.enabled = true

				local var_378_2 = GameObjectTools.GetOrAddComponent(var_378_0, typeof(DynamicBoneHelper))

				if var_378_2 then
					var_378_2:EnableDynamicBone(false)
				end

				arg_375_1:ShowWeapon(var_378_1.transform, false)

				arg_375_1.var_["10014ui_story" .. "Animator"] = var_378_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_375_1.var_["10014ui_story" .. "Animator"].applyRootMotion = true
				arg_375_1.var_["10014ui_story" .. "LipSync"] = var_378_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_378_3 = arg_375_1.actors_["10014ui_story"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10014ui_story = var_378_3.localPosition
			end

			local var_378_4 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				var_378_3.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_375_1.time_ - 0) / var_378_4)
				var_378_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_3.position).x, (manager.ui.mainCamera.transform.position - var_378_3.position).y, (manager.ui.mainCamera.transform.position - var_378_3.position).z)
				var_378_3.localEulerAngles.z = 0
				var_378_3.localEulerAngles.x = 0
				var_378_3.localEulerAngles = var_378_3.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				var_378_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_378_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_3.position).x, (manager.ui.mainCamera.transform.position - var_378_3.position).y, (manager.ui.mainCamera.transform.position - var_378_3.position).z)
				var_378_3.localEulerAngles.z = 0
				var_378_3.localEulerAngles.x = 0
				var_378_3.localEulerAngles = var_378_3.localEulerAngles
			end

			local var_378_5 = arg_375_1.actors_["10014ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_5) and arg_375_1.var_.characterEffect10014ui_story == nil then
				arg_375_1.var_.characterEffect10014ui_story = var_378_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_6 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_6 and not isNil(var_378_5) then
				if arg_375_1.var_.characterEffect10014ui_story and not isNil(var_378_5) then
					arg_375_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_6 and arg_375_1.time_ < 0 + var_378_6 + arg_378_0 and not isNil(var_378_5) and arg_375_1.var_.characterEffect10014ui_story then
				arg_375_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_378_8 = 0
			local var_378_9 = 0.875

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_10 = arg_375_1:GetWordFromCfg(122541091)
				local var_378_11 = arg_375_1:FormatText(var_378_10.content)

				arg_375_1.text_.text = var_378_11

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_13 = 35 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 35)

				if (35 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 35)) > 0 and var_378_9 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_8
					end
				end

				arg_375_1.text_.text = var_378_11
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541091", "story_v_out_122541.awb") ~= 0 then
					local var_378_14 = manager.audio:GetVoiceLength("story_v_out_122541", "122541091", "story_v_out_122541.awb") / 1000

					if var_378_14 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_14 + var_378_8
					end

					if var_378_10.prefab_name ~= "" and arg_375_1.actors_[var_378_10.prefab_name] ~= nil then
						local var_378_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_10.prefab_name].transform, "story_v_out_122541", "122541091", "story_v_out_122541.awb")

						arg_375_1:RecordAudio("122541091", var_378_15)
						arg_375_1:RecordAudio("122541091", var_378_15)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_122541", "122541091", "story_v_out_122541.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_122541", "122541091", "story_v_out_122541.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_16 = math.max(var_378_9, arg_375_1.talkMaxDuration)

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_16 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_8) / var_378_16

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_8 + var_378_16 and arg_375_1.time_ < var_378_8 + var_378_16 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
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
	Play122541092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 122541092
		arg_379_1.duration_ = 10.63

		local var_379_0 = {
			ja = 10.633,
			ko = 4.933,
			zh = 4.933
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
				arg_379_0:Play122541093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["10014ui_story"]) and arg_379_1.var_.characterEffect10014ui_story == nil then
				arg_379_1.var_.characterEffect10014ui_story = arg_379_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["10014ui_story"]) then
				if arg_379_1.var_.characterEffect10014ui_story and not isNil(arg_379_1.actors_["10014ui_story"]) then
					arg_379_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_379_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["10014ui_story"]) and arg_379_1.var_.characterEffect10014ui_story then
				arg_379_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_379_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 0.4

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(122541092)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_6 = 16 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 16)

				if (16 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 16)) > 0 and var_382_2 < var_382_6 then
					arg_379_1.talkMaxDuration = var_382_6

					if var_382_6 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_6 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541092", "story_v_out_122541.awb") ~= 0 then
					local var_382_7 = manager.audio:GetVoiceLength("story_v_out_122541", "122541092", "story_v_out_122541.awb") / 1000

					if var_382_7 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_1
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_out_122541", "122541092", "story_v_out_122541.awb")

						arg_379_1:RecordAudio("122541092", var_382_8)
						arg_379_1:RecordAudio("122541092", var_382_8)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_122541", "122541092", "story_v_out_122541.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_122541", "122541092", "story_v_out_122541.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_9 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_9 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_9

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_9 and arg_379_1.time_ < var_382_1 + var_382_9 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play122541093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 122541093
		arg_383_1.duration_ = 4.67

		local var_383_0 = {
			ja = 1.366,
			ko = 4.666,
			zh = 4.666
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
				arg_383_0:Play122541094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["10014ui_story"]) and arg_383_1.var_.characterEffect10014ui_story == nil then
				arg_383_1.var_.characterEffect10014ui_story = arg_383_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["10014ui_story"]) then
				if arg_383_1.var_.characterEffect10014ui_story and not isNil(arg_383_1.actors_["10014ui_story"]) then
					arg_383_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["10014ui_story"]) and arg_383_1.var_.characterEffect10014ui_story then
				arg_383_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_386_2 = 0
			local var_386_3 = 0.2

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_4 = arg_383_1:GetWordFromCfg(122541093)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 8 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 8)

				if (8 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 8)) > 0 and var_386_3 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541093", "story_v_out_122541.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_122541", "122541093", "story_v_out_122541.awb") / 1000

					if var_386_8 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_2
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_out_122541", "122541093", "story_v_out_122541.awb")

						arg_383_1:RecordAudio("122541093", var_386_9)
						arg_383_1:RecordAudio("122541093", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_122541", "122541093", "story_v_out_122541.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_122541", "122541093", "story_v_out_122541.awb")
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
	Play122541094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 122541094
		arg_387_1.duration_ = 11.57

		local var_387_0 = {
			ja = 10.266,
			ko = 11.566,
			zh = 11.566
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
				arg_387_0:Play122541095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["10014ui_story"]) and arg_387_1.var_.characterEffect10014ui_story == nil then
				arg_387_1.var_.characterEffect10014ui_story = arg_387_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["10014ui_story"]) then
				if arg_387_1.var_.characterEffect10014ui_story and not isNil(arg_387_1.actors_["10014ui_story"]) then
					arg_387_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_387_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_0)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["10014ui_story"]) and arg_387_1.var_.characterEffect10014ui_story then
				arg_387_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_387_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_390_1 = 0
			local var_390_2 = 1.1

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(122541094)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_6 = 44 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_4) / 44)

				if (44 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_4) / 44)) > 0 and var_390_2 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_1
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541094", "story_v_out_122541.awb") ~= 0 then
					local var_390_7 = manager.audio:GetVoiceLength("story_v_out_122541", "122541094", "story_v_out_122541.awb") / 1000

					if var_390_7 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_1
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_out_122541", "122541094", "story_v_out_122541.awb")

						arg_387_1:RecordAudio("122541094", var_390_8)
						arg_387_1:RecordAudio("122541094", var_390_8)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_122541", "122541094", "story_v_out_122541.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_122541", "122541094", "story_v_out_122541.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_9 = math.max(var_390_2, arg_387_1.talkMaxDuration)

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_9 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_1) / var_390_9

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_1 + var_390_9 and arg_387_1.time_ < var_390_1 + var_390_9 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play122541095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 122541095
		arg_391_1.duration_ = 6.23

		local var_391_0 = {
			ja = 5.6,
			ko = 6.233,
			zh = 6.233
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
				arg_391_0:Play122541096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.6

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:GetWordFromCfg(122541095)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 24 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 24)

				if (24 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 24)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541095", "story_v_out_122541.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541095", "story_v_out_122541.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_122541", "122541095", "story_v_out_122541.awb")

						arg_391_1:RecordAudio("122541095", var_394_6)
						arg_391_1:RecordAudio("122541095", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_122541", "122541095", "story_v_out_122541.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_122541", "122541095", "story_v_out_122541.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play122541096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 122541096
		arg_395_1.duration_ = 8

		local var_395_0 = {
			ja = 8,
			ko = 6.433,
			zh = 6.433
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
				arg_395_0:Play122541097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos10014ui_story = arg_395_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).z)
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles = arg_395_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_395_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["10014ui_story"].transform.position).z)
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["10014ui_story"].transform.localEulerAngles = arg_395_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["10014ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect10014ui_story == nil then
				arg_395_1.var_.characterEffect10014ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect10014ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect10014ui_story then
				arg_395_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014actionlink/10014action432")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_4 = 0
			local var_398_5 = 0.825

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:GetWordFromCfg(122541096)
				local var_398_7 = arg_395_1:FormatText(var_398_6.content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 33 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 33)

				if (33 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 33)) > 0 and var_398_5 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541096", "story_v_out_122541.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_out_122541", "122541096", "story_v_out_122541.awb") / 1000

					if var_398_10 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_4
					end

					if var_398_6.prefab_name ~= "" and arg_395_1.actors_[var_398_6.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_6.prefab_name].transform, "story_v_out_122541", "122541096", "story_v_out_122541.awb")

						arg_395_1:RecordAudio("122541096", var_398_11)
						arg_395_1:RecordAudio("122541096", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_122541", "122541096", "story_v_out_122541.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_122541", "122541096", "story_v_out_122541.awb")
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
				actorName = "10014ui_story",
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
	Play122541097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 122541097
		arg_399_1.duration_ = 15.63

		local var_399_0 = {
			ja = 15.633,
			ko = 10.666,
			zh = 10.666
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
				arg_399_0:Play122541098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["10014ui_story"]) and arg_399_1.var_.characterEffect10014ui_story == nil then
				arg_399_1.var_.characterEffect10014ui_story = arg_399_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["10014ui_story"]) then
				if arg_399_1.var_.characterEffect10014ui_story and not isNil(arg_399_1.actors_["10014ui_story"]) then
					arg_399_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_399_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["10014ui_story"]) and arg_399_1.var_.characterEffect10014ui_story then
				arg_399_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_399_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.8

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:GetWordFromCfg(122541097)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_6 = 32 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_4) / 32)

				if (32 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_4) / 32)) > 0 and var_402_2 < var_402_6 then
					arg_399_1.talkMaxDuration = var_402_6

					if var_402_6 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_6 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541097", "story_v_out_122541.awb") ~= 0 then
					local var_402_7 = manager.audio:GetVoiceLength("story_v_out_122541", "122541097", "story_v_out_122541.awb") / 1000

					if var_402_7 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_1
					end

					if var_402_3.prefab_name ~= "" and arg_399_1.actors_[var_402_3.prefab_name] ~= nil then
						local var_402_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_3.prefab_name].transform, "story_v_out_122541", "122541097", "story_v_out_122541.awb")

						arg_399_1:RecordAudio("122541097", var_402_8)
						arg_399_1:RecordAudio("122541097", var_402_8)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_122541", "122541097", "story_v_out_122541.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_122541", "122541097", "story_v_out_122541.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_9 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_9 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_9

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_9 and arg_399_1.time_ < var_402_1 + var_402_9 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play122541098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 122541098
		arg_403_1.duration_ = 6.73

		local var_403_0 = {
			ja = 6.733,
			ko = 3.833,
			zh = 3.833
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
				arg_403_0:Play122541099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["10014ui_story"]) and arg_403_1.var_.characterEffect10014ui_story == nil then
				arg_403_1.var_.characterEffect10014ui_story = arg_403_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["10014ui_story"]) then
				if arg_403_1.var_.characterEffect10014ui_story and not isNil(arg_403_1.actors_["10014ui_story"]) then
					arg_403_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["10014ui_story"]) and arg_403_1.var_.characterEffect10014ui_story then
				arg_403_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_2")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_2 = 0
			local var_406_3 = 0.45

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_4 = arg_403_1:GetWordFromCfg(122541098)
				local var_406_5 = arg_403_1:FormatText(var_406_4.content)

				arg_403_1.text_.text = var_406_5

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 18 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 18)

				if (18 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 18)) > 0 and var_406_3 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_2
					end
				end

				arg_403_1.text_.text = var_406_5
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541098", "story_v_out_122541.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_122541", "122541098", "story_v_out_122541.awb") / 1000

					if var_406_8 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_2
					end

					if var_406_4.prefab_name ~= "" and arg_403_1.actors_[var_406_4.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_4.prefab_name].transform, "story_v_out_122541", "122541098", "story_v_out_122541.awb")

						arg_403_1:RecordAudio("122541098", var_406_9)
						arg_403_1:RecordAudio("122541098", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_122541", "122541098", "story_v_out_122541.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_122541", "122541098", "story_v_out_122541.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_3, arg_403_1.talkMaxDuration)

			if var_406_2 <= arg_403_1.time_ and arg_403_1.time_ < var_406_2 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_2) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_2 + var_406_10 and arg_403_1.time_ < var_406_2 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play122541099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 122541099
		arg_407_1.duration_ = 9.77

		local var_407_0 = {
			ja = 6.2,
			ko = 9.766,
			zh = 9.766
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play122541100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["10014ui_story"]) and arg_407_1.var_.characterEffect10014ui_story == nil then
				arg_407_1.var_.characterEffect10014ui_story = arg_407_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["10014ui_story"]) then
				if arg_407_1.var_.characterEffect10014ui_story and not isNil(arg_407_1.actors_["10014ui_story"]) then
					arg_407_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_407_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_0)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["10014ui_story"]) and arg_407_1.var_.characterEffect10014ui_story then
				arg_407_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_407_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_410_1 = 0
			local var_410_2 = 0.85

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_3 = arg_407_1:GetWordFromCfg(122541099)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_6 = 34 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_4) / 34)

				if (34 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_4) / 34)) > 0 and var_410_2 < var_410_6 then
					arg_407_1.talkMaxDuration = var_410_6

					if var_410_6 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_4
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541099", "story_v_out_122541.awb") ~= 0 then
					local var_410_7 = manager.audio:GetVoiceLength("story_v_out_122541", "122541099", "story_v_out_122541.awb") / 1000

					if var_410_7 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_1
					end

					if var_410_3.prefab_name ~= "" and arg_407_1.actors_[var_410_3.prefab_name] ~= nil then
						local var_410_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_3.prefab_name].transform, "story_v_out_122541", "122541099", "story_v_out_122541.awb")

						arg_407_1:RecordAudio("122541099", var_410_8)
						arg_407_1:RecordAudio("122541099", var_410_8)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_122541", "122541099", "story_v_out_122541.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_122541", "122541099", "story_v_out_122541.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_9 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_9 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_9

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_9 and arg_407_1.time_ < var_410_1 + var_410_9 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play122541100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 122541100
		arg_411_1.duration_ = 12.3

		local var_411_0 = {
			ja = 12.3,
			ko = 7,
			zh = 7
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
				arg_411_0:Play122541101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.725

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:GetWordFromCfg(122541100)
				local var_414_2 = arg_411_1:FormatText(var_414_1.content)

				arg_411_1.text_.text = var_414_2

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 29 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 29)

				if (29 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 29)) > 0 and var_414_0 < var_414_4 then
					arg_411_1.talkMaxDuration = var_414_4

					if var_414_4 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_4 + 0
					end
				end

				arg_411_1.text_.text = var_414_2
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541100", "story_v_out_122541.awb") ~= 0 then
					local var_414_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541100", "story_v_out_122541.awb") / 1000

					if var_414_5 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + 0
					end

					if var_414_1.prefab_name ~= "" and arg_411_1.actors_[var_414_1.prefab_name] ~= nil then
						local var_414_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_1.prefab_name].transform, "story_v_out_122541", "122541100", "story_v_out_122541.awb")

						arg_411_1:RecordAudio("122541100", var_414_6)
						arg_411_1:RecordAudio("122541100", var_414_6)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_122541", "122541100", "story_v_out_122541.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_122541", "122541100", "story_v_out_122541.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_7 and arg_411_1.time_ < 0 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play122541101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 122541101
		arg_415_1.duration_ = 15.27

		local var_415_0 = {
			ja = 15.266,
			ko = 10.133,
			zh = 10.133
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play122541102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.9

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_1 = arg_415_1:GetWordFromCfg(122541101)
				local var_418_2 = arg_415_1:FormatText(var_418_1.content)

				arg_415_1.text_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 36 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 36)

				if (36 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 36)) > 0 and var_418_0 < var_418_4 then
					arg_415_1.talkMaxDuration = var_418_4

					if var_418_4 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_4 + 0
					end
				end

				arg_415_1.text_.text = var_418_2
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541101", "story_v_out_122541.awb") ~= 0 then
					local var_418_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541101", "story_v_out_122541.awb") / 1000

					if var_418_5 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + 0
					end

					if var_418_1.prefab_name ~= "" and arg_415_1.actors_[var_418_1.prefab_name] ~= nil then
						local var_418_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_1.prefab_name].transform, "story_v_out_122541", "122541101", "story_v_out_122541.awb")

						arg_415_1:RecordAudio("122541101", var_418_6)
						arg_415_1:RecordAudio("122541101", var_418_6)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_122541", "122541101", "story_v_out_122541.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_122541", "122541101", "story_v_out_122541.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play122541102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 122541102
		arg_419_1.duration_ = 3

		local var_419_0 = {
			ja = 3,
			ko = 2.7,
			zh = 2.7
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play122541103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["10014ui_story"]) and arg_419_1.var_.characterEffect10014ui_story == nil then
				arg_419_1.var_.characterEffect10014ui_story = arg_419_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["10014ui_story"]) then
				if arg_419_1.var_.characterEffect10014ui_story and not isNil(arg_419_1.actors_["10014ui_story"]) then
					arg_419_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["10014ui_story"]) and arg_419_1.var_.characterEffect10014ui_story then
				arg_419_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_422_2 = 0
			local var_422_3 = 0.15

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(122541102)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 6 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 6)

				if (6 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 6)) > 0 and var_422_3 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541102", "story_v_out_122541.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_122541", "122541102", "story_v_out_122541.awb") / 1000

					if var_422_8 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_2
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_out_122541", "122541102", "story_v_out_122541.awb")

						arg_419_1:RecordAudio("122541102", var_422_9)
						arg_419_1:RecordAudio("122541102", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_122541", "122541102", "story_v_out_122541.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_122541", "122541102", "story_v_out_122541.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_3, arg_419_1.talkMaxDuration)

			if var_422_2 <= arg_419_1.time_ and arg_419_1.time_ < var_422_2 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_2) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_2 + var_422_10 and arg_419_1.time_ < var_422_2 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play122541103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 122541103
		arg_423_1.duration_ = 9

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play122541104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if arg_423_1.bgs_.ST12 == nil then
				local var_426_0 = Object.Instantiate(arg_423_1.paintGo_)

				var_426_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_426_0.name = "ST12"
				var_426_0.transform.parent = arg_423_1.stage_.transform
				var_426_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_423_1.bgs_.ST12 = var_426_0
			end

			if 2 < arg_423_1.time_ and arg_423_1.time_ <= 2 + arg_426_0 then
				local var_426_1 = arg_423_1.bgs_.ST12

				arg_423_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_426_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_2 = var_426_1:GetComponent("SpriteRenderer")

				if var_426_2 and var_426_2.sprite then
					local var_426_3 = 2 * (var_426_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_426_1.transform.localScale = Vector3.New(var_426_3 / var_426_2.sprite.bounds.size.y < var_426_3 * manager.ui.mainCameraCom_.aspect / var_426_2.sprite.bounds.size.x and var_426_3 * manager.ui.mainCameraCom_.aspect / var_426_2.sprite.bounds.size.x or var_426_3 / var_426_2.sprite.bounds.size.y, var_426_3 / var_426_2.sprite.bounds.size.y < var_426_3 * manager.ui.mainCameraCom_.aspect / var_426_2.sprite.bounds.size.x and var_426_3 * manager.ui.mainCameraCom_.aspect / var_426_2.sprite.bounds.size.x or var_426_3 / var_426_2.sprite.bounds.size.y, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "ST12" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_4 = 0

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_5 = 2

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_5 then
				local var_426_6 = Color.New(0, 0, 0)

				var_426_6.a = Mathf.Lerp(0, 1, (arg_423_1.time_ - var_426_4) / var_426_5)
				arg_423_1.mask_.color = var_426_6
			end

			if arg_423_1.time_ >= var_426_4 + var_426_5 and arg_423_1.time_ < var_426_4 + var_426_5 + arg_426_0 then
				local var_426_7 = Color.New(0, 0, 0)

				var_426_7.a = 1
				arg_423_1.mask_.color = var_426_7
			end

			local var_426_8 = 2

			if 2 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_9 = 2

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_9 then
				local var_426_10 = Color.New(0, 0, 0)

				var_426_10.a = Mathf.Lerp(1, 0, (arg_423_1.time_ - var_426_8) / var_426_9)
				arg_423_1.mask_.color = var_426_10
			end

			if arg_423_1.time_ >= var_426_8 + var_426_9 and arg_423_1.time_ < var_426_8 + var_426_9 + arg_426_0 then
				local var_426_11 = Color.New(0, 0, 0)

				arg_423_1.mask_.enabled = false
				var_426_11.a = 0
				arg_423_1.mask_.color = var_426_11
			end

			local var_426_12 = arg_423_1.actors_["10014ui_story"].transform

			if 1.96599999815226 < arg_423_1.time_ and arg_423_1.time_ <= 1.96599999815226 + arg_426_0 then
				arg_423_1.var_.moveOldPos10014ui_story = var_426_12.localPosition
			end

			local var_426_13 = 0.001

			if 1.96599999815226 <= arg_423_1.time_ and arg_423_1.time_ < 1.96599999815226 + var_426_13 then
				var_426_12.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_423_1.time_ - 1.96599999815226) / var_426_13)
				var_426_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_12.position).x, (manager.ui.mainCamera.transform.position - var_426_12.position).y, (manager.ui.mainCamera.transform.position - var_426_12.position).z)
				var_426_12.localEulerAngles.z = 0
				var_426_12.localEulerAngles.x = 0
				var_426_12.localEulerAngles = var_426_12.localEulerAngles
			end

			if arg_423_1.time_ >= 1.96599999815226 + var_426_13 and arg_423_1.time_ < 1.96599999815226 + var_426_13 + arg_426_0 then
				var_426_12.localPosition = Vector3.New(0, 100, 0)
				var_426_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_12.position).x, (manager.ui.mainCamera.transform.position - var_426_12.position).y, (manager.ui.mainCamera.transform.position - var_426_12.position).z)
				var_426_12.localEulerAngles.z = 0
				var_426_12.localEulerAngles.x = 0
				var_426_12.localEulerAngles = var_426_12.localEulerAngles
			end

			if arg_423_1.frameCnt_ <= 1 then
				arg_423_1.dialog_:SetActive(false)
			end

			local var_426_14 = 4
			local var_426_15 = 0.25

			if 4 < arg_423_1.time_ and arg_423_1.time_ <= var_426_14 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				arg_423_1.dialog_:SetActive(true)

				arg_423_1.dialogCg_.alpha = 0

				local var_426_16 = LeanTween.value(arg_423_1.dialog_, 0, 1, 0.3)

				var_426_16:setOnUpdate(LuaHelper.FloatAction(function(arg_427_0)
					arg_423_1.dialogCg_.alpha = arg_427_0
				end))
				var_426_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_423_1.dialog_)
					var_426_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_423_1.duration_ = arg_423_1.duration_ + 0.3

				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_17 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(122541103).content)

				arg_423_1.text_.text = var_426_17

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_19 = 10 <= 0 and var_426_15 or var_426_15 * (utf8.len(var_426_17) / 10)

				if (10 <= 0 and var_426_15 or var_426_15 * (utf8.len(var_426_17) / 10)) > 0 and var_426_15 < var_426_19 then
					arg_423_1.talkMaxDuration = var_426_19
					var_426_14 = var_426_14 + 0.3

					if var_426_19 + var_426_14 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_19 + var_426_14
					end
				end

				arg_423_1.text_.text = var_426_17
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_20 = var_426_14 + 0.3
			local var_426_21 = math.max(var_426_15, arg_423_1.talkMaxDuration)

			if var_426_14 + 0.3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_20 + var_426_21 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_20) / var_426_21

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_20 + var_426_21 and arg_423_1.time_ < var_426_20 + var_426_21 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play122541104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 122541104
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play122541105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 1.075

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(122541104).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 43 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 43)

				if (43 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 43)) > 0 and var_432_0 < var_432_3 then
					arg_429_1.talkMaxDuration = var_432_3

					if var_432_3 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_3 + 0
					end
				end

				arg_429_1.text_.text = var_432_1
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_4 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_4

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play122541105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 122541105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play122541106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 1.525

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(122541105).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 61 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 61)

				if (61 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 61)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play122541106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 122541106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play122541107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.225

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_1 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(122541106).content)

				arg_437_1.text_.text = var_440_1

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_3 = 9 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 9)

				if (9 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 9)) > 0 and var_440_0 < var_440_3 then
					arg_437_1.talkMaxDuration = var_440_3

					if var_440_3 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_3 + 0
					end
				end

				arg_437_1.text_.text = var_440_1
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_4 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_4 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_4

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_4 and arg_437_1.time_ < 0 + var_440_4 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play122541107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 122541107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play122541108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 1.075

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(122541107).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 43 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 43)

				if (43 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 43)) > 0 and var_444_0 < var_444_3 then
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
	Play122541108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 122541108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play122541109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 1.025

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(122541108).content)

				arg_445_1.text_.text = var_448_1

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_3 = 41 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 41)

				if (41 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 41)) > 0 and var_448_0 < var_448_3 then
					arg_445_1.talkMaxDuration = var_448_3

					if var_448_3 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_3 + 0
					end
				end

				arg_445_1.text_.text = var_448_1
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_4 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_4

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play122541109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 122541109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play122541110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 1.375

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(122541109).content)

				arg_449_1.text_.text = var_452_1

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_3 = 55 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 55)

				if (55 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 55)) > 0 and var_452_0 < var_452_3 then
					arg_449_1.talkMaxDuration = var_452_3

					if var_452_3 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_3 + 0
					end
				end

				arg_449_1.text_.text = var_452_1
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_4 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_4

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play122541110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 122541110
		arg_453_1.duration_ = 4.67

		local var_453_0 = {
			ja = 4.666,
			ko = 3.066,
			zh = 3.066
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
				arg_453_0:Play122541111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1029ui_story = arg_453_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1029ui_story"].transform.position).z)
				arg_453_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1029ui_story"].transform.localEulerAngles = arg_453_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, -1.09, -6.2)
				arg_453_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1029ui_story"].transform.position).z)
				arg_453_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1029ui_story"].transform.localEulerAngles = arg_453_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1029ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1029ui_story == nil then
				arg_453_1.var_.characterEffect1029ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1029ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1029ui_story then
				arg_453_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_456_4 = 0
			local var_456_5 = 0.325

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_4 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_6 = arg_453_1:GetWordFromCfg(122541110)
				local var_456_7 = arg_453_1:FormatText(var_456_6.content)

				arg_453_1.text_.text = var_456_7

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_9 = 13 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_7) / 13)

				if (13 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_7) / 13)) > 0 and var_456_5 < var_456_9 then
					arg_453_1.talkMaxDuration = var_456_9

					if var_456_9 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_9 + var_456_4
					end
				end

				arg_453_1.text_.text = var_456_7
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541110", "story_v_out_122541.awb") ~= 0 then
					local var_456_10 = manager.audio:GetVoiceLength("story_v_out_122541", "122541110", "story_v_out_122541.awb") / 1000

					if var_456_10 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_4
					end

					if var_456_6.prefab_name ~= "" and arg_453_1.actors_[var_456_6.prefab_name] ~= nil then
						local var_456_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_6.prefab_name].transform, "story_v_out_122541", "122541110", "story_v_out_122541.awb")

						arg_453_1:RecordAudio("122541110", var_456_11)
						arg_453_1:RecordAudio("122541110", var_456_11)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_122541", "122541110", "story_v_out_122541.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_122541", "122541110", "story_v_out_122541.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_12 = math.max(var_456_5, arg_453_1.talkMaxDuration)

			if var_456_4 <= arg_453_1.time_ and arg_453_1.time_ < var_456_4 + var_456_12 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_4) / var_456_12

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_4 + var_456_12 and arg_453_1.time_ < var_456_4 + var_456_12 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play122541111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 122541111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play122541112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1029ui_story"]) and arg_457_1.var_.characterEffect1029ui_story == nil then
				arg_457_1.var_.characterEffect1029ui_story = arg_457_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1029ui_story"]) then
				if arg_457_1.var_.characterEffect1029ui_story and not isNil(arg_457_1.actors_["1029ui_story"]) then
					arg_457_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_0)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1029ui_story"]) and arg_457_1.var_.characterEffect1029ui_story then
				arg_457_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_460_1 = 0
			local var_460_2 = 0.1

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

				local var_460_3 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(122541111).content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 4 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 4)

				if (4 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 4)) > 0 and var_460_2 < var_460_5 then
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
	Play122541112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 122541112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play122541113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 1.4

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(122541112).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 56 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 56)

				if (56 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 56)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play122541113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 122541113
		arg_465_1.duration_ = 9.83

		local var_465_0 = {
			ja = 9.833,
			ko = 6.866,
			zh = 6.866
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
				arg_465_0:Play122541114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1029ui_story = arg_465_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1029ui_story"].transform.position).z)
				arg_465_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1029ui_story"].transform.localEulerAngles = arg_465_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, -1.09, -6.2)
				arg_465_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1029ui_story"].transform.position).z)
				arg_465_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1029ui_story"].transform.localEulerAngles = arg_465_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["1029ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1029ui_story == nil then
				arg_465_1.var_.characterEffect1029ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect1029ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1029ui_story then
				arg_465_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_468_4 = 0
			local var_468_5 = 0.875

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_6 = arg_465_1:GetWordFromCfg(122541113)
				local var_468_7 = arg_465_1:FormatText(var_468_6.content)

				arg_465_1.text_.text = var_468_7

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_9 = 35 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 35)

				if (35 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 35)) > 0 and var_468_5 < var_468_9 then
					arg_465_1.talkMaxDuration = var_468_9

					if var_468_9 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_9 + var_468_4
					end
				end

				arg_465_1.text_.text = var_468_7
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541113", "story_v_out_122541.awb") ~= 0 then
					local var_468_10 = manager.audio:GetVoiceLength("story_v_out_122541", "122541113", "story_v_out_122541.awb") / 1000

					if var_468_10 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_10 + var_468_4
					end

					if var_468_6.prefab_name ~= "" and arg_465_1.actors_[var_468_6.prefab_name] ~= nil then
						local var_468_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_6.prefab_name].transform, "story_v_out_122541", "122541113", "story_v_out_122541.awb")

						arg_465_1:RecordAudio("122541113", var_468_11)
						arg_465_1:RecordAudio("122541113", var_468_11)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_122541", "122541113", "story_v_out_122541.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_122541", "122541113", "story_v_out_122541.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_12 = math.max(var_468_5, arg_465_1.talkMaxDuration)

			if var_468_4 <= arg_465_1.time_ and arg_465_1.time_ < var_468_4 + var_468_12 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_4) / var_468_12

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_4 + var_468_12 and arg_465_1.time_ < var_468_4 + var_468_12 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play122541114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 122541114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play122541115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1029ui_story"]) and arg_469_1.var_.characterEffect1029ui_story == nil then
				arg_469_1.var_.characterEffect1029ui_story = arg_469_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1029ui_story"]) then
				if arg_469_1.var_.characterEffect1029ui_story and not isNil(arg_469_1.actors_["1029ui_story"]) then
					arg_469_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1029ui_story"]) and arg_469_1.var_.characterEffect1029ui_story then
				arg_469_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.4

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(122541114).content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 16 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 16)

				if (16 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 16)) > 0 and var_472_2 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_6 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_6 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_6

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_6 and arg_469_1.time_ < var_472_1 + var_472_6 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play122541115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 122541115
		arg_473_1.duration_ = 3.43

		local var_473_0 = {
			ja = 3.166,
			ko = 3.433,
			zh = 3.433
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play122541116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["1029ui_story"]) and arg_473_1.var_.characterEffect1029ui_story == nil then
				arg_473_1.var_.characterEffect1029ui_story = arg_473_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["1029ui_story"]) then
				if arg_473_1.var_.characterEffect1029ui_story and not isNil(arg_473_1.actors_["1029ui_story"]) then
					arg_473_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["1029ui_story"]) and arg_473_1.var_.characterEffect1029ui_story then
				arg_473_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_476_2 = 0
			local var_476_3 = 0.25

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_4 = arg_473_1:GetWordFromCfg(122541115)
				local var_476_5 = arg_473_1:FormatText(var_476_4.content)

				arg_473_1.text_.text = var_476_5

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_7 = 10 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_5) / 10)

				if (10 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_5) / 10)) > 0 and var_476_3 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_5
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541115", "story_v_out_122541.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_out_122541", "122541115", "story_v_out_122541.awb") / 1000

					if var_476_8 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_2
					end

					if var_476_4.prefab_name ~= "" and arg_473_1.actors_[var_476_4.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_4.prefab_name].transform, "story_v_out_122541", "122541115", "story_v_out_122541.awb")

						arg_473_1:RecordAudio("122541115", var_476_9)
						arg_473_1:RecordAudio("122541115", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_122541", "122541115", "story_v_out_122541.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_122541", "122541115", "story_v_out_122541.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_10 and arg_473_1.time_ < var_476_2 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play122541116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 122541116
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play122541117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1029ui_story"]) and arg_477_1.var_.characterEffect1029ui_story == nil then
				arg_477_1.var_.characterEffect1029ui_story = arg_477_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1029ui_story"]) then
				if arg_477_1.var_.characterEffect1029ui_story and not isNil(arg_477_1.actors_["1029ui_story"]) then
					arg_477_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1029ui_story"]) and arg_477_1.var_.characterEffect1029ui_story then
				arg_477_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_480_1 = 0
			local var_480_2 = 0.775

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(122541116).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 31 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 31)

				if (31 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 31)) > 0 and var_480_2 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_1 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_1
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_6 = math.max(var_480_2, arg_477_1.talkMaxDuration)

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_6 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_1) / var_480_6

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_1 + var_480_6 and arg_477_1.time_ < var_480_1 + var_480_6 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play122541117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 122541117
		arg_481_1.duration_ = 5.33

		local var_481_0 = {
			ja = 5.333,
			ko = 4.133,
			zh = 4.133
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play122541118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1029ui_story"]) and arg_481_1.var_.characterEffect1029ui_story == nil then
				arg_481_1.var_.characterEffect1029ui_story = arg_481_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1029ui_story"]) then
				if arg_481_1.var_.characterEffect1029ui_story and not isNil(arg_481_1.actors_["1029ui_story"]) then
					arg_481_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1029ui_story"]) and arg_481_1.var_.characterEffect1029ui_story then
				arg_481_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_2")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_484_2 = 0
			local var_484_3 = 0.4

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_4 = arg_481_1:GetWordFromCfg(122541117)
				local var_484_5 = arg_481_1:FormatText(var_484_4.content)

				arg_481_1.text_.text = var_484_5

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_7 = 16 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_5) / 16)

				if (16 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_5) / 16)) > 0 and var_484_3 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_2
					end
				end

				arg_481_1.text_.text = var_484_5
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541117", "story_v_out_122541.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_out_122541", "122541117", "story_v_out_122541.awb") / 1000

					if var_484_8 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_2
					end

					if var_484_4.prefab_name ~= "" and arg_481_1.actors_[var_484_4.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_4.prefab_name].transform, "story_v_out_122541", "122541117", "story_v_out_122541.awb")

						arg_481_1:RecordAudio("122541117", var_484_9)
						arg_481_1:RecordAudio("122541117", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_122541", "122541117", "story_v_out_122541.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_122541", "122541117", "story_v_out_122541.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_3, arg_481_1.talkMaxDuration)

			if var_484_2 <= arg_481_1.time_ and arg_481_1.time_ < var_484_2 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_2) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_2 + var_484_10 and arg_481_1.time_ < var_484_2 + var_484_10 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play122541118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 122541118
		arg_485_1.duration_ = 7.97

		local var_485_0 = {
			ja = 6.433,
			ko = 7.966,
			zh = 7.966
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
				arg_485_0:Play122541119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_488_0 = 0
			local var_488_1 = 0.625

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_2 = arg_485_1:GetWordFromCfg(122541118)
				local var_488_3 = arg_485_1:FormatText(var_488_2.content)

				arg_485_1.text_.text = var_488_3

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 25 <= 0 and var_488_1 or var_488_1 * (utf8.len(var_488_3) / 25)

				if (25 <= 0 and var_488_1 or var_488_1 * (utf8.len(var_488_3) / 25)) > 0 and var_488_1 < var_488_5 then
					arg_485_1.talkMaxDuration = var_488_5

					if var_488_5 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_3
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541118", "story_v_out_122541.awb") ~= 0 then
					local var_488_6 = manager.audio:GetVoiceLength("story_v_out_122541", "122541118", "story_v_out_122541.awb") / 1000

					if var_488_6 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_0
					end

					if var_488_2.prefab_name ~= "" and arg_485_1.actors_[var_488_2.prefab_name] ~= nil then
						local var_488_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_2.prefab_name].transform, "story_v_out_122541", "122541118", "story_v_out_122541.awb")

						arg_485_1:RecordAudio("122541118", var_488_7)
						arg_485_1:RecordAudio("122541118", var_488_7)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_122541", "122541118", "story_v_out_122541.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_122541", "122541118", "story_v_out_122541.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_8 and arg_485_1.time_ < var_488_0 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play122541119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 122541119
		arg_489_1.duration_ = 0.5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"

			SetActive(arg_489_1.choicesGo_, true)

			for iter_490_0, iter_490_1 in ipairs(arg_489_1.choices_) do
				SetActive(iter_490_1.go, iter_490_0 <= 1)
			end

			arg_489_1.choices_[1].txt.text = arg_489_1:FormatText(StoryChoiceCfg[464].name)
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play122541120(arg_489_1)
			end

			arg_489_1:RecordChoiceLog(122541119, 464)
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1029ui_story"]) and arg_489_1.var_.characterEffect1029ui_story == nil then
				arg_489_1.var_.characterEffect1029ui_story = arg_489_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1029ui_story"]) then
				if arg_489_1.var_.characterEffect1029ui_story and not isNil(arg_489_1.actors_["1029ui_story"]) then
					arg_489_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1029ui_story"]) and arg_489_1.var_.characterEffect1029ui_story then
				arg_489_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play122541120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 122541120
		arg_493_1.duration_ = 2.57

		local var_493_0 = {
			ja = 2.566,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play122541121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(arg_493_1.actors_["1029ui_story"]) and arg_493_1.var_.characterEffect1029ui_story == nil then
				arg_493_1.var_.characterEffect1029ui_story = arg_493_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_0 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 and not isNil(arg_493_1.actors_["1029ui_story"]) then
				if arg_493_1.var_.characterEffect1029ui_story and not isNil(arg_493_1.actors_["1029ui_story"]) then
					arg_493_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 and not isNil(arg_493_1.actors_["1029ui_story"]) and arg_493_1.var_.characterEffect1029ui_story then
				arg_493_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_496_2 = 0
			local var_496_3 = 0.3

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_2 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_4 = arg_493_1:GetWordFromCfg(122541120)
				local var_496_5 = arg_493_1:FormatText(var_496_4.content)

				arg_493_1.text_.text = var_496_5

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_7 = 12 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_5) / 12)

				if (12 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_5) / 12)) > 0 and var_496_3 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_2 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_2
					end
				end

				arg_493_1.text_.text = var_496_5
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541120", "story_v_out_122541.awb") ~= 0 then
					local var_496_8 = manager.audio:GetVoiceLength("story_v_out_122541", "122541120", "story_v_out_122541.awb") / 1000

					if var_496_8 + var_496_2 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_8 + var_496_2
					end

					if var_496_4.prefab_name ~= "" and arg_493_1.actors_[var_496_4.prefab_name] ~= nil then
						local var_496_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_4.prefab_name].transform, "story_v_out_122541", "122541120", "story_v_out_122541.awb")

						arg_493_1:RecordAudio("122541120", var_496_9)
						arg_493_1:RecordAudio("122541120", var_496_9)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_122541", "122541120", "story_v_out_122541.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_122541", "122541120", "story_v_out_122541.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_10 = math.max(var_496_3, arg_493_1.talkMaxDuration)

			if var_496_2 <= arg_493_1.time_ and arg_493_1.time_ < var_496_2 + var_496_10 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_2) / var_496_10

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_2 + var_496_10 and arg_493_1.time_ < var_496_2 + var_496_10 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play122541121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 122541121
		arg_497_1.duration_ = 5.93

		local var_497_0 = {
			ja = 5.933,
			ko = 4.666,
			zh = 4.666
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play122541122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1029ui_story"]) and arg_497_1.var_.characterEffect1029ui_story == nil then
				arg_497_1.var_.characterEffect1029ui_story = arg_497_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1029ui_story"]) then
				if arg_497_1.var_.characterEffect1029ui_story and not isNil(arg_497_1.actors_["1029ui_story"]) then
					arg_497_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1029ui_story"]) and arg_497_1.var_.characterEffect1029ui_story then
				arg_497_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_500_2 = 0
			local var_500_3 = 0.575

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_2 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_4 = arg_497_1:GetWordFromCfg(122541121)
				local var_500_5 = arg_497_1:FormatText(var_500_4.content)

				arg_497_1.text_.text = var_500_5

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_7 = 23 <= 0 and var_500_3 or var_500_3 * (utf8.len(var_500_5) / 23)

				if (23 <= 0 and var_500_3 or var_500_3 * (utf8.len(var_500_5) / 23)) > 0 and var_500_3 < var_500_7 then
					arg_497_1.talkMaxDuration = var_500_7

					if var_500_7 + var_500_2 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_2
					end
				end

				arg_497_1.text_.text = var_500_5
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541121", "story_v_out_122541.awb") ~= 0 then
					local var_500_8 = manager.audio:GetVoiceLength("story_v_out_122541", "122541121", "story_v_out_122541.awb") / 1000

					if var_500_8 + var_500_2 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_2
					end

					if var_500_4.prefab_name ~= "" and arg_497_1.actors_[var_500_4.prefab_name] ~= nil then
						local var_500_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_4.prefab_name].transform, "story_v_out_122541", "122541121", "story_v_out_122541.awb")

						arg_497_1:RecordAudio("122541121", var_500_9)
						arg_497_1:RecordAudio("122541121", var_500_9)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_122541", "122541121", "story_v_out_122541.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_122541", "122541121", "story_v_out_122541.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_10 = math.max(var_500_3, arg_497_1.talkMaxDuration)

			if var_500_2 <= arg_497_1.time_ and arg_497_1.time_ < var_500_2 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_2) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_2 + var_500_10 and arg_497_1.time_ < var_500_2 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play122541122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 122541122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play122541123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.225

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(122541122).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 9 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 9)

				if (9 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 9)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play122541123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 122541123
		arg_505_1.duration_ = 12.4

		local var_505_0 = {
			ja = 12.4,
			ko = 8.766,
			zh = 8.766
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play122541124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.75

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:GetWordFromCfg(122541123)
				local var_508_2 = arg_505_1:FormatText(var_508_1.content)

				arg_505_1.text_.text = var_508_2

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 30 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 30)

				if (30 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_2) / 30)) > 0 and var_508_0 < var_508_4 then
					arg_505_1.talkMaxDuration = var_508_4

					if var_508_4 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_4 + 0
					end
				end

				arg_505_1.text_.text = var_508_2
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122541", "122541123", "story_v_out_122541.awb") ~= 0 then
					local var_508_5 = manager.audio:GetVoiceLength("story_v_out_122541", "122541123", "story_v_out_122541.awb") / 1000

					if var_508_5 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + 0
					end

					if var_508_1.prefab_name ~= "" and arg_505_1.actors_[var_508_1.prefab_name] ~= nil then
						local var_508_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_1.prefab_name].transform, "story_v_out_122541", "122541123", "story_v_out_122541.awb")

						arg_505_1:RecordAudio("122541123", var_508_6)
						arg_505_1:RecordAudio("122541123", var_508_6)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_122541", "122541123", "story_v_out_122541.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_122541", "122541123", "story_v_out_122541.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_7 and arg_505_1.time_ < 0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play122541124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 122541124
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play122541125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1029ui_story = arg_509_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_512_0 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 then
				arg_509_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_509_1.time_ - 0) / var_512_0)
				arg_509_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1029ui_story"].transform.position).z)
				arg_509_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1029ui_story"].transform.localEulerAngles = arg_509_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 then
				arg_509_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_509_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1029ui_story"].transform.position).z)
				arg_509_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1029ui_story"].transform.localEulerAngles = arg_509_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_512_1 = 0
			local var_512_2 = 0.275

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_3 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(122541124).content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 11 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 11)

				if (11 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 11)) > 0 and var_512_2 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_6 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_6 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_6

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_6 and arg_509_1.time_ < var_512_1 + var_512_6 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_509_1:InitPlayNodeList()
	end,
	Play122541125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 122541125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play122541126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.7

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(122541125).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 28 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 28)

				if (28 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 28)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play122541126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 122541126
		arg_517_1.duration_ = 2.23

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play122541127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.fswbg_:SetActive(true)
				arg_517_1.dialog_:SetActive(false)

				arg_517_1.fswtw_.percent = 0
				arg_517_1.fswt_.text = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(122541126).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.fswt_)

				arg_517_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_517_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_517_1.fswtw_:SetDirty()

				arg_517_1.typewritterCharCountI18N = 0

				SetActive(arg_517_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_517_1:ShowNextGo(false)
			end

			local var_520_0 = 0.5

			if 0.5 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.var_.oldValueTypewriter = arg_517_1.fswtw_.percent

				SetActive(arg_517_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_517_1:ShowNextGo(false)
			end

			local var_520_1 = 7
			local var_520_2 = 0.466666666666667
			local var_520_3, var_520_4 = arg_517_1:GetPercentByPara(arg_517_1:FormatText(arg_517_1:GetWordFromCfg(122541126).content), 1)

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0

				local var_520_5 = var_520_1 <= 0 and var_520_2 or var_520_2 * ((var_520_4 - arg_517_1.typewritterCharCountI18N) / var_520_1)

				if (var_520_1 <= 0 and var_520_2 or var_520_2 * ((var_520_4 - arg_517_1.typewritterCharCountI18N) / var_520_1)) > 0 and var_520_2 < var_520_5 then
					arg_517_1.talkMaxDuration = var_520_5

					if var_520_5 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + var_520_0
					end
				end
			end

			local var_520_6 = math.max(0.466666666666667, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_6 then
				arg_517_1.fswtw_.percent = Mathf.Lerp(arg_517_1.var_.oldValueTypewriter, var_520_3, (arg_517_1.time_ - var_520_0) / var_520_6)
				arg_517_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_517_1.fswtw_:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_6 and arg_517_1.time_ < var_520_0 + var_520_6 + arg_520_0 then
				arg_517_1.fswtw_.percent = var_520_3

				arg_517_1.fswtw_:SetDirty()
				arg_517_1:ShowNextGo(true)

				arg_517_1.typewritterCharCountI18N = var_520_4
			end

			if 0.5 < arg_517_1.time_ and arg_517_1.time_ <= 0.5 + arg_520_0 then
				local var_520_7 = arg_517_1.fswbg_.transform:Find("textbox/adapt/content") or arg_517_1.fswbg_.transform:Find("textbox/content")
				local var_520_8 = arg_517_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_520_9 = var_520_7:GetComponent("RectTransform")

				var_520_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_520_9.offsetMin = Vector2.New(0, 0)
				var_520_9.offsetMax = Vector2.New(0, 0)
			end

			local var_520_10 = 0

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_10 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_11 = 1

			if var_520_10 <= arg_517_1.time_ and arg_517_1.time_ < var_520_10 + var_520_11 then
				local var_520_12 = Color.New(1, 1, 1)

				var_520_12.a = Mathf.Lerp(1, 0, (arg_517_1.time_ - var_520_10) / var_520_11)
				arg_517_1.mask_.color = var_520_12
			end

			if arg_517_1.time_ >= var_520_10 + var_520_11 and arg_517_1.time_ < var_520_10 + var_520_11 + arg_520_0 then
				local var_520_13 = Color.New(1, 1, 1)

				arg_517_1.mask_.enabled = false
				var_520_13.a = 0
				arg_517_1.mask_.color = var_520_13
			end

			local var_520_14 = "XH0505"

			if arg_517_1.bgs_.XH0505 == nil then
				local var_520_15 = Object.Instantiate(arg_517_1.paintGo_)

				var_520_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_520_14)
				var_520_15.name = var_520_14
				var_520_15.transform.parent = arg_517_1.stage_.transform
				var_520_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_517_1.bgs_[var_520_14] = var_520_15
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				local var_520_16 = arg_517_1.bgs_.XH0505

				arg_517_1.bgs_.XH0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_520_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_520_17 = var_520_16:GetComponent("SpriteRenderer")

				if var_520_17 and var_520_17.sprite then
					local var_520_18 = 2 * (var_520_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_520_16.transform.localScale = Vector3.New(var_520_18 / var_520_17.sprite.bounds.size.y < var_520_18 * manager.ui.mainCameraCom_.aspect / var_520_17.sprite.bounds.size.x and var_520_18 * manager.ui.mainCameraCom_.aspect / var_520_17.sprite.bounds.size.x or var_520_18 / var_520_17.sprite.bounds.size.y, var_520_18 / var_520_17.sprite.bounds.size.y < var_520_18 * manager.ui.mainCameraCom_.aspect / var_520_17.sprite.bounds.size.x and var_520_18 * manager.ui.mainCameraCom_.aspect / var_520_17.sprite.bounds.size.x or var_520_18 / var_520_17.sprite.bounds.size.y, 0)
				end

				for iter_520_0, iter_520_1 in pairs(arg_517_1.bgs_) do
					if iter_520_0 ~= "XH0505" then
						iter_520_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play122541127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 122541127
		arg_521_1.duration_ = 1

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play122541128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.fswbg_:SetActive(true)
				arg_521_1.dialog_:SetActive(false)

				arg_521_1.fswtw_.percent = 0
				arg_521_1.fswt_.text = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(122541127).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.fswt_)

				arg_521_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_521_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_521_1.fswtw_:SetDirty()

				arg_521_1.typewritterCharCountI18N = 0

				SetActive(arg_521_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_521_1:ShowNextGo(false)
			end

			local var_524_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.var_.oldValueTypewriter = arg_521_1.fswtw_.percent

				SetActive(arg_521_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_521_1:ShowNextGo(false)
			end

			local var_524_1 = 11
			local var_524_2 = 0.733333333333333
			local var_524_3, var_524_4 = arg_521_1:GetPercentByPara(arg_521_1:FormatText(arg_521_1:GetWordFromCfg(122541127).content), 1)

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0

				local var_524_5 = var_524_1 <= 0 and var_524_2 or var_524_2 * ((var_524_4 - arg_521_1.typewritterCharCountI18N) / var_524_1)

				if (var_524_1 <= 0 and var_524_2 or var_524_2 * ((var_524_4 - arg_521_1.typewritterCharCountI18N) / var_524_1)) > 0 and var_524_2 < var_524_5 then
					arg_521_1.talkMaxDuration = var_524_5

					if var_524_5 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + var_524_0
					end
				end
			end

			local var_524_6 = math.max(0.733333333333333, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_6 then
				arg_521_1.fswtw_.percent = Mathf.Lerp(arg_521_1.var_.oldValueTypewriter, var_524_3, (arg_521_1.time_ - var_524_0) / var_524_6)
				arg_521_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_521_1.fswtw_:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_6 and arg_521_1.time_ < var_524_0 + var_524_6 + arg_524_0 then
				arg_521_1.fswtw_.percent = var_524_3

				arg_521_1.fswtw_:SetDirty()
				arg_521_1:ShowNextGo(true)

				arg_521_1.typewritterCharCountI18N = var_524_4
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play122541128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 122541128
		arg_525_1.duration_ = 2.63

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play122541129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.fswbg_:SetActive(true)
				arg_525_1.dialog_:SetActive(false)

				arg_525_1.fswtw_.percent = 0
				arg_525_1.fswt_.text = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(122541128).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.fswt_)

				arg_525_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_525_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_525_1.fswtw_:SetDirty()

				arg_525_1.typewritterCharCountI18N = 0

				SetActive(arg_525_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_525_1:ShowNextGo(false)
			end

			local var_528_0 = 1

			if 1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.var_.oldValueTypewriter = arg_525_1.fswtw_.percent

				SetActive(arg_525_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_525_1:ShowNextGo(false)
			end

			local var_528_1 = 14
			local var_528_2 = 0.933333333333333
			local var_528_3, var_528_4 = arg_525_1:GetPercentByPara(arg_525_1:FormatText(arg_525_1:GetWordFromCfg(122541128).content), 1)

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				local var_528_5 = var_528_1 <= 0 and var_528_2 or var_528_2 * ((var_528_4 - arg_525_1.typewritterCharCountI18N) / var_528_1)

				if (var_528_1 <= 0 and var_528_2 or var_528_2 * ((var_528_4 - arg_525_1.typewritterCharCountI18N) / var_528_1)) > 0 and var_528_2 < var_528_5 then
					arg_525_1.talkMaxDuration = var_528_5

					if var_528_5 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + var_528_0
					end
				end
			end

			local var_528_6 = math.max(0.933333333333333, arg_525_1.talkMaxDuration)

			if var_528_0 <= arg_525_1.time_ and arg_525_1.time_ < var_528_0 + var_528_6 then
				arg_525_1.fswtw_.percent = Mathf.Lerp(arg_525_1.var_.oldValueTypewriter, var_528_3, (arg_525_1.time_ - var_528_0) / var_528_6)
				arg_525_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_525_1.fswtw_:SetDirty()
			end

			if arg_525_1.time_ >= var_528_0 + var_528_6 and arg_525_1.time_ < var_528_0 + var_528_6 + arg_528_0 then
				arg_525_1.fswtw_.percent = var_528_3

				arg_525_1.fswtw_:SetDirty()
				arg_525_1:ShowNextGo(true)

				arg_525_1.typewritterCharCountI18N = var_528_4
			end

			local var_528_7 = 0

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_7 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_8 = 1

			if var_528_7 <= arg_525_1.time_ and arg_525_1.time_ < var_528_7 + var_528_8 then
				local var_528_9 = Color.New(1, 1, 1)

				var_528_9.a = Mathf.Lerp(1, 0, (arg_525_1.time_ - var_528_7) / var_528_8)
				arg_525_1.mask_.color = var_528_9
			end

			if arg_525_1.time_ >= var_528_7 + var_528_8 and arg_525_1.time_ < var_528_7 + var_528_8 + arg_528_0 then
				local var_528_10 = Color.New(1, 1, 1)

				arg_525_1.mask_.enabled = false
				var_528_10.a = 0
				arg_525_1.mask_.color = var_528_10
			end

			local var_528_11 = "XH0201"

			if arg_525_1.bgs_.XH0201 == nil then
				local var_528_12 = Object.Instantiate(arg_525_1.paintGo_)

				var_528_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_528_11)
				var_528_12.name = var_528_11
				var_528_12.transform.parent = arg_525_1.stage_.transform
				var_528_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.bgs_[var_528_11] = var_528_12
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				local var_528_13 = arg_525_1.bgs_.XH0201

				arg_525_1.bgs_.XH0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_528_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_528_14 = var_528_13:GetComponent("SpriteRenderer")

				if var_528_14 and var_528_14.sprite then
					local var_528_15 = 2 * (var_528_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_528_13.transform.localScale = Vector3.New(var_528_15 / var_528_14.sprite.bounds.size.y < var_528_15 * manager.ui.mainCameraCom_.aspect / var_528_14.sprite.bounds.size.x and var_528_15 * manager.ui.mainCameraCom_.aspect / var_528_14.sprite.bounds.size.x or var_528_15 / var_528_14.sprite.bounds.size.y, var_528_15 / var_528_14.sprite.bounds.size.y < var_528_15 * manager.ui.mainCameraCom_.aspect / var_528_14.sprite.bounds.size.x and var_528_15 * manager.ui.mainCameraCom_.aspect / var_528_14.sprite.bounds.size.x or var_528_15 / var_528_14.sprite.bounds.size.y, 0)
				end

				for iter_528_0, iter_528_1 in pairs(arg_525_1.bgs_) do
					if iter_528_0 ~= "XH0201" then
						iter_528_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play122541129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 122541129
		arg_529_1.duration_ = 1

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play122541130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.fswbg_:SetActive(true)
				arg_529_1.dialog_:SetActive(false)

				arg_529_1.fswtw_.percent = 0
				arg_529_1.fswt_.text = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(122541129).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.fswt_)

				arg_529_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_529_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_529_1.fswtw_:SetDirty()

				arg_529_1.typewritterCharCountI18N = 0

				SetActive(arg_529_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_529_1:ShowNextGo(false)
			end

			local var_532_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.var_.oldValueTypewriter = arg_529_1.fswtw_.percent

				SetActive(arg_529_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_529_1:ShowNextGo(false)
			end

			local var_532_1 = 13
			local var_532_2 = 0.866666666666667
			local var_532_3, var_532_4 = arg_529_1:GetPercentByPara(arg_529_1:FormatText(arg_529_1:GetWordFromCfg(122541129).content), 1)

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0

				local var_532_5 = var_532_1 <= 0 and var_532_2 or var_532_2 * ((var_532_4 - arg_529_1.typewritterCharCountI18N) / var_532_1)

				if (var_532_1 <= 0 and var_532_2 or var_532_2 * ((var_532_4 - arg_529_1.typewritterCharCountI18N) / var_532_1)) > 0 and var_532_2 < var_532_5 then
					arg_529_1.talkMaxDuration = var_532_5

					if var_532_5 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + var_532_0
					end
				end
			end

			local var_532_6 = math.max(0.866666666666667, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_6 then
				arg_529_1.fswtw_.percent = Mathf.Lerp(arg_529_1.var_.oldValueTypewriter, var_532_3, (arg_529_1.time_ - var_532_0) / var_532_6)
				arg_529_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_529_1.fswtw_:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_6 and arg_529_1.time_ < var_532_0 + var_532_6 + arg_532_0 then
				arg_529_1.fswtw_.percent = var_532_3

				arg_529_1.fswtw_:SetDirty()
				arg_529_1:ShowNextGo(true)

				arg_529_1.typewritterCharCountI18N = var_532_4
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play122541130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 122541130
		arg_533_1.duration_ = 3.27

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play122541131(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.mask_.enabled = true
				arg_533_1.mask_.raycastTarget = true

				arg_533_1:SetGaussion(false)
			end

			local var_536_0 = 2

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 then
				local var_536_1 = Color.New(1, 1, 1)

				var_536_1.a = Mathf.Lerp(1, 0, (arg_533_1.time_ - 0) / var_536_0)
				arg_533_1.mask_.color = var_536_1
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 then
				local var_536_2 = Color.New(1, 1, 1)

				arg_533_1.mask_.enabled = false
				var_536_2.a = 0
				arg_533_1.mask_.color = var_536_2
			end

			local var_536_3 = "ST03"

			if arg_533_1.bgs_.ST03 == nil then
				local var_536_4 = Object.Instantiate(arg_533_1.paintGo_)

				var_536_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_536_3)
				var_536_4.name = var_536_3
				var_536_4.transform.parent = arg_533_1.stage_.transform
				var_536_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_533_1.bgs_[var_536_3] = var_536_4
			end

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				local var_536_5 = arg_533_1.bgs_.ST03

				arg_533_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_536_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_536_6 = var_536_5:GetComponent("SpriteRenderer")

				if var_536_6 and var_536_6.sprite then
					local var_536_7 = 2 * (var_536_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_536_5.transform.localScale = Vector3.New(var_536_7 / var_536_6.sprite.bounds.size.y < var_536_7 * manager.ui.mainCameraCom_.aspect / var_536_6.sprite.bounds.size.x and var_536_7 * manager.ui.mainCameraCom_.aspect / var_536_6.sprite.bounds.size.x or var_536_7 / var_536_6.sprite.bounds.size.y, var_536_7 / var_536_6.sprite.bounds.size.y < var_536_7 * manager.ui.mainCameraCom_.aspect / var_536_6.sprite.bounds.size.x and var_536_7 * manager.ui.mainCameraCom_.aspect / var_536_6.sprite.bounds.size.x or var_536_7 / var_536_6.sprite.bounds.size.y, 0)
				end

				for iter_536_0, iter_536_1 in pairs(arg_533_1.bgs_) do
					if iter_536_0 ~= "ST03" then
						iter_536_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.fswbg_:SetActive(true)
				arg_533_1.dialog_:SetActive(false)

				arg_533_1.fswtw_.percent = 0
				arg_533_1.fswt_.text = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(122541130).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.fswt_)

				arg_533_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_533_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_533_1.fswtw_:SetDirty()

				arg_533_1.typewritterCharCountI18N = 0

				SetActive(arg_533_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_533_1:ShowNextGo(false)
			end

			local var_536_8 = 1

			if 1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_8 + arg_536_0 then
				arg_533_1.var_.oldValueTypewriter = arg_533_1.fswtw_.percent

				SetActive(arg_533_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_533_1:ShowNextGo(false)
			end

			local var_536_9 = 22
			local var_536_10 = 1.46666666666667
			local var_536_11, var_536_12 = arg_533_1:GetPercentByPara(arg_533_1:FormatText(arg_533_1:GetWordFromCfg(122541130).content), 1)

			if var_536_8 < arg_533_1.time_ and arg_533_1.time_ <= var_536_8 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0

				local var_536_13 = var_536_9 <= 0 and var_536_10 or var_536_10 * ((var_536_12 - arg_533_1.typewritterCharCountI18N) / var_536_9)

				if (var_536_9 <= 0 and var_536_10 or var_536_10 * ((var_536_12 - arg_533_1.typewritterCharCountI18N) / var_536_9)) > 0 and var_536_10 < var_536_13 then
					arg_533_1.talkMaxDuration = var_536_13

					if var_536_13 + var_536_8 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_13 + var_536_8
					end
				end
			end

			local var_536_14 = math.max(1.46666666666667, arg_533_1.talkMaxDuration)

			if var_536_8 <= arg_533_1.time_ and arg_533_1.time_ < var_536_8 + var_536_14 then
				arg_533_1.fswtw_.percent = Mathf.Lerp(arg_533_1.var_.oldValueTypewriter, var_536_11, (arg_533_1.time_ - var_536_8) / var_536_14)
				arg_533_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_533_1.fswtw_:SetDirty()
			end

			if arg_533_1.time_ >= var_536_8 + var_536_14 and arg_533_1.time_ < var_536_8 + var_536_14 + arg_536_0 then
				arg_533_1.fswtw_.percent = var_536_11

				arg_533_1.fswtw_:SetDirty()
				arg_533_1:ShowNextGo(true)

				arg_533_1.typewritterCharCountI18N = var_536_12
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play122541131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 122541131
		arg_537_1.duration_ = 9

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play122541132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.mask_.enabled = true
				arg_537_1.mask_.raycastTarget = true

				arg_537_1:SetGaussion(false)
			end

			local var_540_0 = 2

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 then
				local var_540_1 = Color.New(0, 0, 0)

				var_540_1.a = Mathf.Lerp(0, 1, (arg_537_1.time_ - 0) / var_540_0)
				arg_537_1.mask_.color = var_540_1
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 then
				local var_540_2 = Color.New(0, 0, 0)

				var_540_2.a = 1
				arg_537_1.mask_.color = var_540_2
			end

			local var_540_3 = 2

			if 2 < arg_537_1.time_ and arg_537_1.time_ <= var_540_3 + arg_540_0 then
				arg_537_1.mask_.enabled = true
				arg_537_1.mask_.raycastTarget = true

				arg_537_1:SetGaussion(false)
			end

			local var_540_4 = 2

			if var_540_3 <= arg_537_1.time_ and arg_537_1.time_ < var_540_3 + var_540_4 then
				local var_540_5 = Color.New(0, 0, 0)

				var_540_5.a = Mathf.Lerp(1, 0, (arg_537_1.time_ - var_540_3) / var_540_4)
				arg_537_1.mask_.color = var_540_5
			end

			if arg_537_1.time_ >= var_540_3 + var_540_4 and arg_537_1.time_ < var_540_3 + var_540_4 + arg_540_0 then
				local var_540_6 = Color.New(0, 0, 0)

				arg_537_1.mask_.enabled = false
				var_540_6.a = 0
				arg_537_1.mask_.color = var_540_6
			end

			if 2 < arg_537_1.time_ and arg_537_1.time_ <= 2 + arg_540_0 then
				local var_540_7 = arg_537_1.bgs_.ST12

				arg_537_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_540_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_540_8 = var_540_7:GetComponent("SpriteRenderer")

				if var_540_8 and var_540_8.sprite then
					local var_540_9 = 2 * (var_540_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_540_7.transform.localScale = Vector3.New(var_540_9 / var_540_8.sprite.bounds.size.y < var_540_9 * manager.ui.mainCameraCom_.aspect / var_540_8.sprite.bounds.size.x and var_540_9 * manager.ui.mainCameraCom_.aspect / var_540_8.sprite.bounds.size.x or var_540_9 / var_540_8.sprite.bounds.size.y, var_540_9 / var_540_8.sprite.bounds.size.y < var_540_9 * manager.ui.mainCameraCom_.aspect / var_540_8.sprite.bounds.size.x and var_540_9 * manager.ui.mainCameraCom_.aspect / var_540_8.sprite.bounds.size.x or var_540_9 / var_540_8.sprite.bounds.size.y, 0)
				end

				for iter_540_0, iter_540_1 in pairs(arg_537_1.bgs_) do
					if iter_540_0 ~= "ST12" then
						iter_540_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.98333333333333 < arg_537_1.time_ and arg_537_1.time_ <= 1.98333333333333 + arg_540_0 then
				arg_537_1.fswbg_:SetActive(false)
				arg_537_1.dialog_:SetActive(false)
				SetActive(arg_537_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_537_1:ShowNextGo(false)
			end

			if arg_537_1.frameCnt_ <= 1 then
				arg_537_1.dialog_:SetActive(false)
			end

			local var_540_10 = 4
			local var_540_11 = 0.2

			if 4 < arg_537_1.time_ and arg_537_1.time_ <= var_540_10 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0

				arg_537_1.dialog_:SetActive(true)

				arg_537_1.dialogCg_.alpha = 0

				local var_540_12 = LeanTween.value(arg_537_1.dialog_, 0, 1, 0.3)

				var_540_12:setOnUpdate(LuaHelper.FloatAction(function(arg_541_0)
					arg_537_1.dialogCg_.alpha = arg_541_0
				end))
				var_540_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_537_1.dialog_)
					var_540_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_537_1.duration_ = arg_537_1.duration_ + 0.3

				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_13 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(122541131).content)

				arg_537_1.text_.text = var_540_13

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_15 = 8 <= 0 and var_540_11 or var_540_11 * (utf8.len(var_540_13) / 8)

				if (8 <= 0 and var_540_11 or var_540_11 * (utf8.len(var_540_13) / 8)) > 0 and var_540_11 < var_540_15 then
					arg_537_1.talkMaxDuration = var_540_15
					var_540_10 = var_540_10 + 0.3

					if var_540_15 + var_540_10 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_15 + var_540_10
					end
				end

				arg_537_1.text_.text = var_540_13
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_16 = var_540_10 + 0.3
			local var_540_17 = math.max(var_540_11, arg_537_1.talkMaxDuration)

			if var_540_10 + 0.3 <= arg_537_1.time_ and arg_537_1.time_ < var_540_16 + var_540_17 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_16) / var_540_17

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_16 + var_540_17 and arg_537_1.time_ < var_540_16 + var_540_17 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play122541132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 122541132
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play122541133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.125

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_1 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(122541132).content)

				arg_543_1.text_.text = var_546_1

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_3 = 5 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 5)

				if (5 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 5)) > 0 and var_546_0 < var_546_3 then
					arg_543_1.talkMaxDuration = var_546_3

					if var_546_3 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_3 + 0
					end
				end

				arg_543_1.text_.text = var_546_1
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_4 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_4

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play122541133 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 122541133
		arg_547_1.duration_ = 12.2

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
			arg_547_1.auto_ = false
		end

		function arg_547_1.playNext_(arg_549_0)
			arg_547_1.onStoryFinished_()
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if arg_547_1.bgs_.XH0607 == nil then
				local var_550_0 = Object.Instantiate(arg_547_1.paintGo_)

				var_550_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0607")
				var_550_0.name = "XH0607"
				var_550_0.transform.parent = arg_547_1.stage_.transform
				var_550_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_547_1.bgs_.XH0607 = var_550_0
			end

			if 2 < arg_547_1.time_ and arg_547_1.time_ <= 2 + arg_550_0 then
				local var_550_1 = arg_547_1.bgs_.XH0607

				arg_547_1.bgs_.XH0607.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_550_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_550_2 = var_550_1:GetComponent("SpriteRenderer")

				if var_550_2 and var_550_2.sprite then
					local var_550_3 = 2 * (var_550_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_550_1.transform.localScale = Vector3.New(var_550_3 / var_550_2.sprite.bounds.size.y < var_550_3 * manager.ui.mainCameraCom_.aspect / var_550_2.sprite.bounds.size.x and var_550_3 * manager.ui.mainCameraCom_.aspect / var_550_2.sprite.bounds.size.x or var_550_3 / var_550_2.sprite.bounds.size.y, var_550_3 / var_550_2.sprite.bounds.size.y < var_550_3 * manager.ui.mainCameraCom_.aspect / var_550_2.sprite.bounds.size.x and var_550_3 * manager.ui.mainCameraCom_.aspect / var_550_2.sprite.bounds.size.x or var_550_3 / var_550_2.sprite.bounds.size.y, 0)
				end

				for iter_550_0, iter_550_1 in pairs(arg_547_1.bgs_) do
					if iter_550_0 ~= "XH0607" then
						iter_550_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_550_4 = 0

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_4 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_5 = 2

			if var_550_4 <= arg_547_1.time_ and arg_547_1.time_ < var_550_4 + var_550_5 then
				local var_550_6 = Color.New(0, 0, 0)

				var_550_6.a = Mathf.Lerp(0, 1, (arg_547_1.time_ - var_550_4) / var_550_5)
				arg_547_1.mask_.color = var_550_6
			end

			if arg_547_1.time_ >= var_550_4 + var_550_5 and arg_547_1.time_ < var_550_4 + var_550_5 + arg_550_0 then
				local var_550_7 = Color.New(0, 0, 0)

				var_550_7.a = 1
				arg_547_1.mask_.color = var_550_7
			end

			local var_550_8 = 2

			if 2 < arg_547_1.time_ and arg_547_1.time_ <= var_550_8 + arg_550_0 then
				arg_547_1.mask_.enabled = true
				arg_547_1.mask_.raycastTarget = true

				arg_547_1:SetGaussion(false)
			end

			local var_550_9 = 5

			if var_550_8 <= arg_547_1.time_ and arg_547_1.time_ < var_550_8 + var_550_9 then
				local var_550_10 = Color.New(0, 0, 0)

				var_550_10.a = Mathf.Lerp(1, 0, (arg_547_1.time_ - var_550_8) / var_550_9)
				arg_547_1.mask_.color = var_550_10
			end

			if arg_547_1.time_ >= var_550_8 + var_550_9 and arg_547_1.time_ < var_550_8 + var_550_9 + arg_550_0 then
				local var_550_11 = Color.New(0, 0, 0)

				arg_547_1.mask_.enabled = false
				var_550_11.a = 0
				arg_547_1.mask_.color = var_550_11
			end

			if 1.9 < arg_547_1.time_ and arg_547_1.time_ <= 1.9 + arg_550_0 then
				arg_547_1.fswbg_:SetActive(false)
				arg_547_1.dialog_:SetActive(false)
				SetActive(arg_547_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_547_1:ShowNextGo(false)
			end

			local var_550_12 = arg_547_1.bgs_.XH0607.transform

			if 2 < arg_547_1.time_ and arg_547_1.time_ <= 2 + arg_550_0 then
				arg_547_1.var_.moveOldPosXH0607 = var_550_12.localPosition
			end

			local var_550_13 = 0.001

			if 2 <= arg_547_1.time_ and arg_547_1.time_ < 2 + var_550_13 then
				var_550_12.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPosXH0607, Vector3.New(0, 1, 9), (arg_547_1.time_ - 2) / var_550_13)
			end

			if arg_547_1.time_ >= 2 + var_550_13 and arg_547_1.time_ < 2 + var_550_13 + arg_550_0 then
				var_550_12.localPosition = Vector3.New(0, 1, 9)
			end

			local var_550_14 = arg_547_1.bgs_.XH0607.transform

			if 2.01667 < arg_547_1.time_ and arg_547_1.time_ <= 2.01667 + arg_550_0 then
				arg_547_1.var_.moveOldPosXH0607 = var_550_14.localPosition
			end

			local var_550_15 = 8

			if 2.01667 <= arg_547_1.time_ and arg_547_1.time_ < 2.01667 + var_550_15 then
				var_550_14.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPosXH0607, Vector3.New(0, 1, 10), (arg_547_1.time_ - 2.01667) / var_550_15)
			end

			if arg_547_1.time_ >= 2.01667 + var_550_15 and arg_547_1.time_ < 2.01667 + var_550_15 + arg_550_0 then
				var_550_14.localPosition = Vector3.New(0, 1, 10)
			end

			if 8.01667 < arg_547_1.time_ and arg_547_1.time_ <= 8.01667 + arg_550_0 then
				local var_550_16 = arg_547_1.bgs_.XH0607:GetComponent("SpriteRenderer")

				if var_550_16 then
					arg_547_1.var_.alphaOldValueXH0607 = var_550_16.color.a
					arg_547_1.var_.alphaMatValueXH0607 = var_550_16
				end

				arg_547_1.var_.alphaOldValueXH0607 = 1
			end

			local var_550_17 = 2

			if 8.01667 <= arg_547_1.time_ and arg_547_1.time_ < 8.01667 + var_550_17 then
				if arg_547_1.var_.alphaMatValueXH0607 then
					arg_547_1.var_.alphaMatValueXH0607.color.a = Mathf.Lerp(arg_547_1.var_.alphaOldValueXH0607, 0, (arg_547_1.time_ - 8.01667) / var_550_17)
					arg_547_1.var_.alphaMatValueXH0607.color = arg_547_1.var_.alphaMatValueXH0607.color
				end
			end

			if arg_547_1.time_ >= 8.01667 + var_550_17 and arg_547_1.time_ < 8.01667 + var_550_17 + arg_550_0 and arg_547_1.var_.alphaMatValueXH0607 then
				arg_547_1.var_.alphaMatValueXH0607.color.a = 0
				arg_547_1.var_.alphaMatValueXH0607.color = arg_547_1.var_.alphaMatValueXH0607.color
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_bubble", "")
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_550_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_547_1.bgmTxt_.text ~= var_550_21 and arg_547_1.bgmTxt_.text ~= "" then
						if arg_547_1.bgmTxt2_.text ~= "" then
							arg_547_1.bgmTxt_.text = arg_547_1.bgmTxt2_.text
						end

						arg_547_1.bgmTxt2_.text = var_550_21

						arg_547_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_547_1.bgmTxt_.text = var_550_21
						arg_547_1.bgmTxt2_.text = var_550_21
					end

					if arg_547_1.bgmTimer then
						arg_547_1.bgmTimer:Stop()

						arg_547_1.bgmTimer = nil
					end

					if arg_547_1.settingData.show_music_name == 1 then
						arg_547_1.musicController:SetSelectedState("show")
						arg_547_1.musicAnimator_:Play("open", 0, 0)

						if arg_547_1.settingData.music_time ~= 0 then
							arg_547_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_547_1.settingData.music_time), function()
								if arg_547_1 == nil or isNil(arg_547_1.bgmTxt_) then
									return
								end

								arg_547_1.musicController:SetSelectedState("hide")
								arg_547_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0607",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0607",
				changeDisplayLayer = false,
				needEase = false,
				duration = 8,
				className = "StoryMoveNode",
				startTime = 2.01667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0606",
		"TextureConfig/Background/I05",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/XH0505",
		"TextureConfig/Background/XH0201",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/XH0607"
	},
	voices = {
		"story_v_out_122541.awb"
	}
}
