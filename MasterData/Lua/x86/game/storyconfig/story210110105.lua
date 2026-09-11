return {
	Play1101105001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1101105001
		arg_1_1.duration_ = 6.67

		local var_1_0 = {
			zh = 6.666,
			ja = 6.1
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
				arg_1_0:Play1101105002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D999 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D999")
				var_4_0.name = "D999"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D999 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D999

				arg_1_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D999" then
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

			if 0.533333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.533333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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
			local var_4_15 = 0.525

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(1101105001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 21 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 21)

				if (21 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 21)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb")

						arg_1_1:RecordAudio("1101105001", var_4_22)
						arg_1_1:RecordAudio("1101105001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105001", "story_v_side_new_1101105.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1101105002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1101105002
		arg_9_1.duration_ = 4.43

		local var_9_0 = {
			zh = 4.2,
			ja = 4.433
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1101105003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.725

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(1101105002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 29 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 29)

				if (29 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 29)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb")

						arg_9_1:RecordAudio("1101105002", var_12_6)
						arg_9_1:RecordAudio("1101105002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105002", "story_v_side_new_1101105.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1101105003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1101105003
		arg_13_1.duration_ = 9

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1101105004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.bgs_.ST01_blur == nil then
				local var_16_0 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01_blur")
				var_16_0.name = "ST01_blur"
				var_16_0.transform.parent = arg_13_1.stage_.transform
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_.ST01_blur = var_16_0
			end

			if 2 < arg_13_1.time_ and arg_13_1.time_ <= 2 + arg_16_0 then
				local var_16_1 = arg_13_1.bgs_.ST01_blur

				arg_13_1.bgs_.ST01_blur.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_16_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_2 = var_16_1:GetComponent("SpriteRenderer")

				if var_16_2 and var_16_2.sprite then
					local var_16_3 = 2 * (var_16_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_16_1.transform.localScale = Vector3.New(var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "ST01_blur" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_4 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_5 = 2

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_5 then
				local var_16_6 = Color.New(0, 0, 0)

				var_16_6.a = Mathf.Lerp(0, 1, (arg_13_1.time_ - var_16_4) / var_16_5)
				arg_13_1.mask_.color = var_16_6
			end

			if arg_13_1.time_ >= var_16_4 + var_16_5 and arg_13_1.time_ < var_16_4 + var_16_5 + arg_16_0 then
				local var_16_7 = Color.New(0, 0, 0)

				var_16_7.a = 1
				arg_13_1.mask_.color = var_16_7
			end

			local var_16_8 = 2

			if 2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_9 = 2

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 then
				local var_16_10 = Color.New(0, 0, 0)

				var_16_10.a = Mathf.Lerp(1, 0, (arg_13_1.time_ - var_16_8) / var_16_9)
				arg_13_1.mask_.color = var_16_10
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 then
				local var_16_11 = Color.New(0, 0, 0)

				arg_13_1.mask_.enabled = false
				var_16_11.a = 0
				arg_13_1.mask_.color = var_16_11
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_12 = 4
			local var_16_13 = 0.825

			if 4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_14 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_14:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1101105003).content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 33 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 33)

				if (33 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 33)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17
					var_16_12 = var_16_12 + 0.3

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = var_16_12 + 0.3
			local var_16_19 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_18 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_18) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_18 + var_16_19 and arg_13_1.time_ < var_16_18 + var_16_19 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1101105004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 1101105004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play1101105005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.bgs_.ST01 == nil then
				local var_22_0 = Object.Instantiate(arg_19_1.blurPaintGo_)

				var_22_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_22_0.name = "ST01"
				var_22_0.transform.parent = arg_19_1.stage_.transform
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.bgs_.ST01 = var_22_0
			end

			local var_22_1 = 0
			local var_22_2 = arg_19_1.bgs_.ST01

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				var_22_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_22_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_22_3 = var_22_2:GetComponent("SpriteRenderer")

				if var_22_3 and var_22_3.sprite then
					local var_22_4 = 2 * (var_22_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_22_2.transform.localScale = Vector3.New(var_22_4 / var_22_3.sprite.bounds.size.y < var_22_4 * manager.ui.mainCameraCom_.aspect / var_22_3.sprite.bounds.size.x and var_22_4 * manager.ui.mainCameraCom_.aspect / var_22_3.sprite.bounds.size.x or var_22_4 / var_22_3.sprite.bounds.size.y, var_22_4 / var_22_3.sprite.bounds.size.y < var_22_4 * manager.ui.mainCameraCom_.aspect / var_22_3.sprite.bounds.size.x and var_22_4 * manager.ui.mainCameraCom_.aspect / var_22_3.sprite.bounds.size.x or var_22_4 / var_22_3.sprite.bounds.size.y, 0)
				end
			end

			local var_22_5 = 2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_5 then
				local var_22_6 = Color.New(1, 1, 1)

				var_22_6.a = Mathf.Lerp(0, 1, (arg_19_1.time_ - var_22_1) / var_22_5)

				var_22_2:GetComponent("SpriteRenderer").material:SetColor("_Color", var_22_6)
			end

			local var_22_7 = 0
			local var_22_8 = 0.55

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_7 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_9 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(1101105004).content)

				arg_19_1.text_.text = var_22_9

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_11 = 22 <= 0 and var_22_8 or var_22_8 * (utf8.len(var_22_9) / 22)

				if (22 <= 0 and var_22_8 or var_22_8 * (utf8.len(var_22_9) / 22)) > 0 and var_22_8 < var_22_11 then
					arg_19_1.talkMaxDuration = var_22_11

					if var_22_11 + var_22_7 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_11 + var_22_7
					end
				end

				arg_19_1.text_.text = var_22_9
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_12 = math.max(var_22_8, arg_19_1.talkMaxDuration)

			if var_22_7 <= arg_19_1.time_ and arg_19_1.time_ < var_22_7 + var_22_12 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_7) / var_22_12

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_7 + var_22_12 and arg_19_1.time_ < var_22_7 + var_22_12 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play1101105005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 1101105005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play1101105006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.075

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

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(1101105005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 43 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 43)

				if (43 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 43)) > 0 and var_26_0 < var_26_3 then
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
	Play1101105006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 1101105006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play1101105007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.85

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(1101105006).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 34 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 34)

				if (34 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 34)) > 0 and var_30_0 < var_30_3 then
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
	Play1101105007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 1101105007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play1101105008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.05

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

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(1101105007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 2 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 2)

				if (2 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 2)) > 0 and var_34_0 < var_34_3 then
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
	Play1101105008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1101105008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1101105009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.allBtn_.enabled = false
			end

			if arg_35_1.time_ >= 0 + 1.5 and arg_35_1.time_ < 0 + 1.5 + arg_38_0 then
				arg_35_1.allBtn_.enabled = true
			end

			local var_38_0 = 0
			local var_38_1 = 0.575

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_2 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(1101105008).content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 23 <= 0 and var_38_1 or var_38_1 * (utf8.len(var_38_2) / 23)

				if (23 <= 0 and var_38_1 or var_38_1 * (utf8.len(var_38_2) / 23)) > 0 and var_38_1 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_5 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_5 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_5

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_5 and arg_35_1.time_ < var_38_0 + var_38_5 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play1101105009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1101105009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1101105010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_42_0 = 1

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				local var_42_1, var_42_2 = math.modf((arg_39_1.time_ - 0) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_42_2 * 0.13, var_42_2 * 0.13, var_42_2 * 0.13) + arg_39_1.var_.shakeOldPos
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				manager.ui.mainCamera.transform.localPosition = arg_39_1.var_.shakeOldPos
			end

			local var_42_3 = 0
			local var_42_4 = 0.275

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
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

				local var_42_5 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(1101105009).content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 11 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 11)

				if (11 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 11)) > 0 and var_42_4 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_4, arg_39_1.talkMaxDuration)

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_3) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_3 + var_42_8 and arg_39_1.time_ < var_42_3 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1101105010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1101105010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1101105011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 1.175

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

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(1101105010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 47 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 47)

				if (47 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 47)) > 0 and var_46_0 < var_46_3 then
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
	Play1101105011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1101105011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1101105012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.575

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1101105011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 23 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 23)

				if (23 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 23)) > 0 and var_50_0 < var_50_3 then
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
	Play1101105012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1101105012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1101105013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.9

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(1101105012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 36 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 36)

				if (36 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 36)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1101105013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1101105013
		arg_55_1.duration_ = 9

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1101105014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.bgs_.ST12 == nil then
				local var_58_0 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_58_0.name = "ST12"
				var_58_0.transform.parent = arg_55_1.stage_.transform
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_.ST12 = var_58_0
			end

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= 2 + arg_58_0 then
				local var_58_1 = arg_55_1.bgs_.ST12

				arg_55_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_2 = var_58_1:GetComponent("SpriteRenderer")

				if var_58_2 and var_58_2.sprite then
					local var_58_3 = 2 * (var_58_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_1.transform.localScale = Vector3.New(var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "ST12" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_5 = 2

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_5 then
				local var_58_6 = Color.New(0, 0, 0)

				var_58_6.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_4) / var_58_5)
				arg_55_1.mask_.color = var_58_6
			end

			if arg_55_1.time_ >= var_58_4 + var_58_5 and arg_55_1.time_ < var_58_4 + var_58_5 + arg_58_0 then
				local var_58_7 = Color.New(0, 0, 0)

				var_58_7.a = 1
				arg_55_1.mask_.color = var_58_7
			end

			local var_58_8 = 2

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_9 = 2

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = Color.New(0, 0, 0)

				var_58_10.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_8) / var_58_9)
				arg_55_1.mask_.color = var_58_10
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 then
				local var_58_11 = Color.New(0, 0, 0)

				arg_55_1.mask_.enabled = false
				var_58_11.a = 0
				arg_55_1.mask_.color = var_58_11
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_12 = 4
			local var_58_13 = 0.775

			if 4 < arg_55_1.time_ and arg_55_1.time_ <= var_58_12 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_14 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_14:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_15 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(1101105013).content)

				arg_55_1.text_.text = var_58_15

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_17 = 31 <= 0 and var_58_13 or var_58_13 * (utf8.len(var_58_15) / 31)

				if (31 <= 0 and var_58_13 or var_58_13 * (utf8.len(var_58_15) / 31)) > 0 and var_58_13 < var_58_17 then
					arg_55_1.talkMaxDuration = var_58_17
					var_58_12 = var_58_12 + 0.3

					if var_58_17 + var_58_12 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_12
					end
				end

				arg_55_1.text_.text = var_58_15
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_18 = var_58_12 + 0.3
			local var_58_19 = math.max(var_58_13, arg_55_1.talkMaxDuration)

			if var_58_12 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_18 + var_58_19 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_18) / var_58_19

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_18 + var_58_19 and arg_55_1.time_ < var_58_18 + var_58_19 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1101105014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1101105014
		arg_61_1.duration_ = 6.07

		local var_61_0 = {
			zh = 3.666,
			ja = 6.066
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1101105015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_64_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_61_1.stage_.transform)

				var_64_0.name = "1011ui_story"
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1011ui_story"] = var_64_0

				local var_64_1 = var_64_0:GetComponentInChildren(typeof(CharacterEffect))

				var_64_1.enabled = true

				local var_64_2 = GameObjectTools.GetOrAddComponent(var_64_0, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(false)
				end

				arg_61_1:ShowWeapon(var_64_1.transform, false)

				arg_61_1.var_["1011ui_story" .. "Animator"] = var_64_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_61_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_61_1.var_["1011ui_story" .. "LipSync"] = var_64_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_64_3 = arg_61_1.actors_["1011ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1011ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_61_1.time_ - 0) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(0, -0.71, -6)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["1011ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1011ui_story == nil then
				arg_61_1.var_.characterEffect1011ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.characterEffect1011ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1011ui_story then
				arg_61_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_64_8 = 0
			local var_64_9 = 0.35

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(1101105014)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 14 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 14)

				if (14 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 14)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb")

						arg_61_1:RecordAudio("1101105014", var_64_15)
						arg_61_1:RecordAudio("1101105014", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105014", "story_v_side_new_1101105.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1101105015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1101105016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1011ui_story"]) and arg_65_1.var_.characterEffect1011ui_story == nil then
				arg_65_1.var_.characterEffect1011ui_story = arg_65_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1011ui_story"]) then
				if arg_65_1.var_.characterEffect1011ui_story and not isNil(arg_65_1.actors_["1011ui_story"]) then
					arg_65_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1011ui_story"]) and arg_65_1.var_.characterEffect1011ui_story then
				arg_65_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.9

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1101105015).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 36 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 36)

				if (36 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 36)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1101105016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1101105016
		arg_69_1.duration_ = 4.6

		local var_69_0 = {
			zh = 3.933,
			ja = 4.6
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
				arg_69_0:Play1101105017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1011ui_story = arg_69_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).z)
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles = arg_69_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_69_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1011ui_story"].transform.position).z)
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1011ui_story"].transform.localEulerAngles = arg_69_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1011ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1011ui_story == nil then
				arg_69_1.var_.characterEffect1011ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1011ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1011ui_story then
				arg_69_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_72_4 = 0
			local var_72_5 = 0.45

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(1101105016)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 18 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 18)

				if (18 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 18)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb")

						arg_69_1:RecordAudio("1101105016", var_72_11)
						arg_69_1:RecordAudio("1101105016", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105016", "story_v_side_new_1101105.awb")
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
				actorName = "1011ui_story",
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
	Play1101105017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1101105017
		arg_73_1.duration_ = 1

		SetActive(arg_73_1.tipsGo_, true)

		arg_73_1.tipsText_.text = StoryTipsCfg[101101].name

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"

			SetActive(arg_73_1.choicesGo_, true)

			for iter_74_0, iter_74_1 in ipairs(arg_73_1.choices_) do
				SetActive(iter_74_1.go, iter_74_0 <= 2)
			end

			arg_73_1.choices_[1].txt.text = arg_73_1:FormatText(StoryChoiceCfg[619].name)
			arg_73_1.choices_[2].txt.text = arg_73_1:FormatText(StoryChoiceCfg[623].name)
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1101105018(arg_73_1)
			end

			if arg_75_0 == 2 then
				PlayerAction.UseStoryTrigger(1011016, 210110105, 1101105017, 2)
				arg_73_0:Play1101105018(arg_73_1)
			end

			arg_73_1:RecordChoiceLog(1101105017, 619, 623)
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) and arg_73_1.var_.characterEffect1011ui_story == nil then
				arg_73_1.var_.characterEffect1011ui_story = arg_73_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) then
				if arg_73_1.var_.characterEffect1011ui_story and not isNil(arg_73_1.actors_["1011ui_story"]) then
					arg_73_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1011ui_story"]) and arg_73_1.var_.characterEffect1011ui_story then
				arg_73_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			if arg_73_1.time_ >= var_76_1 + 0.5 and arg_73_1.time_ < var_76_1 + 0.5 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1101105018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1101105018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1101105019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.375

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
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

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1101105018).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 15 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 15)

				if (15 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 15)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1101105019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1101105019
		arg_81_1.duration_ = 9.23

		local var_81_0 = {
			zh = 7.666,
			ja = 9.233
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
				arg_81_0:Play1101105020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1011ui_story = arg_81_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1011ui_story"].transform.position).z)
				arg_81_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1011ui_story"].transform.localEulerAngles = arg_81_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_81_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1011ui_story"].transform.position).z)
				arg_81_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1011ui_story"].transform.localEulerAngles = arg_81_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1011ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1011ui_story == nil then
				arg_81_1.var_.characterEffect1011ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1011ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1011ui_story then
				arg_81_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action486")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.625

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(1101105019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 25 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 25)

				if (25 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 25)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb")

						arg_81_1:RecordAudio("1101105019", var_84_11)
						arg_81_1:RecordAudio("1101105019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105019", "story_v_side_new_1101105.awb")
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
				actorName = "1011ui_story",
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
	Play1101105020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1101105020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1101105021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1011ui_story"]) and arg_85_1.var_.characterEffect1011ui_story == nil then
				arg_85_1.var_.characterEffect1011ui_story = arg_85_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1011ui_story"]) then
				if arg_85_1.var_.characterEffect1011ui_story and not isNil(arg_85_1.actors_["1011ui_story"]) then
					arg_85_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1011ui_story"]) and arg_85_1.var_.characterEffect1011ui_story then
				arg_85_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.825

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

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1101105020).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 33 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 33)

				if (33 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 33)) > 0 and var_88_2 < var_88_5 then
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
	Play1101105021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1101105021
		arg_89_1.duration_ = 9.97

		local var_89_0 = {
			zh = 9.966,
			ja = 7.966
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
				arg_89_0:Play1101105022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1011ui_story = arg_89_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1011ui_story"].transform.position).z)
				arg_89_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1011ui_story"].transform.localEulerAngles = arg_89_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_89_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1011ui_story"].transform.position).z)
				arg_89_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1011ui_story"].transform.localEulerAngles = arg_89_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1011ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1011ui_story == nil then
				arg_89_1.var_.characterEffect1011ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1011ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1011ui_story then
				arg_89_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_92_4 = 0
			local var_92_5 = 0.675

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(1101105021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 27 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 27)

				if (27 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 27)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb")

						arg_89_1:RecordAudio("1101105021", var_92_11)
						arg_89_1:RecordAudio("1101105021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105021", "story_v_side_new_1101105.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1101105022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1101105023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1011ui_story"]) and arg_93_1.var_.characterEffect1011ui_story == nil then
				arg_93_1.var_.characterEffect1011ui_story = arg_93_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1011ui_story"]) then
				if arg_93_1.var_.characterEffect1011ui_story and not isNil(arg_93_1.actors_["1011ui_story"]) then
					arg_93_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1011ui_story"]) and arg_93_1.var_.characterEffect1011ui_story then
				arg_93_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.6

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1101105022).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 24 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 24)

				if (24 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 24)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1101105023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1101105023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1101105024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.825

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
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

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1101105023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 33 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 33)

				if (33 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 33)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1101105024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1101105024
		arg_101_1.duration_ = 9.03

		local var_101_0 = {
			zh = 8.433,
			ja = 9.033
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
				arg_101_0:Play1101105025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.975

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(1101105024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 39 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 39)

				if (39 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 39)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb")

						arg_101_1:RecordAudio("1101105024", var_104_6)
						arg_101_1:RecordAudio("1101105024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105024", "story_v_side_new_1101105.awb")
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
	Play1101105025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1101105025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1101105026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.275

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
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

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1101105025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 11 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 11)

				if (11 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 11)) > 0 and var_108_0 < var_108_3 then
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
	Play1101105026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1101105026
		arg_109_1.duration_ = 8

		local var_109_0 = {
			zh = 5.4,
			ja = 8
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
				arg_109_0:Play1101105027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1011ui_story = arg_109_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).z)
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles = arg_109_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_109_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).z)
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles = arg_109_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1011ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1011ui_story == nil then
				arg_109_1.var_.characterEffect1011ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1011ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1011ui_story then
				arg_109_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action424")
			end

			local var_112_4 = 0
			local var_112_5 = 0.925

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(1101105026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 37 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 37)

				if (37 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 37)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb")

						arg_109_1:RecordAudio("1101105026", var_112_11)
						arg_109_1:RecordAudio("1101105026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105026", "story_v_side_new_1101105.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1101105027
		arg_113_1.duration_ = 5

		local var_113_0 = {
			zh = 4,
			ja = 5
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
				arg_113_0:Play1101105028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1011ui_story = arg_113_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1011ui_story"].transform.position).z)
				arg_113_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1011ui_story"].transform.localEulerAngles = arg_113_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_113_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1011ui_story"].transform.position).z)
				arg_113_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1011ui_story"].transform.localEulerAngles = arg_113_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1011ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1011ui_story == nil then
				arg_113_1.var_.characterEffect1011ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1011ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1011ui_story then
				arg_113_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.475

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(1101105027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 19 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 19)

				if (19 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 19)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb")

						arg_113_1:RecordAudio("1101105027", var_116_11)
						arg_113_1:RecordAudio("1101105027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105027", "story_v_side_new_1101105.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1101105028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1101105029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1011ui_story"]) and arg_117_1.var_.characterEffect1011ui_story == nil then
				arg_117_1.var_.characterEffect1011ui_story = arg_117_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1011ui_story"]) then
				if arg_117_1.var_.characterEffect1011ui_story and not isNil(arg_117_1.actors_["1011ui_story"]) then
					arg_117_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1011ui_story"]) and arg_117_1.var_.characterEffect1011ui_story then
				arg_117_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.875

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1101105028).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 35 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 35)

				if (35 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 35)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1101105029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1101105029
		arg_121_1.duration_ = 5.77

		local var_121_0 = {
			zh = 5.6,
			ja = 5.766
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
				arg_121_0:Play1101105030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.525

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(1101105029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 21 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 21)

				if (21 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 21)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb")

						arg_121_1:RecordAudio("1101105029", var_124_6)
						arg_121_1:RecordAudio("1101105029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105029", "story_v_side_new_1101105.awb")
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
	Play1101105030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1101105030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1101105031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.375

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

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1101105030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 15 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 15)

				if (15 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 15)) > 0 and var_128_0 < var_128_3 then
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
	Play1101105031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1101105031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1101105032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.075

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

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1101105031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 43 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 43)

				if (43 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 43)) > 0 and var_132_0 < var_132_3 then
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
	Play1101105032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1101105032
		arg_133_1.duration_ = 3.23

		local var_133_0 = {
			zh = 2.066,
			ja = 3.233
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
				arg_133_0:Play1101105033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.275

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(1101105032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 11 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 11)

				if (11 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 11)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb")

						arg_133_1:RecordAudio("1101105032", var_136_6)
						arg_133_1:RecordAudio("1101105032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105032", "story_v_side_new_1101105.awb")
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
	Play1101105033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1101105033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1101105034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.35

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
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

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1101105033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 14 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 14)

				if (14 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 14)) > 0 and var_140_0 < var_140_3 then
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
	Play1101105034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1101105034
		arg_141_1.duration_ = 7.83

		local var_141_0 = {
			zh = 6.866,
			ja = 7.833
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
				arg_141_0:Play1101105035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1011ui_story = arg_141_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).z)
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles = arg_141_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_141_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).z)
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles = arg_141_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1011ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1011ui_story == nil then
				arg_141_1.var_.characterEffect1011ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1011ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1011ui_story then
				arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_144_4 = 0
			local var_144_5 = 0.75

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(1101105034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 30 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 30)

				if (30 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 30)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb")

						arg_141_1:RecordAudio("1101105034", var_144_11)
						arg_141_1:RecordAudio("1101105034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105034", "story_v_side_new_1101105.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1101105035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1101105036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1011ui_story"]) and arg_145_1.var_.characterEffect1011ui_story == nil then
				arg_145_1.var_.characterEffect1011ui_story = arg_145_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1011ui_story"]) then
				if arg_145_1.var_.characterEffect1011ui_story and not isNil(arg_145_1.actors_["1011ui_story"]) then
					arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1011ui_story"]) and arg_145_1.var_.characterEffect1011ui_story then
				arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.325

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
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

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1101105035).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 13 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 13)

				if (13 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 13)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1101105036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1101105036
		arg_149_1.duration_ = 4.53

		local var_149_0 = {
			zh = 3,
			ja = 4.533
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
				arg_149_0:Play1101105037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1011ui_story = arg_149_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).z)
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles = arg_149_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_149_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1011ui_story"].transform.position).z)
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1011ui_story"].transform.localEulerAngles = arg_149_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1011ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1011ui_story == nil then
				arg_149_1.var_.characterEffect1011ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1011ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1011ui_story then
				arg_149_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_152_4 = 0
			local var_152_5 = 0.225

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(1101105036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 9 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 9)

				if (9 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 9)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb")

						arg_149_1:RecordAudio("1101105036", var_152_11)
						arg_149_1:RecordAudio("1101105036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105036", "story_v_side_new_1101105.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play1101105037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1101105037
		arg_153_1.duration_ = 7.7

		local var_153_0 = {
			zh = 4.3,
			ja = 7.7
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
				arg_153_0:Play1101105038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1011ui_story"]) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = arg_153_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1011ui_story"]) then
				if arg_153_1.var_.characterEffect1011ui_story and not isNil(arg_153_1.actors_["1011ui_story"]) then
					arg_153_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1011ui_story"]) and arg_153_1.var_.characterEffect1011ui_story then
				arg_153_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.475

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(1101105037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 19 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 19)

				if (19 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 19)) > 0 and var_156_2 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb") ~= 0 then
					local var_156_7 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb") / 1000

					if var_156_7 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_1
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb")

						arg_153_1:RecordAudio("1101105037", var_156_8)
						arg_153_1:RecordAudio("1101105037", var_156_8)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105037", "story_v_side_new_1101105.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_9 and arg_153_1.time_ < var_156_1 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1101105038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1101105038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1101105039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_160_0 = 0
			local var_160_1 = 0.85

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
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

				local var_160_2 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1101105038).content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 34 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_2) / 34)

				if (34 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_2) / 34)) > 0 and var_160_1 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_5 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_5 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_5

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_5 and arg_157_1.time_ < var_160_0 + var_160_5 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1101105039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1101105039
		arg_161_1.duration_ = 3.23

		local var_161_0 = {
			zh = 2.166,
			ja = 3.233
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
				arg_161_0:Play1101105040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.225

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:GetWordFromCfg(1101105039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 9 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 9)

				if (9 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 9)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb")

						arg_161_1:RecordAudio("1101105039", var_164_6)
						arg_161_1:RecordAudio("1101105039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105039", "story_v_side_new_1101105.awb")
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
	Play1101105040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1101105040
		arg_165_1.duration_ = 3.63

		local var_165_0 = {
			zh = 1.999999999999,
			ja = 3.633
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
				arg_165_0:Play1101105041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1011ui_story = arg_165_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).z)
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles = arg_165_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_165_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).z)
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles = arg_165_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1011ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_168_4 = 0
			local var_168_5 = 0.075

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(1101105040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 3 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 3)

				if (3 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 3)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb")

						arg_165_1:RecordAudio("1101105040", var_168_11)
						arg_165_1:RecordAudio("1101105040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105040", "story_v_side_new_1101105.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play1101105041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1101105041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1101105042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1011ui_story"]) and arg_169_1.var_.characterEffect1011ui_story == nil then
				arg_169_1.var_.characterEffect1011ui_story = arg_169_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1011ui_story"]) then
				if arg_169_1.var_.characterEffect1011ui_story and not isNil(arg_169_1.actors_["1011ui_story"]) then
					arg_169_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1011ui_story"]) and arg_169_1.var_.characterEffect1011ui_story then
				arg_169_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_172_1 = 0
			local var_172_2 = 0.65

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1101105041).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 26 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 26)

				if (26 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 26)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1101105042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1101105042
		arg_173_1.duration_ = 11.3

		local var_173_0 = {
			zh = 9.7,
			ja = 11.3
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
				arg_173_0:Play1101105043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1011ui_story = arg_173_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1011ui_story"].transform.position).z)
				arg_173_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1011ui_story"].transform.localEulerAngles = arg_173_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_173_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1011ui_story"].transform.position).z)
				arg_173_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1011ui_story"].transform.localEulerAngles = arg_173_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1011ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1011ui_story == nil then
				arg_173_1.var_.characterEffect1011ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1011ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1011ui_story then
				arg_173_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_176_4 = 0
			local var_176_5 = 1.175

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(1101105042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 47 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 47)

				if (47 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 47)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb")

						arg_173_1:RecordAudio("1101105042", var_176_11)
						arg_173_1:RecordAudio("1101105042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105042", "story_v_side_new_1101105.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play1101105043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1101105043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1101105044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1011ui_story"]) and arg_177_1.var_.characterEffect1011ui_story == nil then
				arg_177_1.var_.characterEffect1011ui_story = arg_177_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1011ui_story"]) then
				if arg_177_1.var_.characterEffect1011ui_story and not isNil(arg_177_1.actors_["1011ui_story"]) then
					arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1011ui_story"]) and arg_177_1.var_.characterEffect1011ui_story then
				arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.2

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
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

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1101105043).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 8 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 8)

				if (8 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 8)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1101105044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1101105044
		arg_181_1.duration_ = 5.03

		local var_181_0 = {
			zh = 3.766,
			ja = 5.033
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
				arg_181_0:Play1101105045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.425

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:GetWordFromCfg(1101105044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 17 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 17)

				if (17 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 17)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb")

						arg_181_1:RecordAudio("1101105044", var_184_6)
						arg_181_1:RecordAudio("1101105044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105044", "story_v_side_new_1101105.awb")
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
	Play1101105045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1101105045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1101105046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.8

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1101105045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 32 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 32)

				if (32 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 32)) > 0 and var_188_0 < var_188_3 then
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
	Play1101105046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1101105046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1101105047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.075

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(1101105046).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 3 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 3)

				if (3 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 3)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1101105047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1101105047
		arg_193_1.duration_ = 2

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1101105048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1011ui_story = arg_193_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1011ui_story"].transform.position).z)
				arg_193_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1011ui_story"].transform.localEulerAngles = arg_193_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_193_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1011ui_story"].transform.position).z)
				arg_193_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1011ui_story"].transform.localEulerAngles = arg_193_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1011ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1011ui_story == nil then
				arg_193_1.var_.characterEffect1011ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1011ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1011ui_story then
				arg_193_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.075

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(1101105047)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 3 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 3)

				if (3 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 3)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb")

						arg_193_1:RecordAudio("1101105047", var_196_11)
						arg_193_1:RecordAudio("1101105047", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105047", "story_v_side_new_1101105.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play1101105048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1101105048
		arg_197_1.duration_ = 6.93

		local var_197_0 = {
			zh = 5.633,
			ja = 6.933
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
				arg_197_0:Play1101105049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1011ui_story"]) and arg_197_1.var_.characterEffect1011ui_story == nil then
				arg_197_1.var_.characterEffect1011ui_story = arg_197_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1011ui_story"]) then
				if arg_197_1.var_.characterEffect1011ui_story and not isNil(arg_197_1.actors_["1011ui_story"]) then
					arg_197_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1011ui_story"]) and arg_197_1.var_.characterEffect1011ui_story then
				arg_197_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.65

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(1101105048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_6 = 26 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 26)

				if (26 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 26)) > 0 and var_200_2 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb") ~= 0 then
					local var_200_7 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb") / 1000

					if var_200_7 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_1
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb")

						arg_197_1:RecordAudio("1101105048", var_200_8)
						arg_197_1:RecordAudio("1101105048", var_200_8)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105048", "story_v_side_new_1101105.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_9 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_9

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_9 and arg_197_1.time_ < var_200_1 + var_200_9 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1101105049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1101105049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1101105050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.1

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1101105049).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 44 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 44)

				if (44 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 44)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1101105050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1101105050
		arg_205_1.duration_ = 6.57

		local var_205_0 = {
			zh = 6.433,
			ja = 6.566
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
				arg_205_0:Play1101105051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_208_0 = 0
			local var_208_1 = 0.8

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_2 = arg_205_1:GetWordFromCfg(1101105050)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 32 <= 0 and var_208_1 or var_208_1 * (utf8.len(var_208_3) / 32)

				if (32 <= 0 and var_208_1 or var_208_1 * (utf8.len(var_208_3) / 32)) > 0 and var_208_1 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb") ~= 0 then
					local var_208_6 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb") / 1000

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end

					if var_208_2.prefab_name ~= "" and arg_205_1.actors_[var_208_2.prefab_name] ~= nil then
						local var_208_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_2.prefab_name].transform, "story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb")

						arg_205_1:RecordAudio("1101105050", var_208_7)
						arg_205_1:RecordAudio("1101105050", var_208_7)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105050", "story_v_side_new_1101105.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1101105051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1101105051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1101105052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.5

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1101105051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 20 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 20)

				if (20 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 20)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1101105052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1101105052
		arg_213_1.duration_ = 8.4

		local var_213_0 = {
			zh = 7.133,
			ja = 8.4
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
				arg_213_0:Play1101105053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1011ui_story = arg_213_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1011ui_story"].transform.position).z)
				arg_213_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1011ui_story"].transform.localEulerAngles = arg_213_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_213_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1011ui_story"].transform.position).z)
				arg_213_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1011ui_story"].transform.localEulerAngles = arg_213_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1011ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1011ui_story == nil then
				arg_213_1.var_.characterEffect1011ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1011ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1011ui_story then
				arg_213_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.7

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(1101105052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 28 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 28)

				if (28 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 28)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb")

						arg_213_1:RecordAudio("1101105052", var_216_11)
						arg_213_1:RecordAudio("1101105052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105052", "story_v_side_new_1101105.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1101105053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1101105054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1011ui_story"]) and arg_217_1.var_.characterEffect1011ui_story == nil then
				arg_217_1.var_.characterEffect1011ui_story = arg_217_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1011ui_story"]) then
				if arg_217_1.var_.characterEffect1011ui_story and not isNil(arg_217_1.actors_["1011ui_story"]) then
					arg_217_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1011ui_story"]) and arg_217_1.var_.characterEffect1011ui_story then
				arg_217_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.375

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1101105053).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 15 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 15)

				if (15 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 15)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1101105054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1101105054
		arg_221_1.duration_ = 2

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1101105055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1011ui_story = arg_221_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).z)
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles = arg_221_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_221_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1011ui_story"].transform.position).z)
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1011ui_story"].transform.localEulerAngles = arg_221_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1011ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1011ui_story == nil then
				arg_221_1.var_.characterEffect1011ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1011ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1011ui_story then
				arg_221_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action446")
			end

			local var_224_4 = 0
			local var_224_5 = 0.05

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(1101105054)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 2 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 2)

				if (2 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 2)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb")

						arg_221_1:RecordAudio("1101105054", var_224_11)
						arg_221_1:RecordAudio("1101105054", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105054", "story_v_side_new_1101105.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1101105055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1101105056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1011ui_story = arg_225_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1011ui_story"].transform.position).z)
				arg_225_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1011ui_story"].transform.localEulerAngles = arg_225_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1011ui_story"].transform.position).z)
				arg_225_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1011ui_story"].transform.localEulerAngles = arg_225_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1011ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1011ui_story == nil then
				arg_225_1.var_.characterEffect1011ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1011ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_2)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1011ui_story then
				arg_225_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_228_3 = 0
			local var_228_4 = 0.675

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_5 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1101105055).content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 27 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_5) / 27)

				if (27 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_5) / 27)) > 0 and var_228_4 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_3 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_3
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_4, arg_225_1.talkMaxDuration)

			if var_228_3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_3 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_3) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_3 + var_228_8 and arg_225_1.time_ < var_228_3 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1101105056
		arg_229_1.duration_ = 10.07

		local var_229_0 = {
			zh = 10.066,
			ja = 9.066
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
				arg_229_0:Play1101105057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if arg_229_1.bgs_.B13 == nil then
				local var_232_0 = Object.Instantiate(arg_229_1.paintGo_)

				var_232_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_232_0.name = "B13"
				var_232_0.transform.parent = arg_229_1.stage_.transform
				var_232_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_.B13 = var_232_0
			end

			if 3 < arg_229_1.time_ and arg_229_1.time_ <= 3 + arg_232_0 then
				local var_232_1 = arg_229_1.bgs_.B13

				arg_229_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_2 = var_232_1:GetComponent("SpriteRenderer")

				if var_232_2 and var_232_2.sprite then
					local var_232_3 = 2 * (var_232_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_1.transform.localScale = Vector3.New(var_232_3 / var_232_2.sprite.bounds.size.y < var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x and var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x or var_232_3 / var_232_2.sprite.bounds.size.y, var_232_3 / var_232_2.sprite.bounds.size.y < var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x and var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x or var_232_3 / var_232_2.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "B13" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_4 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_5 = 3

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_5 then
				local var_232_6 = Color.New(0, 0, 0)

				var_232_6.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_4) / var_232_5)
				arg_229_1.mask_.color = var_232_6
			end

			if arg_229_1.time_ >= var_232_4 + var_232_5 and arg_229_1.time_ < var_232_4 + var_232_5 + arg_232_0 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = 1
				arg_229_1.mask_.color = var_232_7
			end

			local var_232_8 = 3

			if 3 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_9 = 3

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 then
				local var_232_10 = Color.New(0, 0, 0)

				var_232_10.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_8) / var_232_9)
				arg_229_1.mask_.color = var_232_10
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 then
				local var_232_11 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_11.a = 0
				arg_229_1.mask_.color = var_232_11
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_12 = 6
			local var_232_13 = 0.375

			if 6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_14 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_14:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_15 = arg_229_1:GetWordFromCfg(1101105056)
				local var_232_16 = arg_229_1:FormatText(var_232_15.content)

				arg_229_1.text_.text = var_232_16

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_18 = 15 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_16) / 15)

				if (15 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_16) / 15)) > 0 and var_232_13 < var_232_18 then
					arg_229_1.talkMaxDuration = var_232_18
					var_232_12 = var_232_12 + 0.3

					if var_232_18 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_16
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb") ~= 0 then
					local var_232_19 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb") / 1000

					if var_232_19 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_12
					end

					if var_232_15.prefab_name ~= "" and arg_229_1.actors_[var_232_15.prefab_name] ~= nil then
						local var_232_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_15.prefab_name].transform, "story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb")

						arg_229_1:RecordAudio("1101105056", var_232_20)
						arg_229_1:RecordAudio("1101105056", var_232_20)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105056", "story_v_side_new_1101105.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_21 = var_232_12 + 0.3
			local var_232_22 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_21 + var_232_22 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_21) / var_232_22

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_21 + var_232_22 and arg_229_1.time_ < var_232_21 + var_232_22 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1101105057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1101105057
		arg_235_1.duration_ = 7.47

		local var_235_0 = {
			zh = 5.4,
			ja = 7.466
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
				arg_235_0:Play1101105058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.6

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:GetWordFromCfg(1101105057)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 24 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 24)

				if (24 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 24)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb")

						arg_235_1:RecordAudio("1101105057", var_238_6)
						arg_235_1:RecordAudio("1101105057", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105057", "story_v_side_new_1101105.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1101105058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1101105058
		arg_239_1.duration_ = 9

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1101105059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if arg_239_1.bgs_.ST10 == nil then
				local var_242_0 = Object.Instantiate(arg_239_1.paintGo_)

				var_242_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_242_0.name = "ST10"
				var_242_0.transform.parent = arg_239_1.stage_.transform
				var_242_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.bgs_.ST10 = var_242_0
			end

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= 2 + arg_242_0 then
				local var_242_1 = arg_239_1.bgs_.ST10

				arg_239_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_242_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_2 = var_242_1:GetComponent("SpriteRenderer")

				if var_242_2 and var_242_2.sprite then
					local var_242_3 = 2 * (var_242_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_242_1.transform.localScale = Vector3.New(var_242_3 / var_242_2.sprite.bounds.size.y < var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x and var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x or var_242_3 / var_242_2.sprite.bounds.size.y, var_242_3 / var_242_2.sprite.bounds.size.y < var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x and var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x or var_242_3 / var_242_2.sprite.bounds.size.y, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "ST10" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_4 = 0

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_5 = 2

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_5 then
				local var_242_6 = Color.New(0, 0, 0)

				var_242_6.a = Mathf.Lerp(0, 1, (arg_239_1.time_ - var_242_4) / var_242_5)
				arg_239_1.mask_.color = var_242_6
			end

			if arg_239_1.time_ >= var_242_4 + var_242_5 and arg_239_1.time_ < var_242_4 + var_242_5 + arg_242_0 then
				local var_242_7 = Color.New(0, 0, 0)

				var_242_7.a = 1
				arg_239_1.mask_.color = var_242_7
			end

			local var_242_8 = 2

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_9 = 2

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 then
				local var_242_10 = Color.New(0, 0, 0)

				var_242_10.a = Mathf.Lerp(1, 0, (arg_239_1.time_ - var_242_8) / var_242_9)
				arg_239_1.mask_.color = var_242_10
			end

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 then
				local var_242_11 = Color.New(0, 0, 0)

				arg_239_1.mask_.enabled = false
				var_242_11.a = 0
				arg_239_1.mask_.color = var_242_11
			end

			local var_242_12 = "1033ui_story"

			if arg_239_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_242_13 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_239_1.stage_.transform)

				var_242_13.name = var_242_12
				var_242_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.actors_[var_242_12] = var_242_13

				local var_242_14 = var_242_13:GetComponentInChildren(typeof(CharacterEffect))

				var_242_14.enabled = true

				local var_242_15 = GameObjectTools.GetOrAddComponent(var_242_13, typeof(DynamicBoneHelper))

				if var_242_15 then
					var_242_15:EnableDynamicBone(false)
				end

				arg_239_1:ShowWeapon(var_242_14.transform, false)

				arg_239_1.var_[var_242_12 .. "Animator"] = var_242_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_239_1.var_[var_242_12 .. "Animator"].applyRootMotion = true
				arg_239_1.var_[var_242_12 .. "LipSync"] = var_242_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_242_16 = arg_239_1.actors_["1033ui_story"].transform

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= 4 + arg_242_0 then
				arg_239_1.var_.moveOldPos1033ui_story = var_242_16.localPosition
			end

			local var_242_17 = 0.001

			if 4 <= arg_239_1.time_ and arg_239_1.time_ < 4 + var_242_17 then
				var_242_16.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_239_1.time_ - 4) / var_242_17)
				var_242_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_16.position).x, (manager.ui.mainCamera.transform.position - var_242_16.position).y, (manager.ui.mainCamera.transform.position - var_242_16.position).z)
				var_242_16.localEulerAngles.z = 0
				var_242_16.localEulerAngles.x = 0
				var_242_16.localEulerAngles = var_242_16.localEulerAngles
			end

			if arg_239_1.time_ >= 4 + var_242_17 and arg_239_1.time_ < 4 + var_242_17 + arg_242_0 then
				var_242_16.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				var_242_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_16.position).x, (manager.ui.mainCamera.transform.position - var_242_16.position).y, (manager.ui.mainCamera.transform.position - var_242_16.position).z)
				var_242_16.localEulerAngles.z = 0
				var_242_16.localEulerAngles.x = 0
				var_242_16.localEulerAngles = var_242_16.localEulerAngles
			end

			local var_242_18 = "1066ui_story"

			if arg_239_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_242_19 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_239_1.stage_.transform)

				var_242_19.name = var_242_18
				var_242_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.actors_[var_242_18] = var_242_19

				local var_242_20 = var_242_19:GetComponentInChildren(typeof(CharacterEffect))

				var_242_20.enabled = true

				local var_242_21 = GameObjectTools.GetOrAddComponent(var_242_19, typeof(DynamicBoneHelper))

				if var_242_21 then
					var_242_21:EnableDynamicBone(false)
				end

				arg_239_1:ShowWeapon(var_242_20.transform, false)

				arg_239_1.var_[var_242_18 .. "Animator"] = var_242_20.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_239_1.var_[var_242_18 .. "Animator"].applyRootMotion = true
				arg_239_1.var_[var_242_18 .. "LipSync"] = var_242_20.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_242_22 = arg_239_1.actors_["1066ui_story"].transform

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= 4 + arg_242_0 then
				arg_239_1.var_.moveOldPos1066ui_story = var_242_22.localPosition
			end

			local var_242_23 = 0.001

			if 4 <= arg_239_1.time_ and arg_239_1.time_ < 4 + var_242_23 then
				var_242_22.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_239_1.time_ - 4) / var_242_23)
				var_242_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_22.position).x, (manager.ui.mainCamera.transform.position - var_242_22.position).y, (manager.ui.mainCamera.transform.position - var_242_22.position).z)
				var_242_22.localEulerAngles.z = 0
				var_242_22.localEulerAngles.x = 0
				var_242_22.localEulerAngles = var_242_22.localEulerAngles
			end

			if arg_239_1.time_ >= 4 + var_242_23 and arg_239_1.time_ < 4 + var_242_23 + arg_242_0 then
				var_242_22.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_242_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_22.position).x, (manager.ui.mainCamera.transform.position - var_242_22.position).y, (manager.ui.mainCamera.transform.position - var_242_22.position).z)
				var_242_22.localEulerAngles.z = 0
				var_242_22.localEulerAngles.x = 0
				var_242_22.localEulerAngles = var_242_22.localEulerAngles
			end

			local var_242_24 = arg_239_1.actors_["1033ui_story"]

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= 4 + arg_242_0 and not isNil(var_242_24) and arg_239_1.var_.characterEffect1033ui_story == nil then
				arg_239_1.var_.characterEffect1033ui_story = var_242_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_25 = 0.034000001847744

			if 4 <= arg_239_1.time_ and arg_239_1.time_ < 4 + var_242_25 and not isNil(var_242_24) then
				if arg_239_1.var_.characterEffect1033ui_story and not isNil(var_242_24) then
					arg_239_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 4) / var_242_25)
				end
			end

			if arg_239_1.time_ >= 4 + var_242_25 and arg_239_1.time_ < 4 + var_242_25 + arg_242_0 and not isNil(var_242_24) and arg_239_1.var_.characterEffect1033ui_story then
				arg_239_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= 4 + arg_242_0 then
				arg_239_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= 4 + arg_242_0 then
				arg_239_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_242_26 = arg_239_1.actors_["1066ui_story"]

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= 4 + arg_242_0 and not isNil(var_242_26) and arg_239_1.var_.characterEffect1066ui_story == nil then
				arg_239_1.var_.characterEffect1066ui_story = var_242_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_27 = 0.034000001847744

			if 4 <= arg_239_1.time_ and arg_239_1.time_ < 4 + var_242_27 and not isNil(var_242_26) then
				if arg_239_1.var_.characterEffect1066ui_story and not isNil(var_242_26) then
					arg_239_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 4) / var_242_27)
				end
			end

			if arg_239_1.time_ >= 4 + var_242_27 and arg_239_1.time_ < 4 + var_242_27 + arg_242_0 and not isNil(var_242_26) and arg_239_1.var_.characterEffect1066ui_story then
				arg_239_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_28 = 4
			local var_242_29 = 0.8

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= var_242_28 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_30 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_30:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_31 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(1101105058).content)

				arg_239_1.text_.text = var_242_31

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_33 = 32 <= 0 and var_242_29 or var_242_29 * (utf8.len(var_242_31) / 32)

				if (32 <= 0 and var_242_29 or var_242_29 * (utf8.len(var_242_31) / 32)) > 0 and var_242_29 < var_242_33 then
					arg_239_1.talkMaxDuration = var_242_33
					var_242_28 = var_242_28 + 0.3

					if var_242_33 + var_242_28 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_33 + var_242_28
					end
				end

				arg_239_1.text_.text = var_242_31
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_34 = var_242_28 + 0.3
			local var_242_35 = math.max(var_242_29, arg_239_1.talkMaxDuration)

			if var_242_28 + 0.3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_34 + var_242_35 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_34) / var_242_35

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_34 + var_242_35 and arg_239_1.time_ < var_242_34 + var_242_35 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play1101105059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1101105059
		arg_245_1.duration_ = 11.4

		local var_245_0 = {
			zh = 8.266,
			ja = 11.4
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
				arg_245_0:Play1101105060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1033ui_story = arg_245_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1033ui_story, Vector3.New(-0.7, -1.01, -6.13), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1033ui_story"].transform.position).z)
				arg_245_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1033ui_story"].transform.localEulerAngles = arg_245_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.13)
				arg_245_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1033ui_story"].transform.position).z)
				arg_245_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1033ui_story"].transform.localEulerAngles = arg_245_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1033ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1033ui_story == nil then
				arg_245_1.var_.characterEffect1033ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1033ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1033ui_story then
				arg_245_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_4 = arg_245_1.actors_["1066ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1066ui_story = var_248_4.localPosition
			end

			local var_248_5 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_5 then
				var_248_4.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_245_1.time_ - 0) / var_248_5)
				var_248_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_4.position).x, (manager.ui.mainCamera.transform.position - var_248_4.position).y, (manager.ui.mainCamera.transform.position - var_248_4.position).z)
				var_248_4.localEulerAngles.z = 0
				var_248_4.localEulerAngles.x = 0
				var_248_4.localEulerAngles = var_248_4.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_5 and arg_245_1.time_ < 0 + var_248_5 + arg_248_0 then
				var_248_4.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_248_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_4.position).x, (manager.ui.mainCamera.transform.position - var_248_4.position).y, (manager.ui.mainCamera.transform.position - var_248_4.position).z)
				var_248_4.localEulerAngles.z = 0
				var_248_4.localEulerAngles.x = 0
				var_248_4.localEulerAngles = var_248_4.localEulerAngles
			end

			local var_248_6 = 0
			local var_248_7 = 1.05

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:GetWordFromCfg(1101105059)
				local var_248_9 = arg_245_1:FormatText(var_248_8.content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 42 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_9) / 42)

				if (42 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_9) / 42)) > 0 and var_248_7 < var_248_11 then
					arg_245_1.talkMaxDuration = var_248_11

					if var_248_11 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb") ~= 0 then
					local var_248_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb") / 1000

					if var_248_12 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_6
					end

					if var_248_8.prefab_name ~= "" and arg_245_1.actors_[var_248_8.prefab_name] ~= nil then
						local var_248_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_8.prefab_name].transform, "story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb")

						arg_245_1:RecordAudio("1101105059", var_248_13)
						arg_245_1:RecordAudio("1101105059", var_248_13)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105059", "story_v_side_new_1101105.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_14 and arg_245_1.time_ < var_248_6 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
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

		arg_245_1:InitPlayNodeList()
	end,
	Play1101105060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1101105060
		arg_249_1.duration_ = 8.57

		local var_249_0 = {
			zh = 5.133,
			ja = 8.566
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
				arg_249_0:Play1101105061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_0 = 0
			local var_252_1 = 0.675

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(1101105060)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 27 <= 0 and var_252_1 or var_252_1 * (utf8.len(var_252_3) / 27)

				if (27 <= 0 and var_252_1 or var_252_1 * (utf8.len(var_252_3) / 27)) > 0 and var_252_1 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb") ~= 0 then
					local var_252_6 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb") / 1000

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end

					if var_252_2.prefab_name ~= "" and arg_249_1.actors_[var_252_2.prefab_name] ~= nil then
						local var_252_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_2.prefab_name].transform, "story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb")

						arg_249_1:RecordAudio("1101105060", var_252_7)
						arg_249_1:RecordAudio("1101105060", var_252_7)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105060", "story_v_side_new_1101105.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_8 and arg_249_1.time_ < var_252_0 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1101105061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1101105061
		arg_253_1.duration_ = 4.87

		local var_253_0 = {
			zh = 4.8,
			ja = 4.866
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
				arg_253_0:Play1101105062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1066ui_story = arg_253_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1066ui_story"].transform.position).z)
				arg_253_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1066ui_story"].transform.localEulerAngles = arg_253_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_253_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1066ui_story"].transform.position).z)
				arg_253_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1066ui_story"].transform.localEulerAngles = arg_253_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1066ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1066ui_story == nil then
				arg_253_1.var_.characterEffect1066ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1066ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1066ui_story then
				arg_253_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_4 = arg_253_1.actors_["1033ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1033ui_story == nil then
				arg_253_1.var_.characterEffect1033ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_5 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 and not isNil(var_256_4) then
				if arg_253_1.var_.characterEffect1033ui_story and not isNil(var_256_4) then
					arg_253_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_5)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1033ui_story then
				arg_253_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_256_6 = 0
			local var_256_7 = 0.525

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(1101105061)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 21 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 21)

				if (21 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 21)) > 0 and var_256_7 < var_256_11 then
					arg_253_1.talkMaxDuration = var_256_11

					if var_256_11 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb") ~= 0 then
					local var_256_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb") / 1000

					if var_256_12 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_6
					end

					if var_256_8.prefab_name ~= "" and arg_253_1.actors_[var_256_8.prefab_name] ~= nil then
						local var_256_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_8.prefab_name].transform, "story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb")

						arg_253_1:RecordAudio("1101105061", var_256_13)
						arg_253_1:RecordAudio("1101105061", var_256_13)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105061", "story_v_side_new_1101105.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play1101105062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1101105062
		arg_257_1.duration_ = 14.4

		local var_257_0 = {
			zh = 11.633,
			ja = 14.4
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
				arg_257_0:Play1101105063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.25

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:GetWordFromCfg(1101105062)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 50 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 50)

				if (50 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 50)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb")

						arg_257_1:RecordAudio("1101105062", var_260_6)
						arg_257_1:RecordAudio("1101105062", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105062", "story_v_side_new_1101105.awb")
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
	Play1101105063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1101105063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1101105064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1066ui_story"]) and arg_261_1.var_.characterEffect1066ui_story == nil then
				arg_261_1.var_.characterEffect1066ui_story = arg_261_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1066ui_story"]) then
				if arg_261_1.var_.characterEffect1066ui_story and not isNil(arg_261_1.actors_["1066ui_story"]) then
					arg_261_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1066ui_story"]) and arg_261_1.var_.characterEffect1066ui_story then
				arg_261_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.45

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1101105063).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 18 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 18)

				if (18 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 18)) > 0 and var_264_2 < var_264_5 then
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
	Play1101105064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1101105064
		arg_265_1.duration_ = 4.63

		local var_265_0 = {
			zh = 4.633,
			ja = 4.4
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
				arg_265_0:Play1101105065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1033ui_story = arg_265_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).z)
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles = arg_265_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).z)
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles = arg_265_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1066ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1066ui_story = var_268_1.localPosition
			end

			local var_268_2 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 then
				var_268_1.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_2)
				var_268_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_1.position).x, (manager.ui.mainCamera.transform.position - var_268_1.position).y, (manager.ui.mainCamera.transform.position - var_268_1.position).z)
				var_268_1.localEulerAngles.z = 0
				var_268_1.localEulerAngles.x = 0
				var_268_1.localEulerAngles = var_268_1.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 then
				var_268_1.localPosition = Vector3.New(0, 100, 0)
				var_268_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_1.position).x, (manager.ui.mainCamera.transform.position - var_268_1.position).y, (manager.ui.mainCamera.transform.position - var_268_1.position).z)
				var_268_1.localEulerAngles.z = 0
				var_268_1.localEulerAngles.x = 0
				var_268_1.localEulerAngles = var_268_1.localEulerAngles
			end

			local var_268_3 = arg_265_1.actors_["1011ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1011ui_story = var_268_3.localPosition
			end

			local var_268_4 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				var_268_3.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_265_1.time_ - 0) / var_268_4)
				var_268_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_3.position).x, (manager.ui.mainCamera.transform.position - var_268_3.position).y, (manager.ui.mainCamera.transform.position - var_268_3.position).z)
				var_268_3.localEulerAngles.z = 0
				var_268_3.localEulerAngles.x = 0
				var_268_3.localEulerAngles = var_268_3.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				var_268_3.localPosition = Vector3.New(0, -0.71, -6)
				var_268_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_3.position).x, (manager.ui.mainCamera.transform.position - var_268_3.position).y, (manager.ui.mainCamera.transform.position - var_268_3.position).z)
				var_268_3.localEulerAngles.z = 0
				var_268_3.localEulerAngles.x = 0
				var_268_3.localEulerAngles = var_268_3.localEulerAngles
			end

			local var_268_5 = arg_265_1.actors_["1011ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.characterEffect1011ui_story == nil then
				arg_265_1.var_.characterEffect1011ui_story = var_268_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 and not isNil(var_268_5) then
				if arg_265_1.var_.characterEffect1011ui_story and not isNil(var_268_5) then
					arg_265_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.characterEffect1011ui_story then
				arg_265_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_268_8 = 0
			local var_268_9 = 0.45

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(1101105064)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 18 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 18)

				if (18 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 18)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb")

						arg_265_1:RecordAudio("1101105064", var_268_15)
						arg_265_1:RecordAudio("1101105064", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105064", "story_v_side_new_1101105.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_16 and arg_265_1.time_ < var_268_8 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play1101105065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1101105065
		arg_269_1.duration_ = 11.17

		local var_269_0 = {
			zh = 6.366,
			ja = 11.166
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
				arg_269_0:Play1101105066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1011ui_story = arg_269_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1011ui_story"].transform.position).z)
				arg_269_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1011ui_story"].transform.localEulerAngles = arg_269_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1011ui_story"].transform.position).z)
				arg_269_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1011ui_story"].transform.localEulerAngles = arg_269_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1011ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1011ui_story == nil then
				arg_269_1.var_.characterEffect1011ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1011ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_2)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1011ui_story then
				arg_269_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_272_3 = arg_269_1.actors_["1066ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1066ui_story = var_272_3.localPosition
			end

			local var_272_4 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				var_272_3.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_269_1.time_ - 0) / var_272_4)
				var_272_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_3.position).x, (manager.ui.mainCamera.transform.position - var_272_3.position).y, (manager.ui.mainCamera.transform.position - var_272_3.position).z)
				var_272_3.localEulerAngles.z = 0
				var_272_3.localEulerAngles.x = 0
				var_272_3.localEulerAngles = var_272_3.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				var_272_3.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_272_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_3.position).x, (manager.ui.mainCamera.transform.position - var_272_3.position).y, (manager.ui.mainCamera.transform.position - var_272_3.position).z)
				var_272_3.localEulerAngles.z = 0
				var_272_3.localEulerAngles.x = 0
				var_272_3.localEulerAngles = var_272_3.localEulerAngles
			end

			local var_272_5 = arg_269_1.actors_["1066ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect1066ui_story == nil then
				arg_269_1.var_.characterEffect1066ui_story = var_272_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_6 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_6 and not isNil(var_272_5) then
				if arg_269_1.var_.characterEffect1066ui_story and not isNil(var_272_5) then
					arg_269_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_6 and arg_269_1.time_ < 0 + var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect1066ui_story then
				arg_269_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action8_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_272_8 = arg_269_1.actors_["1033ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1033ui_story = var_272_8.localPosition
			end

			local var_272_9 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_9 then
				var_272_8.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_269_1.time_ - 0) / var_272_9)
				var_272_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_8.position).x, (manager.ui.mainCamera.transform.position - var_272_8.position).y, (manager.ui.mainCamera.transform.position - var_272_8.position).z)
				var_272_8.localEulerAngles.z = 0
				var_272_8.localEulerAngles.x = 0
				var_272_8.localEulerAngles = var_272_8.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_9 and arg_269_1.time_ < 0 + var_272_9 + arg_272_0 then
				var_272_8.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_272_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_8.position).x, (manager.ui.mainCamera.transform.position - var_272_8.position).y, (manager.ui.mainCamera.transform.position - var_272_8.position).z)
				var_272_8.localEulerAngles.z = 0
				var_272_8.localEulerAngles.x = 0
				var_272_8.localEulerAngles = var_272_8.localEulerAngles
			end

			local var_272_10 = arg_269_1.actors_["1033ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_10) and arg_269_1.var_.characterEffect1033ui_story == nil then
				arg_269_1.var_.characterEffect1033ui_story = var_272_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_11 and not isNil(var_272_10) then
				if arg_269_1.var_.characterEffect1033ui_story and not isNil(var_272_10) then
					arg_269_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_11)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_11 and arg_269_1.time_ < 0 + var_272_11 + arg_272_0 and not isNil(var_272_10) and arg_269_1.var_.characterEffect1033ui_story then
				arg_269_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_272_12 = 0
			local var_272_13 = 0.75

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_12 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_14 = arg_269_1:GetWordFromCfg(1101105065)
				local var_272_15 = arg_269_1:FormatText(var_272_14.content)

				arg_269_1.text_.text = var_272_15

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_17 = 30 <= 0 and var_272_13 or var_272_13 * (utf8.len(var_272_15) / 30)

				if (30 <= 0 and var_272_13 or var_272_13 * (utf8.len(var_272_15) / 30)) > 0 and var_272_13 < var_272_17 then
					arg_269_1.talkMaxDuration = var_272_17

					if var_272_17 + var_272_12 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_17 + var_272_12
					end
				end

				arg_269_1.text_.text = var_272_15
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb") ~= 0 then
					local var_272_18 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb") / 1000

					if var_272_18 + var_272_12 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_18 + var_272_12
					end

					if var_272_14.prefab_name ~= "" and arg_269_1.actors_[var_272_14.prefab_name] ~= nil then
						local var_272_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_14.prefab_name].transform, "story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb")

						arg_269_1:RecordAudio("1101105065", var_272_19)
						arg_269_1:RecordAudio("1101105065", var_272_19)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105065", "story_v_side_new_1101105.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_20 = math.max(var_272_13, arg_269_1.talkMaxDuration)

			if var_272_12 <= arg_269_1.time_ and arg_269_1.time_ < var_272_12 + var_272_20 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_12) / var_272_20

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_12 + var_272_20 and arg_269_1.time_ < var_272_12 + var_272_20 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play1101105066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1101105066
		arg_273_1.duration_ = 8.1

		local var_273_0 = {
			zh = 5.9,
			ja = 8.1
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
				arg_273_0:Play1101105067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1066ui_story"]) and arg_273_1.var_.characterEffect1066ui_story == nil then
				arg_273_1.var_.characterEffect1066ui_story = arg_273_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1066ui_story"]) then
				if arg_273_1.var_.characterEffect1066ui_story and not isNil(arg_273_1.actors_["1066ui_story"]) then
					arg_273_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1066ui_story"]) and arg_273_1.var_.characterEffect1066ui_story then
				arg_273_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.6

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(1101105066)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 24 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_4) / 24)

				if (24 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_4) / 24)) > 0 and var_276_2 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb") ~= 0 then
					local var_276_7 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb") / 1000

					if var_276_7 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_1
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb")

						arg_273_1:RecordAudio("1101105066", var_276_8)
						arg_273_1:RecordAudio("1101105066", var_276_8)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105066", "story_v_side_new_1101105.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_9 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_9 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_9

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_9 and arg_273_1.time_ < var_276_1 + var_276_9 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1101105067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1101105067
		arg_277_1.duration_ = 11.9

		local var_277_0 = {
			zh = 6.166,
			ja = 11.9
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
				arg_277_0:Play1101105068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1033ui_story = arg_277_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1033ui_story"].transform.position).z)
				arg_277_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1033ui_story"].transform.localEulerAngles = arg_277_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_277_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1033ui_story"].transform.position).z)
				arg_277_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1033ui_story"].transform.localEulerAngles = arg_277_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1033ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1033ui_story == nil then
				arg_277_1.var_.characterEffect1033ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1033ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1033ui_story then
				arg_277_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action427")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_280_4 = 0
			local var_280_5 = 0.725

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(1101105067)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 29 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 29)

				if (29 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 29)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb")

						arg_277_1:RecordAudio("1101105067", var_280_11)
						arg_277_1:RecordAudio("1101105067", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105067", "story_v_side_new_1101105.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play1101105068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1101105068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1101105069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1066ui_story = arg_281_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1066ui_story"].transform.position).z)
				arg_281_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1066ui_story"].transform.localEulerAngles = arg_281_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1066ui_story"].transform.position).z)
				arg_281_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1066ui_story"].transform.localEulerAngles = arg_281_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1033ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1033ui_story = var_284_1.localPosition
			end

			local var_284_2 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 then
				var_284_1.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_2)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 then
				var_284_1.localPosition = Vector3.New(0, 100, 0)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			local var_284_3 = 0
			local var_284_4 = 0.85

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_3 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(1101105068).content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 34 <= 0 and var_284_4 or var_284_4 * (utf8.len(var_284_5) / 34)

				if (34 <= 0 and var_284_4 or var_284_4 * (utf8.len(var_284_5) / 34)) > 0 and var_284_4 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_3 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_3
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_4, arg_281_1.talkMaxDuration)

			if var_284_3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_3 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_3) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_3 + var_284_8 and arg_281_1.time_ < var_284_3 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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
				actorName = "1033ui_story",
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
	Play1101105069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1101105069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1101105070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.4

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(1101105069).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 16 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 16)

				if (16 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 16)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1101105070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1101105070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1101105071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1011ui_story = arg_289_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1011ui_story"].transform.position).z)
				arg_289_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1011ui_story"].transform.localEulerAngles = arg_289_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_289_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1011ui_story"].transform.position).z)
				arg_289_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1011ui_story"].transform.localEulerAngles = arg_289_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1011ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1011ui_story == nil then
				arg_289_1.var_.characterEffect1011ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1011ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1011ui_story then
				arg_289_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_292_4 = 0
			local var_292_5 = 1.075

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1101105070).content)

				arg_289_1.text_.text = var_292_6

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_8 = 43 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_6) / 43)

				if (43 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_6) / 43)) > 0 and var_292_5 < var_292_8 then
					arg_289_1.talkMaxDuration = var_292_8

					if var_292_8 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_6
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_9 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_9 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_9

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_9 and arg_289_1.time_ < var_292_4 + var_292_9 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1101105071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1101105072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1011ui_story"]) and arg_293_1.var_.characterEffect1011ui_story == nil then
				arg_293_1.var_.characterEffect1011ui_story = arg_293_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1011ui_story"]) then
				if arg_293_1.var_.characterEffect1011ui_story and not isNil(arg_293_1.actors_["1011ui_story"]) then
					arg_293_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1011ui_story"]) and arg_293_1.var_.characterEffect1011ui_story then
				arg_293_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.7

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1101105071).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 28 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 28)

				if (28 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 28)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1101105072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1101105072
		arg_297_1.duration_ = 2

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1101105073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1033ui_story = arg_297_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).z)
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles = arg_297_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_297_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).z)
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles = arg_297_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1033ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1033ui_story == nil then
				arg_297_1.var_.characterEffect1033ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1033ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1033ui_story then
				arg_297_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_300_4 = arg_297_1.actors_["1011ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1011ui_story = var_300_4.localPosition
			end

			local var_300_5 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 then
				var_300_4.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_5)
				var_300_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_4.position).x, (manager.ui.mainCamera.transform.position - var_300_4.position).y, (manager.ui.mainCamera.transform.position - var_300_4.position).z)
				var_300_4.localEulerAngles.z = 0
				var_300_4.localEulerAngles.x = 0
				var_300_4.localEulerAngles = var_300_4.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 then
				var_300_4.localPosition = Vector3.New(0, 100, 0)
				var_300_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_4.position).x, (manager.ui.mainCamera.transform.position - var_300_4.position).y, (manager.ui.mainCamera.transform.position - var_300_4.position).z)
				var_300_4.localEulerAngles.z = 0
				var_300_4.localEulerAngles.x = 0
				var_300_4.localEulerAngles = var_300_4.localEulerAngles
			end

			local var_300_6 = arg_297_1.actors_["1011ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_6) and arg_297_1.var_.characterEffect1011ui_story == nil then
				arg_297_1.var_.characterEffect1011ui_story = var_300_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_7 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 and not isNil(var_300_6) then
				if arg_297_1.var_.characterEffect1011ui_story and not isNil(var_300_6) then
					arg_297_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_7)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 and not isNil(var_300_6) and arg_297_1.var_.characterEffect1011ui_story then
				arg_297_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_300_8 = 0
			local var_300_9 = 0.05

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(1101105072)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 2 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 2)

				if (2 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 2)) > 0 and var_300_9 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_8
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb") / 1000

					if var_300_14 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_8
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb")

						arg_297_1:RecordAudio("1101105072", var_300_15)
						arg_297_1:RecordAudio("1101105072", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105072", "story_v_side_new_1101105.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_16 and arg_297_1.time_ < var_300_8 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1101105073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1101105074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1033ui_story"]) and arg_301_1.var_.characterEffect1033ui_story == nil then
				arg_301_1.var_.characterEffect1033ui_story = arg_301_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1033ui_story"]) then
				if arg_301_1.var_.characterEffect1033ui_story and not isNil(arg_301_1.actors_["1033ui_story"]) then
					arg_301_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_0)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1033ui_story"]) and arg_301_1.var_.characterEffect1033ui_story then
				arg_301_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_304_1 = 0
			local var_304_2 = 0.65

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1101105073).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 26 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 26)

				if (26 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 26)) > 0 and var_304_2 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_6 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_6 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_6

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_6 and arg_301_1.time_ < var_304_1 + var_304_6 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1101105074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1101105074
		arg_305_1.duration_ = 2.33

		local var_305_0 = {
			zh = 2,
			ja = 2.333
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
				arg_305_0:Play1101105075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.1

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(1101105074)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 4 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 4)

				if (4 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 4)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb")

						arg_305_1:RecordAudio("1101105074", var_308_6)
						arg_305_1:RecordAudio("1101105074", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105074", "story_v_side_new_1101105.awb")
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
	Play1101105075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1101105075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1101105076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.1

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
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

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1101105075).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 4 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 4)

				if (4 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 4)) > 0 and var_312_0 < var_312_3 then
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
	Play1101105076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1101105076
		arg_313_1.duration_ = 2.4

		local var_313_0 = {
			zh = 2.4,
			ja = 2.3
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
				arg_313_0:Play1101105077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1011ui_story = arg_313_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1011ui_story"].transform.position).z)
				arg_313_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1011ui_story"].transform.localEulerAngles = arg_313_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_313_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1011ui_story"].transform.position).z)
				arg_313_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1011ui_story"].transform.localEulerAngles = arg_313_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1011ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1011ui_story == nil then
				arg_313_1.var_.characterEffect1011ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1011ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1011ui_story then
				arg_313_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_316_4 = arg_313_1.actors_["1033ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1033ui_story = var_316_4.localPosition
			end

			local var_316_5 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_5 then
				var_316_4.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_5)
				var_316_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_4.position).x, (manager.ui.mainCamera.transform.position - var_316_4.position).y, (manager.ui.mainCamera.transform.position - var_316_4.position).z)
				var_316_4.localEulerAngles.z = 0
				var_316_4.localEulerAngles.x = 0
				var_316_4.localEulerAngles = var_316_4.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_5 and arg_313_1.time_ < 0 + var_316_5 + arg_316_0 then
				var_316_4.localPosition = Vector3.New(0, 100, 0)
				var_316_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_4.position).x, (manager.ui.mainCamera.transform.position - var_316_4.position).y, (manager.ui.mainCamera.transform.position - var_316_4.position).z)
				var_316_4.localEulerAngles.z = 0
				var_316_4.localEulerAngles.x = 0
				var_316_4.localEulerAngles = var_316_4.localEulerAngles
			end

			local var_316_6 = arg_313_1.actors_["1033ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect1033ui_story == nil then
				arg_313_1.var_.characterEffect1033ui_story = var_316_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_7 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 and not isNil(var_316_6) then
				if arg_313_1.var_.characterEffect1033ui_story and not isNil(var_316_6) then
					arg_313_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_7)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect1033ui_story then
				arg_313_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_316_8 = 0
			local var_316_9 = 0.225

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(1101105076)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 9 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 9)

				if (9 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 9)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb")

						arg_313_1:RecordAudio("1101105076", var_316_15)
						arg_313_1:RecordAudio("1101105076", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105076", "story_v_side_new_1101105.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play1101105077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1101105077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1101105078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1033ui_story = arg_317_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).z)
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles = arg_317_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_317_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).z)
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles = arg_317_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1033ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1033ui_story == nil then
				arg_317_1.var_.characterEffect1033ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1033ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1033ui_story then
				arg_317_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_320_4 = arg_317_1.actors_["1011ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1011ui_story = var_320_4.localPosition
			end

			local var_320_5 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_5 then
				var_320_4.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_5)
				var_320_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_4.position).x, (manager.ui.mainCamera.transform.position - var_320_4.position).y, (manager.ui.mainCamera.transform.position - var_320_4.position).z)
				var_320_4.localEulerAngles.z = 0
				var_320_4.localEulerAngles.x = 0
				var_320_4.localEulerAngles = var_320_4.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_5 and arg_317_1.time_ < 0 + var_320_5 + arg_320_0 then
				var_320_4.localPosition = Vector3.New(0, 100, 0)
				var_320_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_4.position).x, (manager.ui.mainCamera.transform.position - var_320_4.position).y, (manager.ui.mainCamera.transform.position - var_320_4.position).z)
				var_320_4.localEulerAngles.z = 0
				var_320_4.localEulerAngles.x = 0
				var_320_4.localEulerAngles = var_320_4.localEulerAngles
			end

			local var_320_6 = arg_317_1.actors_["1011ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_6) and arg_317_1.var_.characterEffect1011ui_story == nil then
				arg_317_1.var_.characterEffect1011ui_story = var_320_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_7 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 and not isNil(var_320_6) then
				if arg_317_1.var_.characterEffect1011ui_story and not isNil(var_320_6) then
					arg_317_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_7)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 and not isNil(var_320_6) and arg_317_1.var_.characterEffect1011ui_story then
				arg_317_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_320_8 = 0
			local var_320_9 = 0.45

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_10 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1101105077).content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_12 = 18 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_10) / 18)

				if (18 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_10) / 18)) > 0 and var_320_9 < var_320_12 then
					arg_317_1.talkMaxDuration = var_320_12

					if var_320_12 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_13 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_13 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_13

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_13 and arg_317_1.time_ < var_320_8 + var_320_13 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1101105078
		arg_321_1.duration_ = 4.2

		local var_321_0 = {
			zh = 3.566,
			ja = 4.2
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
				arg_321_0:Play1101105079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1033ui_story = arg_321_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).z)
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles = arg_321_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_321_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).z)
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles = arg_321_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1033ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1033ui_story == nil then
				arg_321_1.var_.characterEffect1033ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1033ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1033ui_story then
				arg_321_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_2")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_324_4 = arg_321_1.actors_["1011ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1011ui_story = var_324_4.localPosition
			end

			local var_324_5 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_5 then
				var_324_4.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_321_1.time_ - 0) / var_324_5)
				var_324_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_4.position).x, (manager.ui.mainCamera.transform.position - var_324_4.position).y, (manager.ui.mainCamera.transform.position - var_324_4.position).z)
				var_324_4.localEulerAngles.z = 0
				var_324_4.localEulerAngles.x = 0
				var_324_4.localEulerAngles = var_324_4.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_5 and arg_321_1.time_ < 0 + var_324_5 + arg_324_0 then
				var_324_4.localPosition = Vector3.New(0, 100, 0)
				var_324_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_4.position).x, (manager.ui.mainCamera.transform.position - var_324_4.position).y, (manager.ui.mainCamera.transform.position - var_324_4.position).z)
				var_324_4.localEulerAngles.z = 0
				var_324_4.localEulerAngles.x = 0
				var_324_4.localEulerAngles = var_324_4.localEulerAngles
			end

			local var_324_6 = arg_321_1.actors_["1011ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect1011ui_story == nil then
				arg_321_1.var_.characterEffect1011ui_story = var_324_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_7 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 and not isNil(var_324_6) then
				if arg_321_1.var_.characterEffect1011ui_story and not isNil(var_324_6) then
					arg_321_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_7)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect1011ui_story then
				arg_321_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_324_8 = 0
			local var_324_9 = 0.325

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_10 = arg_321_1:GetWordFromCfg(1101105078)
				local var_324_11 = arg_321_1:FormatText(var_324_10.content)

				arg_321_1.text_.text = var_324_11

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_13 = 13 <= 0 and var_324_9 or var_324_9 * (utf8.len(var_324_11) / 13)

				if (13 <= 0 and var_324_9 or var_324_9 * (utf8.len(var_324_11) / 13)) > 0 and var_324_9 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_8
					end
				end

				arg_321_1.text_.text = var_324_11
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb") ~= 0 then
					local var_324_14 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb") / 1000

					if var_324_14 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_14 + var_324_8
					end

					if var_324_10.prefab_name ~= "" and arg_321_1.actors_[var_324_10.prefab_name] ~= nil then
						local var_324_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_10.prefab_name].transform, "story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb")

						arg_321_1:RecordAudio("1101105078", var_324_15)
						arg_321_1:RecordAudio("1101105078", var_324_15)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105078", "story_v_side_new_1101105.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_16 = math.max(var_324_9, arg_321_1.talkMaxDuration)

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_16 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_8) / var_324_16

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_8 + var_324_16 and arg_321_1.time_ < var_324_8 + var_324_16 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1101105079
		arg_325_1.duration_ = 3.17

		local var_325_0 = {
			zh = 3.166,
			ja = 2.866
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
				arg_325_0:Play1101105080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1033ui_story = arg_325_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1033ui_story"].transform.position).z)
				arg_325_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1033ui_story"].transform.localEulerAngles = arg_325_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1033ui_story"].transform.position).z)
				arg_325_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1033ui_story"].transform.localEulerAngles = arg_325_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1033ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1033ui_story == nil then
				arg_325_1.var_.characterEffect1033ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1033ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_2)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1033ui_story then
				arg_325_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_328_3 = arg_325_1.actors_["1011ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1011ui_story = var_328_3.localPosition
			end

			local var_328_4 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				var_328_3.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_325_1.time_ - 0) / var_328_4)
				var_328_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_3.position).x, (manager.ui.mainCamera.transform.position - var_328_3.position).y, (manager.ui.mainCamera.transform.position - var_328_3.position).z)
				var_328_3.localEulerAngles.z = 0
				var_328_3.localEulerAngles.x = 0
				var_328_3.localEulerAngles = var_328_3.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				var_328_3.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_328_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_3.position).x, (manager.ui.mainCamera.transform.position - var_328_3.position).y, (manager.ui.mainCamera.transform.position - var_328_3.position).z)
				var_328_3.localEulerAngles.z = 0
				var_328_3.localEulerAngles.x = 0
				var_328_3.localEulerAngles = var_328_3.localEulerAngles
			end

			local var_328_5 = arg_325_1.actors_["1011ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_5) and arg_325_1.var_.characterEffect1011ui_story == nil then
				arg_325_1.var_.characterEffect1011ui_story = var_328_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_6 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_6 and not isNil(var_328_5) then
				if arg_325_1.var_.characterEffect1011ui_story and not isNil(var_328_5) then
					arg_325_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_6 and arg_325_1.time_ < 0 + var_328_6 + arg_328_0 and not isNil(var_328_5) and arg_325_1.var_.characterEffect1011ui_story then
				arg_325_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_328_8 = "1111ui_story"

			if arg_325_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_328_9 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_325_1.stage_.transform)

				var_328_9.name = var_328_8
				var_328_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.actors_[var_328_8] = var_328_9

				local var_328_10 = var_328_9:GetComponentInChildren(typeof(CharacterEffect))

				var_328_10.enabled = true

				local var_328_11 = GameObjectTools.GetOrAddComponent(var_328_9, typeof(DynamicBoneHelper))

				if var_328_11 then
					var_328_11:EnableDynamicBone(false)
				end

				arg_325_1:ShowWeapon(var_328_10.transform, false)

				arg_325_1.var_[var_328_8 .. "Animator"] = var_328_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_325_1.var_[var_328_8 .. "Animator"].applyRootMotion = true
				arg_325_1.var_[var_328_8 .. "LipSync"] = var_328_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_328_12 = arg_325_1.actors_["1111ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1111ui_story = var_328_12.localPosition
			end

			local var_328_13 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_13 then
				var_328_12.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.7, -6), (arg_325_1.time_ - 0) / var_328_13)
				var_328_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_12.position).x, (manager.ui.mainCamera.transform.position - var_328_12.position).y, (manager.ui.mainCamera.transform.position - var_328_12.position).z)
				var_328_12.localEulerAngles.z = 0
				var_328_12.localEulerAngles.x = 0
				var_328_12.localEulerAngles = var_328_12.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_13 and arg_325_1.time_ < 0 + var_328_13 + arg_328_0 then
				var_328_12.localPosition = Vector3.New(0.7, -0.7, -6)
				var_328_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_12.position).x, (manager.ui.mainCamera.transform.position - var_328_12.position).y, (manager.ui.mainCamera.transform.position - var_328_12.position).z)
				var_328_12.localEulerAngles.z = 0
				var_328_12.localEulerAngles.x = 0
				var_328_12.localEulerAngles = var_328_12.localEulerAngles
			end

			local var_328_14 = arg_325_1.actors_["1111ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_14) and arg_325_1.var_.characterEffect1111ui_story == nil then
				arg_325_1.var_.characterEffect1111ui_story = var_328_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_15 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_15 and not isNil(var_328_14) then
				if arg_325_1.var_.characterEffect1111ui_story and not isNil(var_328_14) then
					arg_325_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_15 and arg_325_1.time_ < 0 + var_328_15 + arg_328_0 and not isNil(var_328_14) and arg_325_1.var_.characterEffect1111ui_story then
				arg_325_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_328_17 = 0
			local var_328_18 = 0.325

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_17 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[582].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_19 = arg_325_1:GetWordFromCfg(1101105079)
				local var_328_20 = arg_325_1:FormatText(var_328_19.content)

				arg_325_1.text_.text = var_328_20

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_22 = 13 <= 0 and var_328_18 or var_328_18 * (utf8.len(var_328_20) / 13)

				if (13 <= 0 and var_328_18 or var_328_18 * (utf8.len(var_328_20) / 13)) > 0 and var_328_18 < var_328_22 then
					arg_325_1.talkMaxDuration = var_328_22

					if var_328_22 + var_328_17 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_22 + var_328_17
					end
				end

				arg_325_1.text_.text = var_328_20
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb") ~= 0 then
					local var_328_23 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb") / 1000

					if var_328_23 + var_328_17 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_23 + var_328_17
					end

					if var_328_19.prefab_name ~= "" and arg_325_1.actors_[var_328_19.prefab_name] ~= nil then
						local var_328_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_19.prefab_name].transform, "story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb")

						arg_325_1:RecordAudio("1101105079", var_328_24)
						arg_325_1:RecordAudio("1101105079", var_328_24)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105079", "story_v_side_new_1101105.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_25 = math.max(var_328_18, arg_325_1.talkMaxDuration)

			if var_328_17 <= arg_325_1.time_ and arg_325_1.time_ < var_328_17 + var_328_25 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_17) / var_328_25

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_17 + var_328_25 and arg_325_1.time_ < var_328_17 + var_328_25 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play1101105080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1101105080
		arg_329_1.duration_ = 7.3

		local var_329_0 = {
			zh = 5.999999999999,
			ja = 7.3
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
				arg_329_0:Play1101105081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 2 < arg_329_1.time_ and arg_329_1.time_ <= 2 + arg_332_0 then
				local var_332_0 = arg_329_1.bgs_.D999

				arg_329_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_332_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_1 = var_332_0:GetComponent("SpriteRenderer")

				if var_332_1 and var_332_1.sprite then
					local var_332_2 = 2 * (var_332_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_332_0.transform.localScale = Vector3.New(var_332_2 / var_332_1.sprite.bounds.size.y < var_332_2 * manager.ui.mainCameraCom_.aspect / var_332_1.sprite.bounds.size.x and var_332_2 * manager.ui.mainCameraCom_.aspect / var_332_1.sprite.bounds.size.x or var_332_2 / var_332_1.sprite.bounds.size.y, var_332_2 / var_332_1.sprite.bounds.size.y < var_332_2 * manager.ui.mainCameraCom_.aspect / var_332_1.sprite.bounds.size.x and var_332_2 * manager.ui.mainCameraCom_.aspect / var_332_1.sprite.bounds.size.x or var_332_2 / var_332_1.sprite.bounds.size.y, 0)
				end

				for iter_332_0, iter_332_1 in pairs(arg_329_1.bgs_) do
					if iter_332_0 ~= "D999" then
						iter_332_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_332_3 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_4 = 2

			if var_332_3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_3 + var_332_4 then
				local var_332_5 = Color.New(0, 0, 0)

				var_332_5.a = Mathf.Lerp(0, 1, (arg_329_1.time_ - var_332_3) / var_332_4)
				arg_329_1.mask_.color = var_332_5
			end

			if arg_329_1.time_ >= var_332_3 + var_332_4 and arg_329_1.time_ < var_332_3 + var_332_4 + arg_332_0 then
				local var_332_6 = Color.New(0, 0, 0)

				var_332_6.a = 1
				arg_329_1.mask_.color = var_332_6
			end

			local var_332_7 = 2

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= var_332_7 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_8 = 2

			if var_332_7 <= arg_329_1.time_ and arg_329_1.time_ < var_332_7 + var_332_8 then
				local var_332_9 = Color.New(0, 0, 0)

				var_332_9.a = Mathf.Lerp(1, 0, (arg_329_1.time_ - var_332_7) / var_332_8)
				arg_329_1.mask_.color = var_332_9
			end

			if arg_329_1.time_ >= var_332_7 + var_332_8 and arg_329_1.time_ < var_332_7 + var_332_8 + arg_332_0 then
				local var_332_10 = Color.New(0, 0, 0)

				arg_329_1.mask_.enabled = false
				var_332_10.a = 0
				arg_329_1.mask_.color = var_332_10
			end

			local var_332_11 = arg_329_1.actors_["1111ui_story"].transform

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= 4 + arg_332_0 then
				arg_329_1.var_.moveOldPos1111ui_story = var_332_11.localPosition
			end

			local var_332_12 = 0.001

			if 4 <= arg_329_1.time_ and arg_329_1.time_ < 4 + var_332_12 then
				var_332_11.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_329_1.time_ - 4) / var_332_12)
				var_332_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_11.position).x, (manager.ui.mainCamera.transform.position - var_332_11.position).y, (manager.ui.mainCamera.transform.position - var_332_11.position).z)
				var_332_11.localEulerAngles.z = 0
				var_332_11.localEulerAngles.x = 0
				var_332_11.localEulerAngles = var_332_11.localEulerAngles
			end

			if arg_329_1.time_ >= 4 + var_332_12 and arg_329_1.time_ < 4 + var_332_12 + arg_332_0 then
				var_332_11.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_332_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_11.position).x, (manager.ui.mainCamera.transform.position - var_332_11.position).y, (manager.ui.mainCamera.transform.position - var_332_11.position).z)
				var_332_11.localEulerAngles.z = 0
				var_332_11.localEulerAngles.x = 0
				var_332_11.localEulerAngles = var_332_11.localEulerAngles
			end

			local var_332_13 = arg_329_1.actors_["1111ui_story"]

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= 4 + arg_332_0 and not isNil(var_332_13) and arg_329_1.var_.characterEffect1111ui_story == nil then
				arg_329_1.var_.characterEffect1111ui_story = var_332_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_14 = 0.200000002980232

			if 4 <= arg_329_1.time_ and arg_329_1.time_ < 4 + var_332_14 and not isNil(var_332_13) then
				if arg_329_1.var_.characterEffect1111ui_story and not isNil(var_332_13) then
					arg_329_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 4 + var_332_14 and arg_329_1.time_ < 4 + var_332_14 + arg_332_0 and not isNil(var_332_13) and arg_329_1.var_.characterEffect1111ui_story then
				arg_329_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= 4 + arg_332_0 then
				arg_329_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= 4 + arg_332_0 then
				arg_329_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_332_16 = arg_329_1.actors_["1011ui_story"].transform

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= 2 + arg_332_0 then
				arg_329_1.var_.moveOldPos1011ui_story = var_332_16.localPosition
			end

			local var_332_17 = 0.001

			if 2 <= arg_329_1.time_ and arg_329_1.time_ < 2 + var_332_17 then
				var_332_16.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 2) / var_332_17)
				var_332_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_16.position).x, (manager.ui.mainCamera.transform.position - var_332_16.position).y, (manager.ui.mainCamera.transform.position - var_332_16.position).z)
				var_332_16.localEulerAngles.z = 0
				var_332_16.localEulerAngles.x = 0
				var_332_16.localEulerAngles = var_332_16.localEulerAngles
			end

			if arg_329_1.time_ >= 2 + var_332_17 and arg_329_1.time_ < 2 + var_332_17 + arg_332_0 then
				var_332_16.localPosition = Vector3.New(0, 100, 0)
				var_332_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_16.position).x, (manager.ui.mainCamera.transform.position - var_332_16.position).y, (manager.ui.mainCamera.transform.position - var_332_16.position).z)
				var_332_16.localEulerAngles.z = 0
				var_332_16.localEulerAngles.x = 0
				var_332_16.localEulerAngles = var_332_16.localEulerAngles
			end

			local var_332_18 = arg_329_1.actors_["1111ui_story"].transform

			if 2 < arg_329_1.time_ and arg_329_1.time_ <= 2 + arg_332_0 then
				arg_329_1.var_.moveOldPos1111ui_story = var_332_18.localPosition
			end

			local var_332_19 = 0.001

			if 2 <= arg_329_1.time_ and arg_329_1.time_ < 2 + var_332_19 then
				var_332_18.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 2) / var_332_19)
				var_332_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_18.position).x, (manager.ui.mainCamera.transform.position - var_332_18.position).y, (manager.ui.mainCamera.transform.position - var_332_18.position).z)
				var_332_18.localEulerAngles.z = 0
				var_332_18.localEulerAngles.x = 0
				var_332_18.localEulerAngles = var_332_18.localEulerAngles
			end

			if arg_329_1.time_ >= 2 + var_332_19 and arg_329_1.time_ < 2 + var_332_19 + arg_332_0 then
				var_332_18.localPosition = Vector3.New(0, 100, 0)
				var_332_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_18.position).x, (manager.ui.mainCamera.transform.position - var_332_18.position).y, (manager.ui.mainCamera.transform.position - var_332_18.position).z)
				var_332_18.localEulerAngles.z = 0
				var_332_18.localEulerAngles.x = 0
				var_332_18.localEulerAngles = var_332_18.localEulerAngles
			end

			local var_332_20 = arg_329_1.actors_["1011ui_story"].transform

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= 4 + arg_332_0 then
				arg_329_1.var_.moveOldPos1011ui_story = var_332_20.localPosition
			end

			local var_332_21 = 0.001

			if 4 <= arg_329_1.time_ and arg_329_1.time_ < 4 + var_332_21 then
				var_332_20.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_329_1.time_ - 4) / var_332_21)
				var_332_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_20.position).x, (manager.ui.mainCamera.transform.position - var_332_20.position).y, (manager.ui.mainCamera.transform.position - var_332_20.position).z)
				var_332_20.localEulerAngles.z = 0
				var_332_20.localEulerAngles.x = 0
				var_332_20.localEulerAngles = var_332_20.localEulerAngles
			end

			if arg_329_1.time_ >= 4 + var_332_21 and arg_329_1.time_ < 4 + var_332_21 + arg_332_0 then
				var_332_20.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_332_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_20.position).x, (manager.ui.mainCamera.transform.position - var_332_20.position).y, (manager.ui.mainCamera.transform.position - var_332_20.position).z)
				var_332_20.localEulerAngles.z = 0
				var_332_20.localEulerAngles.x = 0
				var_332_20.localEulerAngles = var_332_20.localEulerAngles
			end

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= 4 + arg_332_0 then
				arg_329_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= 4 + arg_332_0 then
				arg_329_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_22 = 4
			local var_332_23 = 0.125

			if 4 < arg_329_1.time_ and arg_329_1.time_ <= var_332_22 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_24 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_24:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_329_1.dialogCg_.alpha = arg_333_0
				end))
				var_332_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_25 = arg_329_1:GetWordFromCfg(1101105080)
				local var_332_26 = arg_329_1:FormatText(var_332_25.content)

				arg_329_1.text_.text = var_332_26

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_28 = 5 <= 0 and var_332_23 or var_332_23 * (utf8.len(var_332_26) / 5)

				if (5 <= 0 and var_332_23 or var_332_23 * (utf8.len(var_332_26) / 5)) > 0 and var_332_23 < var_332_28 then
					arg_329_1.talkMaxDuration = var_332_28
					var_332_22 = var_332_22 + 0.3

					if var_332_28 + var_332_22 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_28 + var_332_22
					end
				end

				arg_329_1.text_.text = var_332_26
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb") ~= 0 then
					local var_332_29 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb") / 1000

					if var_332_29 + var_332_22 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_29 + var_332_22
					end

					if var_332_25.prefab_name ~= "" and arg_329_1.actors_[var_332_25.prefab_name] ~= nil then
						local var_332_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_25.prefab_name].transform, "story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb")

						arg_329_1:RecordAudio("1101105080", var_332_30)
						arg_329_1:RecordAudio("1101105080", var_332_30)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105080", "story_v_side_new_1101105.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_31 = var_332_22 + 0.3
			local var_332_32 = math.max(var_332_23, arg_329_1.talkMaxDuration)

			if var_332_22 + 0.3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_31 + var_332_32 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_31) / var_332_32

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_31 + var_332_32 and arg_329_1.time_ < var_332_31 + var_332_32 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play1101105081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1101105081
		arg_335_1.duration_ = 3.4

		local var_335_0 = {
			zh = 2.933,
			ja = 3.4
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1101105082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1011ui_story = arg_335_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1011ui_story"].transform.position).z)
				arg_335_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1011ui_story"].transform.localEulerAngles = arg_335_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_335_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1011ui_story"].transform.position).z)
				arg_335_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1011ui_story"].transform.localEulerAngles = arg_335_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1011ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1011ui_story == nil then
				arg_335_1.var_.characterEffect1011ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect1011ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1011ui_story then
				arg_335_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_338_4 = arg_335_1.actors_["1111ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_4) and arg_335_1.var_.characterEffect1111ui_story == nil then
				arg_335_1.var_.characterEffect1111ui_story = var_338_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_5 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_5 and not isNil(var_338_4) then
				if arg_335_1.var_.characterEffect1111ui_story and not isNil(var_338_4) then
					arg_335_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_5)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_5 and arg_335_1.time_ < 0 + var_338_5 + arg_338_0 and not isNil(var_338_4) and arg_335_1.var_.characterEffect1111ui_story then
				arg_335_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_338_6 = 0
			local var_338_7 = 0.175

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_6 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_8 = arg_335_1:GetWordFromCfg(1101105081)
				local var_338_9 = arg_335_1:FormatText(var_338_8.content)

				arg_335_1.text_.text = var_338_9

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_11 = 7 <= 0 and var_338_7 or var_338_7 * (utf8.len(var_338_9) / 7)

				if (7 <= 0 and var_338_7 or var_338_7 * (utf8.len(var_338_9) / 7)) > 0 and var_338_7 < var_338_11 then
					arg_335_1.talkMaxDuration = var_338_11

					if var_338_11 + var_338_6 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_6
					end
				end

				arg_335_1.text_.text = var_338_9
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb") ~= 0 then
					local var_338_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb") / 1000

					if var_338_12 + var_338_6 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_12 + var_338_6
					end

					if var_338_8.prefab_name ~= "" and arg_335_1.actors_[var_338_8.prefab_name] ~= nil then
						local var_338_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_8.prefab_name].transform, "story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb")

						arg_335_1:RecordAudio("1101105081", var_338_13)
						arg_335_1:RecordAudio("1101105081", var_338_13)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105081", "story_v_side_new_1101105.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_14 = math.max(var_338_7, arg_335_1.talkMaxDuration)

			if var_338_6 <= arg_335_1.time_ and arg_335_1.time_ < var_338_6 + var_338_14 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_6) / var_338_14

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_6 + var_338_14 and arg_335_1.time_ < var_338_6 + var_338_14 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play1101105082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1101105082
		arg_339_1.duration_ = 5.67

		local var_339_0 = {
			zh = 4.166,
			ja = 5.666
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1101105083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1111ui_story = arg_339_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1111ui_story"].transform.position).z)
				arg_339_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1111ui_story"].transform.localEulerAngles = arg_339_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_339_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1111ui_story"].transform.position).z)
				arg_339_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1111ui_story"].transform.localEulerAngles = arg_339_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1111ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1111ui_story == nil then
				arg_339_1.var_.characterEffect1111ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1111ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1111ui_story then
				arg_339_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_342_4 = arg_339_1.actors_["1011ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_4) and arg_339_1.var_.characterEffect1011ui_story == nil then
				arg_339_1.var_.characterEffect1011ui_story = var_342_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_5 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_5 and not isNil(var_342_4) then
				if arg_339_1.var_.characterEffect1011ui_story and not isNil(var_342_4) then
					arg_339_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_5)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_5 and arg_339_1.time_ < 0 + var_342_5 + arg_342_0 and not isNil(var_342_4) and arg_339_1.var_.characterEffect1011ui_story then
				arg_339_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_342_6 = 0
			local var_342_7 = 0.825

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_8 = arg_339_1:GetWordFromCfg(1101105082)
				local var_342_9 = arg_339_1:FormatText(var_342_8.content)

				arg_339_1.text_.text = var_342_9

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_11 = 33 <= 0 and var_342_7 or var_342_7 * (utf8.len(var_342_9) / 33)

				if (33 <= 0 and var_342_7 or var_342_7 * (utf8.len(var_342_9) / 33)) > 0 and var_342_7 < var_342_11 then
					arg_339_1.talkMaxDuration = var_342_11

					if var_342_11 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_9
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb") ~= 0 then
					local var_342_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb") / 1000

					if var_342_12 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_6
					end

					if var_342_8.prefab_name ~= "" and arg_339_1.actors_[var_342_8.prefab_name] ~= nil then
						local var_342_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_8.prefab_name].transform, "story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb")

						arg_339_1:RecordAudio("1101105082", var_342_13)
						arg_339_1:RecordAudio("1101105082", var_342_13)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105082", "story_v_side_new_1101105.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_14 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_14 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_14

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_14 and arg_339_1.time_ < var_342_6 + var_342_14 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play1101105083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1101105083
		arg_343_1.duration_ = 9

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1101105084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if arg_343_1.bgs_.STblack == nil then
				local var_346_0 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_346_0.name = "STblack"
				var_346_0.transform.parent = arg_343_1.stage_.transform
				var_346_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_.STblack = var_346_0
			end

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				local var_346_1 = arg_343_1.bgs_.STblack

				arg_343_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_346_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_2 = var_346_1:GetComponent("SpriteRenderer")

				if var_346_2 and var_346_2.sprite then
					local var_346_3 = 2 * (var_346_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_346_1.transform.localScale = Vector3.New(var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "STblack" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_4 = arg_343_1.actors_["1011ui_story"].transform

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.var_.moveOldPos1011ui_story = var_346_4.localPosition
			end

			local var_346_5 = 0.001

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_5 then
				var_346_4.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 2) / var_346_5)
				var_346_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_4.position).x, (manager.ui.mainCamera.transform.position - var_346_4.position).y, (manager.ui.mainCamera.transform.position - var_346_4.position).z)
				var_346_4.localEulerAngles.z = 0
				var_346_4.localEulerAngles.x = 0
				var_346_4.localEulerAngles = var_346_4.localEulerAngles
			end

			if arg_343_1.time_ >= 2 + var_346_5 and arg_343_1.time_ < 2 + var_346_5 + arg_346_0 then
				var_346_4.localPosition = Vector3.New(0, 100, 0)
				var_346_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_4.position).x, (manager.ui.mainCamera.transform.position - var_346_4.position).y, (manager.ui.mainCamera.transform.position - var_346_4.position).z)
				var_346_4.localEulerAngles.z = 0
				var_346_4.localEulerAngles.x = 0
				var_346_4.localEulerAngles = var_346_4.localEulerAngles
			end

			local var_346_6 = arg_343_1.actors_["1111ui_story"].transform

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.var_.moveOldPos1111ui_story = var_346_6.localPosition
			end

			local var_346_7 = 0.001

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_7 then
				var_346_6.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 2) / var_346_7)
				var_346_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_6.position).x, (manager.ui.mainCamera.transform.position - var_346_6.position).y, (manager.ui.mainCamera.transform.position - var_346_6.position).z)
				var_346_6.localEulerAngles.z = 0
				var_346_6.localEulerAngles.x = 0
				var_346_6.localEulerAngles = var_346_6.localEulerAngles
			end

			if arg_343_1.time_ >= 2 + var_346_7 and arg_343_1.time_ < 2 + var_346_7 + arg_346_0 then
				var_346_6.localPosition = Vector3.New(0, 100, 0)
				var_346_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_6.position).x, (manager.ui.mainCamera.transform.position - var_346_6.position).y, (manager.ui.mainCamera.transform.position - var_346_6.position).z)
				var_346_6.localEulerAngles.z = 0
				var_346_6.localEulerAngles.x = 0
				var_346_6.localEulerAngles = var_346_6.localEulerAngles
			end

			local var_346_8 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_9 = 2

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_9 then
				local var_346_10 = Color.New(0, 0, 0)

				var_346_10.a = Mathf.Lerp(0, 1, (arg_343_1.time_ - var_346_8) / var_346_9)
				arg_343_1.mask_.color = var_346_10
			end

			if arg_343_1.time_ >= var_346_8 + var_346_9 and arg_343_1.time_ < var_346_8 + var_346_9 + arg_346_0 then
				local var_346_11 = Color.New(0, 0, 0)

				var_346_11.a = 1
				arg_343_1.mask_.color = var_346_11
			end

			local var_346_12 = 2

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_12 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_13 = 2

			if var_346_12 <= arg_343_1.time_ and arg_343_1.time_ < var_346_12 + var_346_13 then
				local var_346_14 = Color.New(0, 0, 0)

				var_346_14.a = Mathf.Lerp(1, 0, (arg_343_1.time_ - var_346_12) / var_346_13)
				arg_343_1.mask_.color = var_346_14
			end

			if arg_343_1.time_ >= var_346_12 + var_346_13 and arg_343_1.time_ < var_346_12 + var_346_13 + arg_346_0 then
				local var_346_15 = Color.New(0, 0, 0)

				arg_343_1.mask_.enabled = false
				var_346_15.a = 0
				arg_343_1.mask_.color = var_346_15
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_16 = 4
			local var_346_17 = 0.05

			if 4 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_18 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_18:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_343_1.dialogCg_.alpha = arg_347_0
				end))
				var_346_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_19 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1101105083).content)

				arg_343_1.text_.text = var_346_19

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_21 = 2 <= 0 and var_346_17 or var_346_17 * (utf8.len(var_346_19) / 2)

				if (2 <= 0 and var_346_17 or var_346_17 * (utf8.len(var_346_19) / 2)) > 0 and var_346_17 < var_346_21 then
					arg_343_1.talkMaxDuration = var_346_21
					var_346_16 = var_346_16 + 0.3

					if var_346_21 + var_346_16 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_21 + var_346_16
					end
				end

				arg_343_1.text_.text = var_346_19
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_22 = var_346_16 + 0.3
			local var_346_23 = math.max(var_346_17, arg_343_1.talkMaxDuration)

			if var_346_16 + 0.3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_22 + var_346_23 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_22) / var_346_23

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_22 + var_346_23 and arg_343_1.time_ < var_346_22 + var_346_23 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play1101105084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1101105084
		arg_349_1.duration_ = 6.43

		local var_349_0 = {
			zh = 4.933,
			ja = 6.433
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
				arg_349_0:Play1101105085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				local var_352_0 = arg_349_1.bgs_.D999

				arg_349_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_352_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_352_1 = var_352_0:GetComponent("SpriteRenderer")

				if var_352_1 and var_352_1.sprite then
					local var_352_2 = 2 * (var_352_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_352_0.transform.localScale = Vector3.New(var_352_2 / var_352_1.sprite.bounds.size.y < var_352_2 * manager.ui.mainCameraCom_.aspect / var_352_1.sprite.bounds.size.x and var_352_2 * manager.ui.mainCameraCom_.aspect / var_352_1.sprite.bounds.size.x or var_352_2 / var_352_1.sprite.bounds.size.y, var_352_2 / var_352_1.sprite.bounds.size.y < var_352_2 * manager.ui.mainCameraCom_.aspect / var_352_1.sprite.bounds.size.x and var_352_2 * manager.ui.mainCameraCom_.aspect / var_352_1.sprite.bounds.size.x or var_352_2 / var_352_1.sprite.bounds.size.y, 0)
				end

				for iter_352_0, iter_352_1 in pairs(arg_349_1.bgs_) do
					if iter_352_0 ~= "D999" then
						iter_352_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_352_3 = arg_349_1.actors_["1011ui_story"].transform

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= 2 + arg_352_0 then
				arg_349_1.var_.moveOldPos1011ui_story = var_352_3.localPosition
			end

			local var_352_4 = 0.001

			if 2 <= arg_349_1.time_ and arg_349_1.time_ < 2 + var_352_4 then
				var_352_3.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_349_1.time_ - 2) / var_352_4)
				var_352_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_3.position).x, (manager.ui.mainCamera.transform.position - var_352_3.position).y, (manager.ui.mainCamera.transform.position - var_352_3.position).z)
				var_352_3.localEulerAngles.z = 0
				var_352_3.localEulerAngles.x = 0
				var_352_3.localEulerAngles = var_352_3.localEulerAngles
			end

			if arg_349_1.time_ >= 2 + var_352_4 and arg_349_1.time_ < 2 + var_352_4 + arg_352_0 then
				var_352_3.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_352_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_3.position).x, (manager.ui.mainCamera.transform.position - var_352_3.position).y, (manager.ui.mainCamera.transform.position - var_352_3.position).z)
				var_352_3.localEulerAngles.z = 0
				var_352_3.localEulerAngles.x = 0
				var_352_3.localEulerAngles = var_352_3.localEulerAngles
			end

			local var_352_5 = arg_349_1.actors_["1011ui_story"]

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= 2 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect1011ui_story == nil then
				arg_349_1.var_.characterEffect1011ui_story = var_352_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_6 = 0.200000002980232

			if 2 <= arg_349_1.time_ and arg_349_1.time_ < 2 + var_352_6 and not isNil(var_352_5) then
				if arg_349_1.var_.characterEffect1011ui_story and not isNil(var_352_5) then
					arg_349_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 2 + var_352_6 and arg_349_1.time_ < 2 + var_352_6 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect1011ui_story then
				arg_349_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= 2 + arg_352_0 then
				arg_349_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_352_8 = 0

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
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

			local var_352_12 = 2
			local var_352_13 = 0.2

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= var_352_12 + arg_352_0 then
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

				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_15 = arg_349_1:GetWordFromCfg(1101105084)
				local var_352_16 = arg_349_1:FormatText(var_352_15.content)

				arg_349_1.text_.text = var_352_16

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_18 = 8 <= 0 and var_352_13 or var_352_13 * (utf8.len(var_352_16) / 8)

				if (8 <= 0 and var_352_13 or var_352_13 * (utf8.len(var_352_16) / 8)) > 0 and var_352_13 < var_352_18 then
					arg_349_1.talkMaxDuration = var_352_18
					var_352_12 = var_352_12 + 0.3

					if var_352_18 + var_352_12 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_18 + var_352_12
					end
				end

				arg_349_1.text_.text = var_352_16
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb") ~= 0 then
					local var_352_19 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb") / 1000

					if var_352_19 + var_352_12 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_19 + var_352_12
					end

					if var_352_15.prefab_name ~= "" and arg_349_1.actors_[var_352_15.prefab_name] ~= nil then
						local var_352_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_15.prefab_name].transform, "story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb")

						arg_349_1:RecordAudio("1101105084", var_352_20)
						arg_349_1:RecordAudio("1101105084", var_352_20)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105084", "story_v_side_new_1101105.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_21 = var_352_12 + 0.3
			local var_352_22 = math.max(var_352_13, arg_349_1.talkMaxDuration)

			if var_352_12 + 0.3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_21 + var_352_22 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_21) / var_352_22

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_21 + var_352_22 and arg_349_1.time_ < var_352_21 + var_352_22 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1101105085
		arg_355_1.duration_ = 9.43

		local var_355_0 = {
			zh = 7.4,
			ja = 9.433
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
				arg_355_0:Play1101105086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1111ui_story = arg_355_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).z)
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles = arg_355_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_355_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).z)
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles = arg_355_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_358_1 = arg_355_1.actors_["1111ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1111ui_story == nil then
				arg_355_1.var_.characterEffect1111ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect1111ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1111ui_story then
				arg_355_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_358_4 = arg_355_1.actors_["1011ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_4) and arg_355_1.var_.characterEffect1011ui_story == nil then
				arg_355_1.var_.characterEffect1011ui_story = var_358_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_5 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_5 and not isNil(var_358_4) then
				if arg_355_1.var_.characterEffect1011ui_story and not isNil(var_358_4) then
					arg_355_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_5)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_5 and arg_355_1.time_ < 0 + var_358_5 + arg_358_0 and not isNil(var_358_4) and arg_355_1.var_.characterEffect1011ui_story then
				arg_355_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_358_6 = 0
			local var_358_7 = 0.8

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_8 = arg_355_1:GetWordFromCfg(1101105085)
				local var_358_9 = arg_355_1:FormatText(var_358_8.content)

				arg_355_1.text_.text = var_358_9

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_11 = 32 <= 0 and var_358_7 or var_358_7 * (utf8.len(var_358_9) / 32)

				if (32 <= 0 and var_358_7 or var_358_7 * (utf8.len(var_358_9) / 32)) > 0 and var_358_7 < var_358_11 then
					arg_355_1.talkMaxDuration = var_358_11

					if var_358_11 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_11 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_9
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb") ~= 0 then
					local var_358_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb") / 1000

					if var_358_12 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_12 + var_358_6
					end

					if var_358_8.prefab_name ~= "" and arg_355_1.actors_[var_358_8.prefab_name] ~= nil then
						local var_358_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_8.prefab_name].transform, "story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb")

						arg_355_1:RecordAudio("1101105085", var_358_13)
						arg_355_1:RecordAudio("1101105085", var_358_13)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105085", "story_v_side_new_1101105.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_14 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_14 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_14

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_14 and arg_355_1.time_ < var_358_6 + var_358_14 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play1101105086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1101105086
		arg_359_1.duration_ = 10.83

		local var_359_0 = {
			zh = 7.333,
			ja = 10.833
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
				arg_359_0:Play1101105087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1011ui_story = arg_359_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1011ui_story"].transform.position).z)
				arg_359_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1011ui_story"].transform.localEulerAngles = arg_359_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_359_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1011ui_story"].transform.position).z)
				arg_359_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1011ui_story"].transform.localEulerAngles = arg_359_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1011ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1011ui_story == nil then
				arg_359_1.var_.characterEffect1011ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect1011ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1011ui_story then
				arg_359_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_362_4 = arg_359_1.actors_["1111ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_4) and arg_359_1.var_.characterEffect1111ui_story == nil then
				arg_359_1.var_.characterEffect1111ui_story = var_362_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_5 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_5 and not isNil(var_362_4) then
				if arg_359_1.var_.characterEffect1111ui_story and not isNil(var_362_4) then
					arg_359_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_5)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_5 and arg_359_1.time_ < 0 + var_362_5 + arg_362_0 and not isNil(var_362_4) and arg_359_1.var_.characterEffect1111ui_story then
				arg_359_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_362_6 = 0
			local var_362_7 = 0.7

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_8 = arg_359_1:GetWordFromCfg(1101105086)
				local var_362_9 = arg_359_1:FormatText(var_362_8.content)

				arg_359_1.text_.text = var_362_9

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_11 = 28 <= 0 and var_362_7 or var_362_7 * (utf8.len(var_362_9) / 28)

				if (28 <= 0 and var_362_7 or var_362_7 * (utf8.len(var_362_9) / 28)) > 0 and var_362_7 < var_362_11 then
					arg_359_1.talkMaxDuration = var_362_11

					if var_362_11 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_11 + var_362_6
					end
				end

				arg_359_1.text_.text = var_362_9
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb") ~= 0 then
					local var_362_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb") / 1000

					if var_362_12 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_12 + var_362_6
					end

					if var_362_8.prefab_name ~= "" and arg_359_1.actors_[var_362_8.prefab_name] ~= nil then
						local var_362_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_8.prefab_name].transform, "story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb")

						arg_359_1:RecordAudio("1101105086", var_362_13)
						arg_359_1:RecordAudio("1101105086", var_362_13)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105086", "story_v_side_new_1101105.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_14 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_14 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_14

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_14 and arg_359_1.time_ < var_362_6 + var_362_14 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1101105087
		arg_363_1.duration_ = 3.9

		local var_363_0 = {
			zh = 2.833,
			ja = 3.9
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
				arg_363_0:Play1101105088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1111ui_story = arg_363_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1111ui_story"].transform.position).z)
				arg_363_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1111ui_story"].transform.localEulerAngles = arg_363_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_363_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1111ui_story"].transform.position).z)
				arg_363_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1111ui_story"].transform.localEulerAngles = arg_363_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["1111ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1111ui_story == nil then
				arg_363_1.var_.characterEffect1111ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect1111ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1111ui_story then
				arg_363_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_366_4 = arg_363_1.actors_["1011ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_4) and arg_363_1.var_.characterEffect1011ui_story == nil then
				arg_363_1.var_.characterEffect1011ui_story = var_366_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_5 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_5 and not isNil(var_366_4) then
				if arg_363_1.var_.characterEffect1011ui_story and not isNil(var_366_4) then
					arg_363_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_5)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_5 and arg_363_1.time_ < 0 + var_366_5 + arg_366_0 and not isNil(var_366_4) and arg_363_1.var_.characterEffect1011ui_story then
				arg_363_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_366_6 = 0
			local var_366_7 = 0.55

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_8 = arg_363_1:GetWordFromCfg(1101105087)
				local var_366_9 = arg_363_1:FormatText(var_366_8.content)

				arg_363_1.text_.text = var_366_9

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_11 = 22 <= 0 and var_366_7 or var_366_7 * (utf8.len(var_366_9) / 22)

				if (22 <= 0 and var_366_7 or var_366_7 * (utf8.len(var_366_9) / 22)) > 0 and var_366_7 < var_366_11 then
					arg_363_1.talkMaxDuration = var_366_11

					if var_366_11 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_11 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_9
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb") ~= 0 then
					local var_366_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb") / 1000

					if var_366_12 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_6
					end

					if var_366_8.prefab_name ~= "" and arg_363_1.actors_[var_366_8.prefab_name] ~= nil then
						local var_366_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_8.prefab_name].transform, "story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb")

						arg_363_1:RecordAudio("1101105087", var_366_13)
						arg_363_1:RecordAudio("1101105087", var_366_13)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105087", "story_v_side_new_1101105.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_14 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_14 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_14

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_14 and arg_363_1.time_ < var_366_6 + var_366_14 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play1101105088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1101105088
		arg_367_1.duration_ = 7.33

		local var_367_0 = {
			zh = 3.866,
			ja = 7.333
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
				arg_367_0:Play1101105089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1111ui_story = arg_367_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1111ui_story"].transform.position).z)
				arg_367_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1111ui_story"].transform.localEulerAngles = arg_367_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_367_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1111ui_story"].transform.position).z)
				arg_367_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1111ui_story"].transform.localEulerAngles = arg_367_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1111ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1111ui_story == nil then
				arg_367_1.var_.characterEffect1111ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1111ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1111ui_story then
				arg_367_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_4 = 0
			local var_370_5 = 0.325

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(1101105088)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 13 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 13)

				if (13 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 13)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb")

						arg_367_1:RecordAudio("1101105088", var_370_11)
						arg_367_1:RecordAudio("1101105088", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105088", "story_v_side_new_1101105.awb")
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
				actorName = "1111ui_story",
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
	Play1101105089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1101105089
		arg_371_1.duration_ = 2.77

		local var_371_0 = {
			zh = 2.766,
			ja = 2.1
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1101105090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1011ui_story = arg_371_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).z)
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles = arg_371_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_371_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1011ui_story"].transform.position).z)
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1011ui_story"].transform.localEulerAngles = arg_371_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1011ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1011ui_story == nil then
				arg_371_1.var_.characterEffect1011ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1011ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1011ui_story then
				arg_371_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_374_4 = arg_371_1.actors_["1111ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_4) and arg_371_1.var_.characterEffect1111ui_story == nil then
				arg_371_1.var_.characterEffect1111ui_story = var_374_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_5 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_5 and not isNil(var_374_4) then
				if arg_371_1.var_.characterEffect1111ui_story and not isNil(var_374_4) then
					arg_371_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_5)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_5 and arg_371_1.time_ < 0 + var_374_5 + arg_374_0 and not isNil(var_374_4) and arg_371_1.var_.characterEffect1111ui_story then
				arg_371_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_374_6 = 0
			local var_374_7 = 0.05

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_8 = arg_371_1:GetWordFromCfg(1101105089)
				local var_374_9 = arg_371_1:FormatText(var_374_8.content)

				arg_371_1.text_.text = var_374_9

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_11 = 2 <= 0 and var_374_7 or var_374_7 * (utf8.len(var_374_9) / 2)

				if (2 <= 0 and var_374_7 or var_374_7 * (utf8.len(var_374_9) / 2)) > 0 and var_374_7 < var_374_11 then
					arg_371_1.talkMaxDuration = var_374_11

					if var_374_11 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_11 + var_374_6
					end
				end

				arg_371_1.text_.text = var_374_9
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb") ~= 0 then
					local var_374_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb") / 1000

					if var_374_12 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_12 + var_374_6
					end

					if var_374_8.prefab_name ~= "" and arg_371_1.actors_[var_374_8.prefab_name] ~= nil then
						local var_374_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_8.prefab_name].transform, "story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb")

						arg_371_1:RecordAudio("1101105089", var_374_13)
						arg_371_1:RecordAudio("1101105089", var_374_13)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105089", "story_v_side_new_1101105.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_14 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_14 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_14

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_14 and arg_371_1.time_ < var_374_6 + var_374_14 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1101105090
		arg_375_1.duration_ = 5.47

		local var_375_0 = {
			zh = 5.466,
			ja = 4.3
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
				arg_375_0:Play1101105091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1011ui_story = arg_375_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).z)
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles = arg_375_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_375_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).z)
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles = arg_375_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1011ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1011ui_story == nil then
				arg_375_1.var_.characterEffect1011ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1011ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1011ui_story then
				arg_375_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_378_4 = 0
			local var_378_5 = 0.575

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(1101105090)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 23 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 23)

				if (23 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 23)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb")

						arg_375_1:RecordAudio("1101105090", var_378_11)
						arg_375_1:RecordAudio("1101105090", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105090", "story_v_side_new_1101105.awb")
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
				actorName = "1011ui_story",
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
	Play1101105091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1101105091
		arg_379_1.duration_ = 8.93

		local var_379_0 = {
			zh = 3.833,
			ja = 8.933
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
				arg_379_0:Play1101105092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1111ui_story = arg_379_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).z)
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles = arg_379_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_379_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).z)
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles = arg_379_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1111ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1111ui_story == nil then
				arg_379_1.var_.characterEffect1111ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1111ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1111ui_story then
				arg_379_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_4 = arg_379_1.actors_["1011ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect1011ui_story == nil then
				arg_379_1.var_.characterEffect1011ui_story = var_382_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_5 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_5 and not isNil(var_382_4) then
				if arg_379_1.var_.characterEffect1011ui_story and not isNil(var_382_4) then
					arg_379_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_5)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_5 and arg_379_1.time_ < 0 + var_382_5 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect1011ui_story then
				arg_379_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_382_6 = 0
			local var_382_7 = 0.5

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:GetWordFromCfg(1101105091)
				local var_382_9 = arg_379_1:FormatText(var_382_8.content)

				arg_379_1.text_.text = var_382_9

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 20 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_9) / 20)

				if (20 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_9) / 20)) > 0 and var_382_7 < var_382_11 then
					arg_379_1.talkMaxDuration = var_382_11

					if var_382_11 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_11 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_9
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb") ~= 0 then
					local var_382_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb") / 1000

					if var_382_12 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_6
					end

					if var_382_8.prefab_name ~= "" and arg_379_1.actors_[var_382_8.prefab_name] ~= nil then
						local var_382_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_8.prefab_name].transform, "story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb")

						arg_379_1:RecordAudio("1101105091", var_382_13)
						arg_379_1:RecordAudio("1101105091", var_382_13)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105091", "story_v_side_new_1101105.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_14 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_14 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_14

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_14 and arg_379_1.time_ < var_382_6 + var_382_14 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play1101105092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1101105092
		arg_383_1.duration_ = 9.37

		local var_383_0 = {
			zh = 7.7,
			ja = 9.366
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
				arg_383_0:Play1101105093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1111ui_story = arg_383_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).z)
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles = arg_383_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_383_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).z)
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles = arg_383_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["1111ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1111ui_story == nil then
				arg_383_1.var_.characterEffect1111ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1111ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1111ui_story then
				arg_383_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action498")
			end

			local var_386_4 = 0
			local var_386_5 = 0.825

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_6 = arg_383_1:GetWordFromCfg(1101105092)
				local var_386_7 = arg_383_1:FormatText(var_386_6.content)

				arg_383_1.text_.text = var_386_7

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_9 = 33 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 33)

				if (33 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 33)) > 0 and var_386_5 < var_386_9 then
					arg_383_1.talkMaxDuration = var_386_9

					if var_386_9 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_9 + var_386_4
					end
				end

				arg_383_1.text_.text = var_386_7
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb") ~= 0 then
					local var_386_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb") / 1000

					if var_386_10 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_10 + var_386_4
					end

					if var_386_6.prefab_name ~= "" and arg_383_1.actors_[var_386_6.prefab_name] ~= nil then
						local var_386_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_6.prefab_name].transform, "story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb")

						arg_383_1:RecordAudio("1101105092", var_386_11)
						arg_383_1:RecordAudio("1101105092", var_386_11)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105092", "story_v_side_new_1101105.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_12 = math.max(var_386_5, arg_383_1.talkMaxDuration)

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_12 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_4) / var_386_12

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_4 + var_386_12 and arg_383_1.time_ < var_386_4 + var_386_12 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play1101105093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1101105093
		arg_387_1.duration_ = 3.67

		local var_387_0 = {
			zh = 2.966,
			ja = 3.666
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
				arg_387_0:Play1101105094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1011ui_story = arg_387_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).z)
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles = arg_387_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_387_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).z)
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles = arg_387_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_390_1 = arg_387_1.actors_["1011ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1011ui_story == nil then
				arg_387_1.var_.characterEffect1011ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect1011ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1011ui_story then
				arg_387_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_390_4 = arg_387_1.actors_["1111ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_4) and arg_387_1.var_.characterEffect1111ui_story == nil then
				arg_387_1.var_.characterEffect1111ui_story = var_390_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_5 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_5 and not isNil(var_390_4) then
				if arg_387_1.var_.characterEffect1111ui_story and not isNil(var_390_4) then
					arg_387_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_5)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_5 and arg_387_1.time_ < 0 + var_390_5 + arg_390_0 and not isNil(var_390_4) and arg_387_1.var_.characterEffect1111ui_story then
				arg_387_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_390_6 = 0
			local var_390_7 = 0.075

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_6 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_8 = arg_387_1:GetWordFromCfg(1101105093)
				local var_390_9 = arg_387_1:FormatText(var_390_8.content)

				arg_387_1.text_.text = var_390_9

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_11 = 3 <= 0 and var_390_7 or var_390_7 * (utf8.len(var_390_9) / 3)

				if (3 <= 0 and var_390_7 or var_390_7 * (utf8.len(var_390_9) / 3)) > 0 and var_390_7 < var_390_11 then
					arg_387_1.talkMaxDuration = var_390_11

					if var_390_11 + var_390_6 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_11 + var_390_6
					end
				end

				arg_387_1.text_.text = var_390_9
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb") ~= 0 then
					local var_390_12 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb") / 1000

					if var_390_12 + var_390_6 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_12 + var_390_6
					end

					if var_390_8.prefab_name ~= "" and arg_387_1.actors_[var_390_8.prefab_name] ~= nil then
						local var_390_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_8.prefab_name].transform, "story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb")

						arg_387_1:RecordAudio("1101105093", var_390_13)
						arg_387_1:RecordAudio("1101105093", var_390_13)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105093", "story_v_side_new_1101105.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_14 = math.max(var_390_7, arg_387_1.talkMaxDuration)

			if var_390_6 <= arg_387_1.time_ and arg_387_1.time_ < var_390_6 + var_390_14 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_6) / var_390_14

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_6 + var_390_14 and arg_387_1.time_ < var_390_6 + var_390_14 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1101105094
		arg_391_1.duration_ = 9

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1101105095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 2 < arg_391_1.time_ and arg_391_1.time_ <= 2 + arg_394_0 then
				local var_394_0 = arg_391_1.bgs_.ST12

				arg_391_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_394_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_394_1 = var_394_0:GetComponent("SpriteRenderer")

				if var_394_1 and var_394_1.sprite then
					local var_394_2 = 2 * (var_394_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_394_0.transform.localScale = Vector3.New(var_394_2 / var_394_1.sprite.bounds.size.y < var_394_2 * manager.ui.mainCameraCom_.aspect / var_394_1.sprite.bounds.size.x and var_394_2 * manager.ui.mainCameraCom_.aspect / var_394_1.sprite.bounds.size.x or var_394_2 / var_394_1.sprite.bounds.size.y, var_394_2 / var_394_1.sprite.bounds.size.y < var_394_2 * manager.ui.mainCameraCom_.aspect / var_394_1.sprite.bounds.size.x and var_394_2 * manager.ui.mainCameraCom_.aspect / var_394_1.sprite.bounds.size.x or var_394_2 / var_394_1.sprite.bounds.size.y, 0)
				end

				for iter_394_0, iter_394_1 in pairs(arg_391_1.bgs_) do
					if iter_394_0 ~= "ST12" then
						iter_394_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_394_3 = 0

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_3 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_4 = 2

			if var_394_3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_3 + var_394_4 then
				local var_394_5 = Color.New(0, 0, 0)

				var_394_5.a = Mathf.Lerp(0, 1, (arg_391_1.time_ - var_394_3) / var_394_4)
				arg_391_1.mask_.color = var_394_5
			end

			if arg_391_1.time_ >= var_394_3 + var_394_4 and arg_391_1.time_ < var_394_3 + var_394_4 + arg_394_0 then
				local var_394_6 = Color.New(0, 0, 0)

				var_394_6.a = 1
				arg_391_1.mask_.color = var_394_6
			end

			local var_394_7 = 2

			if 2 < arg_391_1.time_ and arg_391_1.time_ <= var_394_7 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_8 = 2

			if var_394_7 <= arg_391_1.time_ and arg_391_1.time_ < var_394_7 + var_394_8 then
				local var_394_9 = Color.New(0, 0, 0)

				var_394_9.a = Mathf.Lerp(1, 0, (arg_391_1.time_ - var_394_7) / var_394_8)
				arg_391_1.mask_.color = var_394_9
			end

			if arg_391_1.time_ >= var_394_7 + var_394_8 and arg_391_1.time_ < var_394_7 + var_394_8 + arg_394_0 then
				local var_394_10 = Color.New(0, 0, 0)

				arg_391_1.mask_.enabled = false
				var_394_10.a = 0
				arg_391_1.mask_.color = var_394_10
			end

			local var_394_11 = arg_391_1.actors_["1011ui_story"].transform

			if 2 < arg_391_1.time_ and arg_391_1.time_ <= 2 + arg_394_0 then
				arg_391_1.var_.moveOldPos1011ui_story = var_394_11.localPosition
			end

			local var_394_12 = 0.001

			if 2 <= arg_391_1.time_ and arg_391_1.time_ < 2 + var_394_12 then
				var_394_11.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 2) / var_394_12)
				var_394_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_11.position).x, (manager.ui.mainCamera.transform.position - var_394_11.position).y, (manager.ui.mainCamera.transform.position - var_394_11.position).z)
				var_394_11.localEulerAngles.z = 0
				var_394_11.localEulerAngles.x = 0
				var_394_11.localEulerAngles = var_394_11.localEulerAngles
			end

			if arg_391_1.time_ >= 2 + var_394_12 and arg_391_1.time_ < 2 + var_394_12 + arg_394_0 then
				var_394_11.localPosition = Vector3.New(0, 100, 0)
				var_394_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_11.position).x, (manager.ui.mainCamera.transform.position - var_394_11.position).y, (manager.ui.mainCamera.transform.position - var_394_11.position).z)
				var_394_11.localEulerAngles.z = 0
				var_394_11.localEulerAngles.x = 0
				var_394_11.localEulerAngles = var_394_11.localEulerAngles
			end

			local var_394_13 = arg_391_1.actors_["1111ui_story"].transform

			if 2 < arg_391_1.time_ and arg_391_1.time_ <= 2 + arg_394_0 then
				arg_391_1.var_.moveOldPos1111ui_story = var_394_13.localPosition
			end

			local var_394_14 = 0.001

			if 2 <= arg_391_1.time_ and arg_391_1.time_ < 2 + var_394_14 then
				var_394_13.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 2) / var_394_14)
				var_394_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_13.position).x, (manager.ui.mainCamera.transform.position - var_394_13.position).y, (manager.ui.mainCamera.transform.position - var_394_13.position).z)
				var_394_13.localEulerAngles.z = 0
				var_394_13.localEulerAngles.x = 0
				var_394_13.localEulerAngles = var_394_13.localEulerAngles
			end

			if arg_391_1.time_ >= 2 + var_394_14 and arg_391_1.time_ < 2 + var_394_14 + arg_394_0 then
				var_394_13.localPosition = Vector3.New(0, 100, 0)
				var_394_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_13.position).x, (manager.ui.mainCamera.transform.position - var_394_13.position).y, (manager.ui.mainCamera.transform.position - var_394_13.position).z)
				var_394_13.localEulerAngles.z = 0
				var_394_13.localEulerAngles.x = 0
				var_394_13.localEulerAngles = var_394_13.localEulerAngles
			end

			if arg_391_1.frameCnt_ <= 1 then
				arg_391_1.dialog_:SetActive(false)
			end

			local var_394_15 = 4
			local var_394_16 = 0.675

			if 4 < arg_391_1.time_ and arg_391_1.time_ <= var_394_15 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_17 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_17:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_391_1.dialogCg_.alpha = arg_395_0
				end))
				var_394_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_18 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1101105094).content)

				arg_391_1.text_.text = var_394_18

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_20 = 27 <= 0 and var_394_16 or var_394_16 * (utf8.len(var_394_18) / 27)

				if (27 <= 0 and var_394_16 or var_394_16 * (utf8.len(var_394_18) / 27)) > 0 and var_394_16 < var_394_20 then
					arg_391_1.talkMaxDuration = var_394_20
					var_394_15 = var_394_15 + 0.3

					if var_394_20 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_20 + var_394_15
					end
				end

				arg_391_1.text_.text = var_394_18
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_21 = var_394_15 + 0.3
			local var_394_22 = math.max(var_394_16, arg_391_1.talkMaxDuration)

			if var_394_15 + 0.3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_21 + var_394_22 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_21) / var_394_22

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_21 + var_394_22 and arg_391_1.time_ < var_394_21 + var_394_22 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1101105095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1101105095
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1101105096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.65

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1101105095).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 26 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 26)

				if (26 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 26)) > 0 and var_400_0 < var_400_3 then
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
	Play1101105096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1101105096
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1101105097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.725

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1101105096).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 35 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 35)

				if (35 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 35)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1101105097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1101105097
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1101105098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.55

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(1101105097).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 22 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 22)

				if (22 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 22)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1101105098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1101105098
		arg_409_1.duration_ = 9.43

		local var_409_0 = {
			zh = 4.833,
			ja = 9.433
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1101105099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1011ui_story = arg_409_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).z)
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles = arg_409_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_409_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1011ui_story"].transform.position).z)
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1011ui_story"].transform.localEulerAngles = arg_409_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["1011ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1011ui_story == nil then
				arg_409_1.var_.characterEffect1011ui_story = var_412_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 and not isNil(var_412_1) then
				if arg_409_1.var_.characterEffect1011ui_story and not isNil(var_412_1) then
					arg_409_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1011ui_story then
				arg_409_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_412_4 = 0
			local var_412_5 = 0.575

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_6 = arg_409_1:GetWordFromCfg(1101105098)
				local var_412_7 = arg_409_1:FormatText(var_412_6.content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 23 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 23)

				if (23 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 23)) > 0 and var_412_5 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_4
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb") ~= 0 then
					local var_412_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb") / 1000

					if var_412_10 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_10 + var_412_4
					end

					if var_412_6.prefab_name ~= "" and arg_409_1.actors_[var_412_6.prefab_name] ~= nil then
						local var_412_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_6.prefab_name].transform, "story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb")

						arg_409_1:RecordAudio("1101105098", var_412_11)
						arg_409_1:RecordAudio("1101105098", var_412_11)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105098", "story_v_side_new_1101105.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_12 = math.max(var_412_5, arg_409_1.talkMaxDuration)

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_12 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_4) / var_412_12

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_4 + var_412_12 and arg_409_1.time_ < var_412_4 + var_412_12 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play1101105099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1101105099
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1101105100(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1011ui_story"]) and arg_413_1.var_.characterEffect1011ui_story == nil then
				arg_413_1.var_.characterEffect1011ui_story = arg_413_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1011ui_story"]) then
				if arg_413_1.var_.characterEffect1011ui_story and not isNil(arg_413_1.actors_["1011ui_story"]) then
					arg_413_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_0)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1011ui_story"]) and arg_413_1.var_.characterEffect1011ui_story then
				arg_413_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_416_1 = 0
			local var_416_2 = 0.625

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_3 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1101105099).content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 25 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 25)

				if (25 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 25)) > 0 and var_416_2 < var_416_5 then
					arg_413_1.talkMaxDuration = var_416_5

					if var_416_5 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + var_416_1
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_6 = math.max(var_416_2, arg_413_1.talkMaxDuration)

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_6 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_1) / var_416_6

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_1 + var_416_6 and arg_413_1.time_ < var_416_1 + var_416_6 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1101105100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1101105100
		arg_417_1.duration_ = 4.07

		local var_417_0 = {
			zh = 4.066,
			ja = 2.666
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1101105101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1011ui_story = arg_417_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1011ui_story"].transform.position).z)
				arg_417_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1011ui_story"].transform.localEulerAngles = arg_417_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_417_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1011ui_story"].transform.position).z)
				arg_417_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1011ui_story"].transform.localEulerAngles = arg_417_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["1011ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1011ui_story == nil then
				arg_417_1.var_.characterEffect1011ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect1011ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1011ui_story then
				arg_417_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_420_4 = 0
			local var_420_5 = 0.375

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_6 = arg_417_1:GetWordFromCfg(1101105100)
				local var_420_7 = arg_417_1:FormatText(var_420_6.content)

				arg_417_1.text_.text = var_420_7

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_9 = 15 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 15)

				if (15 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 15)) > 0 and var_420_5 < var_420_9 then
					arg_417_1.talkMaxDuration = var_420_9

					if var_420_9 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_9 + var_420_4
					end
				end

				arg_417_1.text_.text = var_420_7
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb") ~= 0 then
					local var_420_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb") / 1000

					if var_420_10 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_4
					end

					if var_420_6.prefab_name ~= "" and arg_417_1.actors_[var_420_6.prefab_name] ~= nil then
						local var_420_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_6.prefab_name].transform, "story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb")

						arg_417_1:RecordAudio("1101105100", var_420_11)
						arg_417_1:RecordAudio("1101105100", var_420_11)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105100", "story_v_side_new_1101105.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_12 = math.max(var_420_5, arg_417_1.talkMaxDuration)

			if var_420_4 <= arg_417_1.time_ and arg_417_1.time_ < var_420_4 + var_420_12 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_4) / var_420_12

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_4 + var_420_12 and arg_417_1.time_ < var_420_4 + var_420_12 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1101105101
		arg_421_1.duration_ = 1

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"

			SetActive(arg_421_1.choicesGo_, true)

			for iter_422_0, iter_422_1 in ipairs(arg_421_1.choices_) do
				SetActive(iter_422_1.go, iter_422_0 <= 1)
			end

			arg_421_1.choices_[1].txt.text = arg_421_1:FormatText(StoryChoiceCfg[620].name)
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1101105102(arg_421_1)
			end

			arg_421_1:RecordChoiceLog(1101105101, 620)
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1011ui_story"]) and arg_421_1.var_.characterEffect1011ui_story == nil then
				arg_421_1.var_.characterEffect1011ui_story = arg_421_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1011ui_story"]) then
				if arg_421_1.var_.characterEffect1011ui_story and not isNil(arg_421_1.actors_["1011ui_story"]) then
					arg_421_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_0)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1011ui_story"]) and arg_421_1.var_.characterEffect1011ui_story then
				arg_421_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_424_1 = 0

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			if arg_421_1.time_ >= var_424_1 + 0.5 and arg_421_1.time_ < var_424_1 + 0.5 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1101105102 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1101105102
		arg_425_1.duration_ = 3.67

		local var_425_0 = {
			zh = 2.8,
			ja = 3.666
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1101105103(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1011ui_story = arg_425_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1011ui_story"].transform.position).z)
				arg_425_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1011ui_story"].transform.localEulerAngles = arg_425_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_425_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1011ui_story"].transform.position).z)
				arg_425_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1011ui_story"].transform.localEulerAngles = arg_425_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1011ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1011ui_story == nil then
				arg_425_1.var_.characterEffect1011ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect1011ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1011ui_story then
				arg_425_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_428_4 = 0
			local var_428_5 = 0.275

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_6 = arg_425_1:GetWordFromCfg(1101105102)
				local var_428_7 = arg_425_1:FormatText(var_428_6.content)

				arg_425_1.text_.text = var_428_7

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_9 = 11 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 11)

				if (11 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 11)) > 0 and var_428_5 < var_428_9 then
					arg_425_1.talkMaxDuration = var_428_9

					if var_428_9 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_9 + var_428_4
					end
				end

				arg_425_1.text_.text = var_428_7
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb") ~= 0 then
					local var_428_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb") / 1000

					if var_428_10 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_4
					end

					if var_428_6.prefab_name ~= "" and arg_425_1.actors_[var_428_6.prefab_name] ~= nil then
						local var_428_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_6.prefab_name].transform, "story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb")

						arg_425_1:RecordAudio("1101105102", var_428_11)
						arg_425_1:RecordAudio("1101105102", var_428_11)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105102", "story_v_side_new_1101105.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_12 = math.max(var_428_5, arg_425_1.talkMaxDuration)

			if var_428_4 <= arg_425_1.time_ and arg_425_1.time_ < var_428_4 + var_428_12 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_4) / var_428_12

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_4 + var_428_12 and arg_425_1.time_ < var_428_4 + var_428_12 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play1101105103 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1101105103
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1101105104(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1011ui_story"]) and arg_429_1.var_.characterEffect1011ui_story == nil then
				arg_429_1.var_.characterEffect1011ui_story = arg_429_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1011ui_story"]) then
				if arg_429_1.var_.characterEffect1011ui_story and not isNil(arg_429_1.actors_["1011ui_story"]) then
					arg_429_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_0)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1011ui_story"]) and arg_429_1.var_.characterEffect1011ui_story then
				arg_429_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_432_1 = 0
			local var_432_2 = 1.125

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_3 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(1101105103).content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 45 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 45)

				if (45 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 45)) > 0 and var_432_2 < var_432_5 then
					arg_429_1.talkMaxDuration = var_432_5

					if var_432_5 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_6 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_6 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_6

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_6 and arg_429_1.time_ < var_432_1 + var_432_6 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1101105104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1101105104
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1101105105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.4

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
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

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1101105104).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 16 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 16)

				if (16 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 16)) > 0 and var_436_0 < var_436_3 then
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
	Play1101105105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1101105105
		arg_437_1.duration_ = 2

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1101105106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1011ui_story = arg_437_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1011ui_story"].transform.position).z)
				arg_437_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1011ui_story"].transform.localEulerAngles = arg_437_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_437_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1011ui_story"].transform.position).z)
				arg_437_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1011ui_story"].transform.localEulerAngles = arg_437_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1011ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1011ui_story == nil then
				arg_437_1.var_.characterEffect1011ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1011ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1011ui_story then
				arg_437_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_440_4 = 0
			local var_440_5 = 0.05

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(1101105105)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 2 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 2)

				if (2 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 2)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb")

						arg_437_1:RecordAudio("1101105105", var_440_11)
						arg_437_1:RecordAudio("1101105105", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105105", "story_v_side_new_1101105.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_12 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_12 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_12

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_12 and arg_437_1.time_ < var_440_4 + var_440_12 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1101105106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1101105106
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1101105107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1011ui_story"]) and arg_441_1.var_.characterEffect1011ui_story == nil then
				arg_441_1.var_.characterEffect1011ui_story = arg_441_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1011ui_story"]) then
				if arg_441_1.var_.characterEffect1011ui_story and not isNil(arg_441_1.actors_["1011ui_story"]) then
					arg_441_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_0)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1011ui_story"]) and arg_441_1.var_.characterEffect1011ui_story then
				arg_441_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_444_1 = 0
			local var_444_2 = 0.45

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_3 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(1101105106).content)

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
	Play1101105107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1101105107
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1101105108(arg_445_1)
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

				local var_448_1 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1101105107).content)

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
	Play1101105108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1101105108
		arg_449_1.duration_ = 3.03

		local var_449_0 = {
			zh = 3.033,
			ja = 2.8
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
				arg_449_0:Play1101105109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1011ui_story = arg_449_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1011ui_story"].transform.position).z)
				arg_449_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1011ui_story"].transform.localEulerAngles = arg_449_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_449_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1011ui_story"].transform.position).z)
				arg_449_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1011ui_story"].transform.localEulerAngles = arg_449_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["1011ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1011ui_story == nil then
				arg_449_1.var_.characterEffect1011ui_story = var_452_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 and not isNil(var_452_1) then
				if arg_449_1.var_.characterEffect1011ui_story and not isNil(var_452_1) then
					arg_449_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1011ui_story then
				arg_449_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_452_4 = 0
			local var_452_5 = 0.325

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_4 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_6 = arg_449_1:GetWordFromCfg(1101105108)
				local var_452_7 = arg_449_1:FormatText(var_452_6.content)

				arg_449_1.text_.text = var_452_7

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_9 = 13 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 13)

				if (13 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 13)) > 0 and var_452_5 < var_452_9 then
					arg_449_1.talkMaxDuration = var_452_9

					if var_452_9 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_9 + var_452_4
					end
				end

				arg_449_1.text_.text = var_452_7
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb") ~= 0 then
					local var_452_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb") / 1000

					if var_452_10 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_4
					end

					if var_452_6.prefab_name ~= "" and arg_449_1.actors_[var_452_6.prefab_name] ~= nil then
						local var_452_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_6.prefab_name].transform, "story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb")

						arg_449_1:RecordAudio("1101105108", var_452_11)
						arg_449_1:RecordAudio("1101105108", var_452_11)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105108", "story_v_side_new_1101105.awb")
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

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1101105109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1101105109
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1101105110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1011ui_story = arg_453_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).z)
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles = arg_453_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_453_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).z)
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles = arg_453_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1011ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1011ui_story == nil then
				arg_453_1.var_.characterEffect1011ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1011ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_2)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1011ui_story then
				arg_453_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_456_3 = 0
			local var_456_4 = 1.225

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_3 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_5 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1101105109).content)

				arg_453_1.text_.text = var_456_5

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_7 = 49 <= 0 and var_456_4 or var_456_4 * (utf8.len(var_456_5) / 49)

				if (49 <= 0 and var_456_4 or var_456_4 * (utf8.len(var_456_5) / 49)) > 0 and var_456_4 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_3 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_3
					end
				end

				arg_453_1.text_.text = var_456_5
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_4, arg_453_1.talkMaxDuration)

			if var_456_3 <= arg_453_1.time_ and arg_453_1.time_ < var_456_3 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_3) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_3 + var_456_8 and arg_453_1.time_ < var_456_3 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1101105110
		arg_457_1.duration_ = 8.23

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1101105111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.fswbg_:SetActive(true)
				arg_457_1.dialog_:SetActive(false)

				arg_457_1.fswtw_.percent = 0
				arg_457_1.fswt_.text = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1101105110).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.fswt_)

				arg_457_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_457_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_457_1.fswtw_:SetDirty()

				arg_457_1.typewritterCharCountI18N = 0

				SetActive(arg_457_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_457_1:ShowNextGo(false)
			end

			local var_460_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.var_.oldValueTypewriter = arg_457_1.fswtw_.percent

				SetActive(arg_457_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_457_1:ShowNextGo(false)
			end

			local var_460_1 = 37
			local var_460_2 = 2.46666666666667
			local var_460_3, var_460_4 = arg_457_1:GetPercentByPara(arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1101105110).content), 1)

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0

				local var_460_5 = var_460_1 <= 0 and var_460_2 or var_460_2 * ((var_460_4 - arg_457_1.typewritterCharCountI18N) / var_460_1)

				if (var_460_1 <= 0 and var_460_2 or var_460_2 * ((var_460_4 - arg_457_1.typewritterCharCountI18N) / var_460_1)) > 0 and var_460_2 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_0
					end
				end
			end

			local var_460_6 = math.max(2.46666666666667, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_6 then
				arg_457_1.fswtw_.percent = Mathf.Lerp(arg_457_1.var_.oldValueTypewriter, var_460_3, (arg_457_1.time_ - var_460_0) / var_460_6)
				arg_457_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_457_1.fswtw_:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_6 and arg_457_1.time_ < var_460_0 + var_460_6 + arg_460_0 then
				arg_457_1.fswtw_.percent = var_460_3

				arg_457_1.fswtw_:SetDirty()
				arg_457_1:ShowNextGo(true)

				arg_457_1.typewritterCharCountI18N = var_460_4
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				local var_460_7 = arg_457_1.fswbg_.transform:Find("textbox/adapt/content") or arg_457_1.fswbg_.transform:Find("textbox/content")
				local var_460_8 = arg_457_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_460_9 = var_460_7:GetComponent("RectTransform")

				var_460_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_460_9.offsetMin = Vector2.New(0, 0)
				var_460_9.offsetMax = Vector2.New(0, 0)
			end

			local var_460_10 = 0
			local var_460_11 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105110", "story_v_side_new_1101105.awb") / 1000

			if var_460_11 > 0 and 8.233 < var_460_11 and var_460_11 + var_460_10 > arg_457_1.duration_ then
				arg_457_1.duration_ = var_460_11 + var_460_10
			end

			if var_460_10 < arg_457_1.time_ and arg_457_1.time_ <= var_460_10 + arg_460_0 then
				arg_457_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105110", "story_v_side_new_1101105.awb")
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1101105111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1101105111
		arg_461_1.duration_ = 4.2

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1101105112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.oldValueTypewriter = arg_461_1.fswtw_.percent

				SetActive(arg_461_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_461_1:ShowNextGo(false)
			end

			local var_464_0 = 23
			local var_464_1 = 1.53333333333333
			local var_464_2, var_464_3 = arg_461_1:GetPercentByPara(arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1101105110).content), 2)

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0

				local var_464_4 = var_464_0 <= 0 and var_464_1 or var_464_1 * ((var_464_3 - arg_461_1.typewritterCharCountI18N) / var_464_0)

				if (var_464_0 <= 0 and var_464_1 or var_464_1 * ((var_464_3 - arg_461_1.typewritterCharCountI18N) / var_464_0)) > 0 and var_464_1 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end
			end

			local var_464_5 = math.max(1.53333333333333, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_5 then
				arg_461_1.fswtw_.percent = Mathf.Lerp(arg_461_1.var_.oldValueTypewriter, var_464_2, (arg_461_1.time_ - 0) / var_464_5)
				arg_461_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_461_1.fswtw_:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_5 and arg_461_1.time_ < 0 + var_464_5 + arg_464_0 then
				arg_461_1.fswtw_.percent = var_464_2

				arg_461_1.fswtw_:SetDirty()
				arg_461_1:ShowNextGo(true)

				arg_461_1.typewritterCharCountI18N = var_464_3
			end

			local var_464_6 = 0
			local var_464_7 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105111", "story_v_side_new_1101105.awb") / 1000

			if var_464_7 > 0 and 4.2 < var_464_7 and var_464_7 + var_464_6 > arg_461_1.duration_ then
				arg_461_1.duration_ = var_464_7 + var_464_6
			end

			if var_464_6 < arg_461_1.time_ and arg_461_1.time_ <= var_464_6 + arg_464_0 then
				arg_461_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105111", "story_v_side_new_1101105.awb")
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1101105112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1101105112
		arg_465_1.duration_ = 8.2

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1101105113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.oldValueTypewriter = arg_465_1.fswtw_.percent

				SetActive(arg_465_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_465_1:ShowNextGo(false)
			end

			local var_468_0 = 40
			local var_468_1 = 2.66666666666667
			local var_468_2, var_468_3 = arg_465_1:GetPercentByPara(arg_465_1:FormatText(arg_465_1:GetWordFromCfg(1101105110).content), 3)

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0

				local var_468_4 = var_468_0 <= 0 and var_468_1 or var_468_1 * ((var_468_3 - arg_465_1.typewritterCharCountI18N) / var_468_0)

				if (var_468_0 <= 0 and var_468_1 or var_468_1 * ((var_468_3 - arg_465_1.typewritterCharCountI18N) / var_468_0)) > 0 and var_468_1 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + 0
					end
				end
			end

			local var_468_5 = math.max(2.66666666666667, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_5 then
				arg_465_1.fswtw_.percent = Mathf.Lerp(arg_465_1.var_.oldValueTypewriter, var_468_2, (arg_465_1.time_ - 0) / var_468_5)
				arg_465_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_465_1.fswtw_:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_5 and arg_465_1.time_ < 0 + var_468_5 + arg_468_0 then
				arg_465_1.fswtw_.percent = var_468_2

				arg_465_1.fswtw_:SetDirty()
				arg_465_1:ShowNextGo(true)

				arg_465_1.typewritterCharCountI18N = var_468_3
			end

			local var_468_6 = 0
			local var_468_7 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105112", "story_v_side_new_1101105.awb") / 1000

			if var_468_7 > 0 and 8.2 < var_468_7 and var_468_7 + var_468_6 > arg_465_1.duration_ then
				arg_465_1.duration_ = var_468_7 + var_468_6
			end

			if var_468_6 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105112", "story_v_side_new_1101105.awb")
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1101105113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1101105113
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1101105114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.fswbg_:SetActive(false)
				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_469_1:ShowNextGo(false)
			end

			local var_472_0 = 0
			local var_472_1 = 0.05

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_2 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1101105113).content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 2 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_2) / 2)

				if (2 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_2) / 2)) > 0 and var_472_1 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_5 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_5 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_5

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_5 and arg_469_1.time_ < var_472_0 + var_472_5 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1101105114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1101105114
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1101105115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1011ui_story = arg_473_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1011ui_story"].transform.position).z)
				arg_473_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1011ui_story"].transform.localEulerAngles = arg_473_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_473_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1011ui_story"].transform.position).z)
				arg_473_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1011ui_story"].transform.localEulerAngles = arg_473_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["1011ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1011ui_story == nil then
				arg_473_1.var_.characterEffect1011ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1011ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_2)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1011ui_story then
				arg_473_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_476_3 = 0
			local var_476_4 = 0.875

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_3 + arg_476_0 then
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

				local var_476_5 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(1101105114).content)

				arg_473_1.text_.text = var_476_5

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_7 = 35 <= 0 and var_476_4 or var_476_4 * (utf8.len(var_476_5) / 35)

				if (35 <= 0 and var_476_4 or var_476_4 * (utf8.len(var_476_5) / 35)) > 0 and var_476_4 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_3 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_3
					end
				end

				arg_473_1.text_.text = var_476_5
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_4, arg_473_1.talkMaxDuration)

			if var_476_3 <= arg_473_1.time_ and arg_473_1.time_ < var_476_3 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_3) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_3 + var_476_8 and arg_473_1.time_ < var_476_3 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play1101105115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1101105115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1101105116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.55

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
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

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1101105115).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 22 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 22)

				if (22 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 22)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1101105116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1101105116
		arg_481_1.duration_ = 8.2

		local var_481_0 = {
			zh = 5.333,
			ja = 8.2
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
				arg_481_0:Play1101105117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1011ui_story = arg_481_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).z)
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles = arg_481_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_481_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).z)
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles = arg_481_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1011ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1011ui_story == nil then
				arg_481_1.var_.characterEffect1011ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect1011ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1011ui_story then
				arg_481_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action453")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_484_4 = 0
			local var_484_5 = 0.55

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_6 = arg_481_1:GetWordFromCfg(1101105116)
				local var_484_7 = arg_481_1:FormatText(var_484_6.content)

				arg_481_1.text_.text = var_484_7

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_9 = 22 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 22)

				if (22 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 22)) > 0 and var_484_5 < var_484_9 then
					arg_481_1.talkMaxDuration = var_484_9

					if var_484_9 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_4
					end
				end

				arg_481_1.text_.text = var_484_7
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb") ~= 0 then
					local var_484_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb") / 1000

					if var_484_10 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_4
					end

					if var_484_6.prefab_name ~= "" and arg_481_1.actors_[var_484_6.prefab_name] ~= nil then
						local var_484_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_6.prefab_name].transform, "story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb")

						arg_481_1:RecordAudio("1101105116", var_484_11)
						arg_481_1:RecordAudio("1101105116", var_484_11)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105116", "story_v_side_new_1101105.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_12 = math.max(var_484_5, arg_481_1.talkMaxDuration)

			if var_484_4 <= arg_481_1.time_ and arg_481_1.time_ < var_484_4 + var_484_12 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_4) / var_484_12

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_4 + var_484_12 and arg_481_1.time_ < var_484_4 + var_484_12 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1101105117
		arg_485_1.duration_ = 1

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"

			SetActive(arg_485_1.choicesGo_, true)

			for iter_486_0, iter_486_1 in ipairs(arg_485_1.choices_) do
				SetActive(iter_486_1.go, iter_486_0 <= 1)
			end

			arg_485_1.choices_[1].txt.text = arg_485_1:FormatText(StoryChoiceCfg[621].name)
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1101105118(arg_485_1)
			end

			arg_485_1:RecordChoiceLog(1101105117, 621)
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1011ui_story"]) and arg_485_1.var_.characterEffect1011ui_story == nil then
				arg_485_1.var_.characterEffect1011ui_story = arg_485_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1011ui_story"]) then
				if arg_485_1.var_.characterEffect1011ui_story and not isNil(arg_485_1.actors_["1011ui_story"]) then
					arg_485_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_0)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1011ui_story"]) and arg_485_1.var_.characterEffect1011ui_story then
				arg_485_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_488_1 = 0

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.allBtn_.enabled = false
			end

			if arg_485_1.time_ >= var_488_1 + 0.5 and arg_485_1.time_ < var_488_1 + 0.5 + arg_488_0 then
				arg_485_1.allBtn_.enabled = true
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1101105118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1101105118
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1101105119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.725

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1101105118).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 29 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 29)

				if (29 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 29)) > 0 and var_492_0 < var_492_3 then
					arg_489_1.talkMaxDuration = var_492_3

					if var_492_3 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_3 + 0
					end
				end

				arg_489_1.text_.text = var_492_1
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_4 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_4

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1101105119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1101105119
		arg_493_1.duration_ = 9.47

		local var_493_0 = {
			zh = 8.933,
			ja = 9.466
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
				arg_493_0:Play1101105120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1011ui_story = arg_493_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).z)
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles = arg_493_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_493_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).z)
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles = arg_493_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1011ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1011ui_story == nil then
				arg_493_1.var_.characterEffect1011ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1011ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1011ui_story then
				arg_493_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_496_4 = 0
			local var_496_5 = 1.05

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:GetWordFromCfg(1101105119)
				local var_496_7 = arg_493_1:FormatText(var_496_6.content)

				arg_493_1.text_.text = var_496_7

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 42 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 42)

				if (42 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 42)) > 0 and var_496_5 < var_496_9 then
					arg_493_1.talkMaxDuration = var_496_9

					if var_496_9 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_7
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb") ~= 0 then
					local var_496_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb") / 1000

					if var_496_10 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_4
					end

					if var_496_6.prefab_name ~= "" and arg_493_1.actors_[var_496_6.prefab_name] ~= nil then
						local var_496_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_6.prefab_name].transform, "story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb")

						arg_493_1:RecordAudio("1101105119", var_496_11)
						arg_493_1:RecordAudio("1101105119", var_496_11)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105119", "story_v_side_new_1101105.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_12 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_12 and arg_493_1.time_ < var_496_4 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play1101105120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1101105120
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1101105121(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1011ui_story"]) and arg_497_1.var_.characterEffect1011ui_story == nil then
				arg_497_1.var_.characterEffect1011ui_story = arg_497_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1011ui_story"]) then
				if arg_497_1.var_.characterEffect1011ui_story and not isNil(arg_497_1.actors_["1011ui_story"]) then
					arg_497_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_0)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1011ui_story"]) and arg_497_1.var_.characterEffect1011ui_story then
				arg_497_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_500_1 = 0
			local var_500_2 = 0.175

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_3 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1101105120).content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 7 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 7)

				if (7 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 7)) > 0 and var_500_2 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_6 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_6 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_6

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_6 and arg_497_1.time_ < var_500_1 + var_500_6 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1101105121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1101105121
		arg_501_1.duration_ = 5.63

		local var_501_0 = {
			zh = 3.6,
			ja = 5.633
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1101105122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1011ui_story = arg_501_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_504_0 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 then
				arg_501_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_501_1.time_ - 0) / var_504_0)
				arg_501_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1011ui_story"].transform.position).z)
				arg_501_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1011ui_story"].transform.localEulerAngles = arg_501_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 then
				arg_501_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_501_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1011ui_story"].transform.position).z)
				arg_501_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1011ui_story"].transform.localEulerAngles = arg_501_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_504_1 = arg_501_1.actors_["1011ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1011ui_story == nil then
				arg_501_1.var_.characterEffect1011ui_story = var_504_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_2 and not isNil(var_504_1) then
				if arg_501_1.var_.characterEffect1011ui_story and not isNil(var_504_1) then
					arg_501_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_2 and arg_501_1.time_ < 0 + var_504_2 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1011ui_story then
				arg_501_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action435")
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_504_4 = 0

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.allBtn_.enabled = false
			end

			if arg_501_1.time_ >= var_504_4 + 1.46666666666667 and arg_501_1.time_ < var_504_4 + 1.46666666666667 + arg_504_0 then
				arg_501_1.allBtn_.enabled = true
			end

			local var_504_5 = 0
			local var_504_6 = 0.275

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_5 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_7 = arg_501_1:GetWordFromCfg(1101105121)
				local var_504_8 = arg_501_1:FormatText(var_504_7.content)

				arg_501_1.text_.text = var_504_8

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_10 = 11 <= 0 and var_504_6 or var_504_6 * (utf8.len(var_504_8) / 11)

				if (11 <= 0 and var_504_6 or var_504_6 * (utf8.len(var_504_8) / 11)) > 0 and var_504_6 < var_504_10 then
					arg_501_1.talkMaxDuration = var_504_10

					if var_504_10 + var_504_5 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_10 + var_504_5
					end
				end

				arg_501_1.text_.text = var_504_8
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb") ~= 0 then
					local var_504_11 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb") / 1000

					if var_504_11 + var_504_5 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_11 + var_504_5
					end

					if var_504_7.prefab_name ~= "" and arg_501_1.actors_[var_504_7.prefab_name] ~= nil then
						local var_504_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_7.prefab_name].transform, "story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb")

						arg_501_1:RecordAudio("1101105121", var_504_12)
						arg_501_1:RecordAudio("1101105121", var_504_12)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105121", "story_v_side_new_1101105.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_13 = math.max(var_504_6, arg_501_1.talkMaxDuration)

			if var_504_5 <= arg_501_1.time_ and arg_501_1.time_ < var_504_5 + var_504_13 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_5) / var_504_13

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_5 + var_504_13 and arg_501_1.time_ < var_504_5 + var_504_13 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play1101105122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1101105122
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1101105123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1011ui_story"]) and arg_505_1.var_.characterEffect1011ui_story == nil then
				arg_505_1.var_.characterEffect1011ui_story = arg_505_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1011ui_story"]) then
				if arg_505_1.var_.characterEffect1011ui_story and not isNil(arg_505_1.actors_["1011ui_story"]) then
					arg_505_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_0)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1011ui_story"]) and arg_505_1.var_.characterEffect1011ui_story then
				arg_505_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_508_1 = 0
			local var_508_2 = 0.275

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_3 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(1101105122).content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 11 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 11)

				if (11 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 11)) > 0 and var_508_2 < var_508_5 then
					arg_505_1.talkMaxDuration = var_508_5

					if var_508_5 + var_508_1 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + var_508_1
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_6 = math.max(var_508_2, arg_505_1.talkMaxDuration)

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_6 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_1) / var_508_6

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_1 + var_508_6 and arg_505_1.time_ < var_508_1 + var_508_6 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1101105123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1101105123
		arg_509_1.duration_ = 6.47

		local var_509_0 = {
			zh = 6.466,
			ja = 3.233
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1101105124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1011ui_story = arg_509_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_512_0 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 then
				arg_509_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_509_1.time_ - 0) / var_512_0)
				arg_509_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1011ui_story"].transform.position).z)
				arg_509_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1011ui_story"].transform.localEulerAngles = arg_509_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 then
				arg_509_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_509_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1011ui_story"].transform.position).z)
				arg_509_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1011ui_story"].transform.localEulerAngles = arg_509_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_512_1 = arg_509_1.actors_["1011ui_story"]

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(var_512_1) and arg_509_1.var_.characterEffect1011ui_story == nil then
				arg_509_1.var_.characterEffect1011ui_story = var_512_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.200000002980232

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_2 and not isNil(var_512_1) then
				if arg_509_1.var_.characterEffect1011ui_story and not isNil(var_512_1) then
					arg_509_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= 0 + var_512_2 and arg_509_1.time_ < 0 + var_512_2 + arg_512_0 and not isNil(var_512_1) and arg_509_1.var_.characterEffect1011ui_story then
				arg_509_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_2")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_512_4 = 0
			local var_512_5 = 0.7

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_4 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_6 = arg_509_1:GetWordFromCfg(1101105123)
				local var_512_7 = arg_509_1:FormatText(var_512_6.content)

				arg_509_1.text_.text = var_512_7

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_9 = 28 <= 0 and var_512_5 or var_512_5 * (utf8.len(var_512_7) / 28)

				if (28 <= 0 and var_512_5 or var_512_5 * (utf8.len(var_512_7) / 28)) > 0 and var_512_5 < var_512_9 then
					arg_509_1.talkMaxDuration = var_512_9

					if var_512_9 + var_512_4 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_9 + var_512_4
					end
				end

				arg_509_1.text_.text = var_512_7
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb") ~= 0 then
					local var_512_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb") / 1000

					if var_512_10 + var_512_4 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_10 + var_512_4
					end

					if var_512_6.prefab_name ~= "" and arg_509_1.actors_[var_512_6.prefab_name] ~= nil then
						local var_512_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_6.prefab_name].transform, "story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb")

						arg_509_1:RecordAudio("1101105123", var_512_11)
						arg_509_1:RecordAudio("1101105123", var_512_11)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105123", "story_v_side_new_1101105.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_12 = math.max(var_512_5, arg_509_1.talkMaxDuration)

			if var_512_4 <= arg_509_1.time_ and arg_509_1.time_ < var_512_4 + var_512_12 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_4) / var_512_12

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_4 + var_512_12 and arg_509_1.time_ < var_512_4 + var_512_12 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_509_1:InitPlayNodeList()
	end,
	Play1101105124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1101105124
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1101105125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1011ui_story"]) and arg_513_1.var_.characterEffect1011ui_story == nil then
				arg_513_1.var_.characterEffect1011ui_story = arg_513_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1011ui_story"]) then
				if arg_513_1.var_.characterEffect1011ui_story and not isNil(arg_513_1.actors_["1011ui_story"]) then
					arg_513_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_0)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1011ui_story"]) and arg_513_1.var_.characterEffect1011ui_story then
				arg_513_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_516_1 = 0
			local var_516_2 = 0.675

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_3 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(1101105124).content)

				arg_513_1.text_.text = var_516_3

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 27 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 27)

				if (27 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 27)) > 0 and var_516_2 < var_516_5 then
					arg_513_1.talkMaxDuration = var_516_5

					if var_516_5 + var_516_1 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + var_516_1
					end
				end

				arg_513_1.text_.text = var_516_3
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_6 = math.max(var_516_2, arg_513_1.talkMaxDuration)

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_6 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_1) / var_516_6

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_1 + var_516_6 and arg_513_1.time_ < var_516_1 + var_516_6 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1101105125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1101105125
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1101105126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.5

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(1101105125).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 20 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 20)

				if (20 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 20)) > 0 and var_520_0 < var_520_3 then
					arg_517_1.talkMaxDuration = var_520_3

					if var_520_3 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_3 + 0
					end
				end

				arg_517_1.text_.text = var_520_1
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_4 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_4

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1101105126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1101105126
		arg_521_1.duration_ = 16.63

		local var_521_0 = {
			zh = 8.766,
			ja = 16.633
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1101105127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.var_.moveOldPos1011ui_story = arg_521_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_524_0 = 0.001

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 then
				arg_521_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_521_1.time_ - 0) / var_524_0)
				arg_521_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_521_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1011ui_story"].transform.position).z)
				arg_521_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_521_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_521_1.actors_["1011ui_story"].transform.localEulerAngles = arg_521_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 then
				arg_521_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_521_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_521_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1011ui_story"].transform.position).z)
				arg_521_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_521_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_521_1.actors_["1011ui_story"].transform.localEulerAngles = arg_521_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_524_1 = arg_521_1.actors_["1011ui_story"]

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1011ui_story == nil then
				arg_521_1.var_.characterEffect1011ui_story = var_524_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_2 and not isNil(var_524_1) then
				if arg_521_1.var_.characterEffect1011ui_story and not isNil(var_524_1) then
					arg_521_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= 0 + var_524_2 and arg_521_1.time_ < 0 + var_524_2 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1011ui_story then
				arg_521_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_524_4 = 0
			local var_524_5 = 0.875

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(1101105126)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_9 = 35 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 35)

				if (35 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 35)) > 0 and var_524_5 < var_524_9 then
					arg_521_1.talkMaxDuration = var_524_9

					if var_524_9 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_9 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb") ~= 0 then
					local var_524_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb") / 1000

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end

					if var_524_6.prefab_name ~= "" and arg_521_1.actors_[var_524_6.prefab_name] ~= nil then
						local var_524_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_6.prefab_name].transform, "story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb")

						arg_521_1:RecordAudio("1101105126", var_524_11)
						arg_521_1:RecordAudio("1101105126", var_524_11)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105126", "story_v_side_new_1101105.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_12 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_12 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_12

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_12 and arg_521_1.time_ < var_524_4 + var_524_12 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_521_1:InitPlayNodeList()
	end,
	Play1101105127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1101105127
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1101105128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["1011ui_story"]) and arg_525_1.var_.characterEffect1011ui_story == nil then
				arg_525_1.var_.characterEffect1011ui_story = arg_525_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_0 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["1011ui_story"]) then
				if arg_525_1.var_.characterEffect1011ui_story and not isNil(arg_525_1.actors_["1011ui_story"]) then
					arg_525_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_525_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_525_1.time_ - 0) / var_528_0)
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["1011ui_story"]) and arg_525_1.var_.characterEffect1011ui_story then
				arg_525_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_525_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_528_1 = 0
			local var_528_2 = 0.45

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_3 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(1101105127).content)

				arg_525_1.text_.text = var_528_3

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 18 <= 0 and var_528_2 or var_528_2 * (utf8.len(var_528_3) / 18)

				if (18 <= 0 and var_528_2 or var_528_2 * (utf8.len(var_528_3) / 18)) > 0 and var_528_2 < var_528_5 then
					arg_525_1.talkMaxDuration = var_528_5

					if var_528_5 + var_528_1 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + var_528_1
					end
				end

				arg_525_1.text_.text = var_528_3
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_6 = math.max(var_528_2, arg_525_1.talkMaxDuration)

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_6 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_1) / var_528_6

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_1 + var_528_6 and arg_525_1.time_ < var_528_1 + var_528_6 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1101105128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1101105128
		arg_529_1.duration_ = 13.87

		local var_529_0 = {
			zh = 7.566,
			ja = 13.866
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1101105129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos1011ui_story = arg_529_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_532_0 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 then
				arg_529_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_529_1.time_ - 0) / var_532_0)
				arg_529_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1011ui_story"].transform.position).z)
				arg_529_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["1011ui_story"].transform.localEulerAngles = arg_529_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 then
				arg_529_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_529_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1011ui_story"].transform.position).z)
				arg_529_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["1011ui_story"].transform.localEulerAngles = arg_529_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_532_1 = arg_529_1.actors_["1011ui_story"]

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(var_532_1) and arg_529_1.var_.characterEffect1011ui_story == nil then
				arg_529_1.var_.characterEffect1011ui_story = var_532_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_2 and not isNil(var_532_1) then
				if arg_529_1.var_.characterEffect1011ui_story and not isNil(var_532_1) then
					arg_529_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= 0 + var_532_2 and arg_529_1.time_ < 0 + var_532_2 + arg_532_0 and not isNil(var_532_1) and arg_529_1.var_.characterEffect1011ui_story then
				arg_529_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_532_4 = 0
			local var_532_5 = 0.925

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_4 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_6 = arg_529_1:GetWordFromCfg(1101105128)
				local var_532_7 = arg_529_1:FormatText(var_532_6.content)

				arg_529_1.text_.text = var_532_7

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_9 = 37 <= 0 and var_532_5 or var_532_5 * (utf8.len(var_532_7) / 37)

				if (37 <= 0 and var_532_5 or var_532_5 * (utf8.len(var_532_7) / 37)) > 0 and var_532_5 < var_532_9 then
					arg_529_1.talkMaxDuration = var_532_9

					if var_532_9 + var_532_4 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_9 + var_532_4
					end
				end

				arg_529_1.text_.text = var_532_7
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb") ~= 0 then
					local var_532_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb") / 1000

					if var_532_10 + var_532_4 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_10 + var_532_4
					end

					if var_532_6.prefab_name ~= "" and arg_529_1.actors_[var_532_6.prefab_name] ~= nil then
						local var_532_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_6.prefab_name].transform, "story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb")

						arg_529_1:RecordAudio("1101105128", var_532_11)
						arg_529_1:RecordAudio("1101105128", var_532_11)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105128", "story_v_side_new_1101105.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_12 = math.max(var_532_5, arg_529_1.talkMaxDuration)

			if var_532_4 <= arg_529_1.time_ and arg_529_1.time_ < var_532_4 + var_532_12 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_4) / var_532_12

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_4 + var_532_12 and arg_529_1.time_ < var_532_4 + var_532_12 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play1101105129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1101105129
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1101105130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["1011ui_story"]) and arg_533_1.var_.characterEffect1011ui_story == nil then
				arg_533_1.var_.characterEffect1011ui_story = arg_533_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_0 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["1011ui_story"]) then
				if arg_533_1.var_.characterEffect1011ui_story and not isNil(arg_533_1.actors_["1011ui_story"]) then
					arg_533_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_0)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["1011ui_story"]) and arg_533_1.var_.characterEffect1011ui_story then
				arg_533_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_536_1 = 0
			local var_536_2 = 0.175

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(1101105129).content)

				arg_533_1.text_.text = var_536_3

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 7 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 7)

				if (7 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 7)) > 0 and var_536_2 < var_536_5 then
					arg_533_1.talkMaxDuration = var_536_5

					if var_536_5 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + var_536_1
					end
				end

				arg_533_1.text_.text = var_536_3
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_6 = math.max(var_536_2, arg_533_1.talkMaxDuration)

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_6 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_1) / var_536_6

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_1 + var_536_6 and arg_533_1.time_ < var_536_1 + var_536_6 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1101105130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1101105130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1101105131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.625

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
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

				local var_540_1 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1101105130).content)

				arg_537_1.text_.text = var_540_1

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_3 = 25 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 25)

				if (25 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 25)) > 0 and var_540_0 < var_540_3 then
					arg_537_1.talkMaxDuration = var_540_3

					if var_540_3 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_3 + 0
					end
				end

				arg_537_1.text_.text = var_540_1
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_4 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_4

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1101105131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1101105131
		arg_541_1.duration_ = 6.67

		local var_541_0 = {
			zh = 6.666,
			ja = 4.766
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1101105132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1011ui_story = arg_541_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1011ui_story"].transform.position).z)
				arg_541_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1011ui_story"].transform.localEulerAngles = arg_541_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_541_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1011ui_story"].transform.position).z)
				arg_541_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1011ui_story"].transform.localEulerAngles = arg_541_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_544_1 = arg_541_1.actors_["1011ui_story"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_1) and arg_541_1.var_.characterEffect1011ui_story == nil then
				arg_541_1.var_.characterEffect1011ui_story = var_544_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_2 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_2 and not isNil(var_544_1) then
				if arg_541_1.var_.characterEffect1011ui_story and not isNil(var_544_1) then
					arg_541_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= 0 + var_544_2 and arg_541_1.time_ < 0 + var_544_2 + arg_544_0 and not isNil(var_544_1) and arg_541_1.var_.characterEffect1011ui_story then
				arg_541_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action447")
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_544_4 = 0
			local var_544_5 = 0.8

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_4 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_6 = arg_541_1:GetWordFromCfg(1101105131)
				local var_544_7 = arg_541_1:FormatText(var_544_6.content)

				arg_541_1.text_.text = var_544_7

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_9 = 32 <= 0 and var_544_5 or var_544_5 * (utf8.len(var_544_7) / 32)

				if (32 <= 0 and var_544_5 or var_544_5 * (utf8.len(var_544_7) / 32)) > 0 and var_544_5 < var_544_9 then
					arg_541_1.talkMaxDuration = var_544_9

					if var_544_9 + var_544_4 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_9 + var_544_4
					end
				end

				arg_541_1.text_.text = var_544_7
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb") ~= 0 then
					local var_544_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb") / 1000

					if var_544_10 + var_544_4 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_10 + var_544_4
					end

					if var_544_6.prefab_name ~= "" and arg_541_1.actors_[var_544_6.prefab_name] ~= nil then
						local var_544_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_6.prefab_name].transform, "story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb")

						arg_541_1:RecordAudio("1101105131", var_544_11)
						arg_541_1:RecordAudio("1101105131", var_544_11)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105131", "story_v_side_new_1101105.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_12 = math.max(var_544_5, arg_541_1.talkMaxDuration)

			if var_544_4 <= arg_541_1.time_ and arg_541_1.time_ < var_544_4 + var_544_12 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_4) / var_544_12

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_4 + var_544_12 and arg_541_1.time_ < var_544_4 + var_544_12 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play1101105132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1101105132
		arg_545_1.duration_ = 7.9

		local var_545_0 = {
			zh = 6.5,
			ja = 7.9
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1101105133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1011ui_story = arg_545_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_548_0 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				arg_545_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_545_1.time_ - 0) / var_548_0)
				arg_545_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).z)
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles = arg_545_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				arg_545_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_545_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).z)
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles = arg_545_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_548_1 = arg_545_1.actors_["1011ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1011ui_story == nil then
				arg_545_1.var_.characterEffect1011ui_story = var_548_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_2 and not isNil(var_548_1) then
				if arg_545_1.var_.characterEffect1011ui_story and not isNil(var_548_1) then
					arg_545_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_2 and arg_545_1.time_ < 0 + var_548_2 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1011ui_story then
				arg_545_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_2")
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_548_4 = 0
			local var_548_5 = 0.725

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_4 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_6 = arg_545_1:GetWordFromCfg(1101105132)
				local var_548_7 = arg_545_1:FormatText(var_548_6.content)

				arg_545_1.text_.text = var_548_7

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 27 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 27)

				if (27 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 27)) > 0 and var_548_5 < var_548_9 then
					arg_545_1.talkMaxDuration = var_548_9

					if var_548_9 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_4
					end
				end

				arg_545_1.text_.text = var_548_7
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb") ~= 0 then
					local var_548_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb") / 1000

					if var_548_10 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_10 + var_548_4
					end

					if var_548_6.prefab_name ~= "" and arg_545_1.actors_[var_548_6.prefab_name] ~= nil then
						local var_548_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_6.prefab_name].transform, "story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb")

						arg_545_1:RecordAudio("1101105132", var_548_11)
						arg_545_1:RecordAudio("1101105132", var_548_11)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105132", "story_v_side_new_1101105.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_12 = math.max(var_548_5, arg_545_1.talkMaxDuration)

			if var_548_4 <= arg_545_1.time_ and arg_545_1.time_ < var_548_4 + var_548_12 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_4) / var_548_12

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_4 + var_548_12 and arg_545_1.time_ < var_548_4 + var_548_12 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play1101105133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1101105133
		arg_549_1.duration_ = 7.23

		local var_549_0 = {
			zh = 3.533,
			ja = 7.233
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1101105134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.3

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_1 = arg_549_1:GetWordFromCfg(1101105133)
				local var_552_2 = arg_549_1:FormatText(var_552_1.content)

				arg_549_1.text_.text = var_552_2

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 12 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 12)

				if (12 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 12)) > 0 and var_552_0 < var_552_4 then
					arg_549_1.talkMaxDuration = var_552_4

					if var_552_4 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_4 + 0
					end
				end

				arg_549_1.text_.text = var_552_2
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb") ~= 0 then
					local var_552_5 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb") / 1000

					if var_552_5 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + 0
					end

					if var_552_1.prefab_name ~= "" and arg_549_1.actors_[var_552_1.prefab_name] ~= nil then
						local var_552_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_1.prefab_name].transform, "story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb")

						arg_549_1:RecordAudio("1101105133", var_552_6)
						arg_549_1:RecordAudio("1101105133", var_552_6)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105133", "story_v_side_new_1101105.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_7 and arg_549_1.time_ < 0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1101105134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1101105134
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1101105135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1011ui_story"]) and arg_553_1.var_.characterEffect1011ui_story == nil then
				arg_553_1.var_.characterEffect1011ui_story = arg_553_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1011ui_story"]) then
				if arg_553_1.var_.characterEffect1011ui_story and not isNil(arg_553_1.actors_["1011ui_story"]) then
					arg_553_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_553_1.time_ - 0) / var_556_0)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1011ui_story"]) and arg_553_1.var_.characterEffect1011ui_story then
				arg_553_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_556_1 = 0
			local var_556_2 = 0.725

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_3 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(1101105134).content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 29 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_3) / 29)

				if (29 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_3) / 29)) > 0 and var_556_2 < var_556_5 then
					arg_553_1.talkMaxDuration = var_556_5

					if var_556_5 + var_556_1 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_5 + var_556_1
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_6 = math.max(var_556_2, arg_553_1.talkMaxDuration)

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_6 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_1) / var_556_6

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_1 + var_556_6 and arg_553_1.time_ < var_556_1 + var_556_6 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1101105135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1101105135
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1101105136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.1

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_1 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(1101105135).content)

				arg_557_1.text_.text = var_560_1

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_3 = 4 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_1) / 4)

				if (4 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_1) / 4)) > 0 and var_560_0 < var_560_3 then
					arg_557_1.talkMaxDuration = var_560_3

					if var_560_3 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_3 + 0
					end
				end

				arg_557_1.text_.text = var_560_1
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_4 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_4 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_4

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_4 and arg_557_1.time_ < 0 + var_560_4 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1101105136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1101105136
		arg_561_1.duration_ = 3.17

		local var_561_0 = {
			zh = 1.866,
			ja = 3.166
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1101105137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos1011ui_story = arg_561_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_564_0 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 then
				arg_561_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_561_1.time_ - 0) / var_564_0)
				arg_561_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).z)
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles = arg_561_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 then
				arg_561_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_561_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).z)
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles = arg_561_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_564_1 = arg_561_1.actors_["1011ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1011ui_story == nil then
				arg_561_1.var_.characterEffect1011ui_story = var_564_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_2 and not isNil(var_564_1) then
				if arg_561_1.var_.characterEffect1011ui_story and not isNil(var_564_1) then
					arg_561_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_2 and arg_561_1.time_ < 0 + var_564_2 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1011ui_story then
				arg_561_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_564_4 = 0
			local var_564_5 = 0.075

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_6 = arg_561_1:GetWordFromCfg(1101105136)
				local var_564_7 = arg_561_1:FormatText(var_564_6.content)

				arg_561_1.text_.text = var_564_7

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_9 = 3 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 3)

				if (3 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 3)) > 0 and var_564_5 < var_564_9 then
					arg_561_1.talkMaxDuration = var_564_9

					if var_564_9 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_9 + var_564_4
					end
				end

				arg_561_1.text_.text = var_564_7
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb") ~= 0 then
					local var_564_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb") / 1000

					if var_564_10 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_10 + var_564_4
					end

					if var_564_6.prefab_name ~= "" and arg_561_1.actors_[var_564_6.prefab_name] ~= nil then
						local var_564_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_6.prefab_name].transform, "story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb")

						arg_561_1:RecordAudio("1101105136", var_564_11)
						arg_561_1:RecordAudio("1101105136", var_564_11)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105136", "story_v_side_new_1101105.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_12 = math.max(var_564_5, arg_561_1.talkMaxDuration)

			if var_564_4 <= arg_561_1.time_ and arg_561_1.time_ < var_564_4 + var_564_12 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_4) / var_564_12

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_4 + var_564_12 and arg_561_1.time_ < var_564_4 + var_564_12 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play1101105137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1101105137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1101105138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1011ui_story"]) and arg_565_1.var_.characterEffect1011ui_story == nil then
				arg_565_1.var_.characterEffect1011ui_story = arg_565_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1011ui_story"]) then
				if arg_565_1.var_.characterEffect1011ui_story and not isNil(arg_565_1.actors_["1011ui_story"]) then
					arg_565_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 0) / var_568_0)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1011ui_story"]) and arg_565_1.var_.characterEffect1011ui_story then
				arg_565_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_568_1 = arg_565_1.actors_["1011ui_story"].transform

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.var_.moveOldPos1011ui_story = var_568_1.localPosition
			end

			local var_568_2 = 0.001

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_2 then
				var_568_1.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_565_1.time_ - 0) / var_568_2)
				var_568_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_568_1.position).x, (manager.ui.mainCamera.transform.position - var_568_1.position).y, (manager.ui.mainCamera.transform.position - var_568_1.position).z)
				var_568_1.localEulerAngles.z = 0
				var_568_1.localEulerAngles.x = 0
				var_568_1.localEulerAngles = var_568_1.localEulerAngles
			end

			if arg_565_1.time_ >= 0 + var_568_2 and arg_565_1.time_ < 0 + var_568_2 + arg_568_0 then
				var_568_1.localPosition = Vector3.New(0, 100, 0)
				var_568_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_568_1.position).x, (manager.ui.mainCamera.transform.position - var_568_1.position).y, (manager.ui.mainCamera.transform.position - var_568_1.position).z)
				var_568_1.localEulerAngles.z = 0
				var_568_1.localEulerAngles.x = 0
				var_568_1.localEulerAngles = var_568_1.localEulerAngles
			end

			local var_568_3 = 0
			local var_568_4 = 0.525

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_3 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, false)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_5 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(1101105137).content)

				arg_565_1.text_.text = var_568_5

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_7 = 21 <= 0 and var_568_4 or var_568_4 * (utf8.len(var_568_5) / 21)

				if (21 <= 0 and var_568_4 or var_568_4 * (utf8.len(var_568_5) / 21)) > 0 and var_568_4 < var_568_7 then
					arg_565_1.talkMaxDuration = var_568_7

					if var_568_7 + var_568_3 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_3
					end
				end

				arg_565_1.text_.text = var_568_5
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_8 = math.max(var_568_4, arg_565_1.talkMaxDuration)

			if var_568_3 <= arg_565_1.time_ and arg_565_1.time_ < var_568_3 + var_568_8 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_3) / var_568_8

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_3 + var_568_8 and arg_565_1.time_ < var_568_3 + var_568_8 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play1101105138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1101105138
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1101105139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(arg_569_1.actors_["1011ui_story"]) and arg_569_1.var_.characterEffect1011ui_story == nil then
				arg_569_1.var_.characterEffect1011ui_story = arg_569_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_0 = 0.200000002980232

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 and not isNil(arg_569_1.actors_["1011ui_story"]) then
				if arg_569_1.var_.characterEffect1011ui_story and not isNil(arg_569_1.actors_["1011ui_story"]) then
					arg_569_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_569_1.time_ - 0) / var_572_0)
				end
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 and not isNil(arg_569_1.actors_["1011ui_story"]) and arg_569_1.var_.characterEffect1011ui_story then
				arg_569_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_572_1 = arg_569_1.actors_["1011ui_story"].transform

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.var_.moveOldPos1011ui_story = var_572_1.localPosition
			end

			local var_572_2 = 0.001

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_2 then
				var_572_1.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_569_1.time_ - 0) / var_572_2)
				var_572_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_572_1.position).x, (manager.ui.mainCamera.transform.position - var_572_1.position).y, (manager.ui.mainCamera.transform.position - var_572_1.position).z)
				var_572_1.localEulerAngles.z = 0
				var_572_1.localEulerAngles.x = 0
				var_572_1.localEulerAngles = var_572_1.localEulerAngles
			end

			if arg_569_1.time_ >= 0 + var_572_2 and arg_569_1.time_ < 0 + var_572_2 + arg_572_0 then
				var_572_1.localPosition = Vector3.New(0, -0.71, -6)
				var_572_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_572_1.position).x, (manager.ui.mainCamera.transform.position - var_572_1.position).y, (manager.ui.mainCamera.transform.position - var_572_1.position).z)
				var_572_1.localEulerAngles.z = 0
				var_572_1.localEulerAngles.x = 0
				var_572_1.localEulerAngles = var_572_1.localEulerAngles
			end

			local var_572_3 = 0
			local var_572_4 = 0.65

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_3 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_5 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(1101105138).content)

				arg_569_1.text_.text = var_572_5

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_7 = 26 <= 0 and var_572_4 or var_572_4 * (utf8.len(var_572_5) / 26)

				if (26 <= 0 and var_572_4 or var_572_4 * (utf8.len(var_572_5) / 26)) > 0 and var_572_4 < var_572_7 then
					arg_569_1.talkMaxDuration = var_572_7

					if var_572_7 + var_572_3 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_7 + var_572_3
					end
				end

				arg_569_1.text_.text = var_572_5
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_8 = math.max(var_572_4, arg_569_1.talkMaxDuration)

			if var_572_3 <= arg_569_1.time_ and arg_569_1.time_ < var_572_3 + var_572_8 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_3) / var_572_8

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_3 + var_572_8 and arg_569_1.time_ < var_572_3 + var_572_8 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play1101105139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1101105139
		arg_573_1.duration_ = 2.57

		local var_573_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
			arg_573_1.auto_ = false
		end

		function arg_573_1.playNext_(arg_575_0)
			arg_573_1.onStoryFinished_()
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1011ui_story = arg_573_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_576_0 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 then
				arg_573_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_573_1.time_ - 0) / var_576_0)
				arg_573_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1011ui_story"].transform.position).z)
				arg_573_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["1011ui_story"].transform.localEulerAngles = arg_573_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 then
				arg_573_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_573_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1011ui_story"].transform.position).z)
				arg_573_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["1011ui_story"].transform.localEulerAngles = arg_573_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_576_1 = arg_573_1.actors_["1011ui_story"]

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(var_576_1) and arg_573_1.var_.characterEffect1011ui_story == nil then
				arg_573_1.var_.characterEffect1011ui_story = var_576_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_2 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_2 and not isNil(var_576_1) then
				if arg_573_1.var_.characterEffect1011ui_story and not isNil(var_576_1) then
					arg_573_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= 0 + var_576_2 and arg_573_1.time_ < 0 + var_576_2 + arg_576_0 and not isNil(var_576_1) and arg_573_1.var_.characterEffect1011ui_story then
				arg_573_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_576_4 = 0
			local var_576_5 = 0.05

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_4 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_6 = arg_573_1:GetWordFromCfg(1101105139)
				local var_576_7 = arg_573_1:FormatText(var_576_6.content)

				arg_573_1.text_.text = var_576_7

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_9 = 2 <= 0 and var_576_5 or var_576_5 * (utf8.len(var_576_7) / 2)

				if (2 <= 0 and var_576_5 or var_576_5 * (utf8.len(var_576_7) / 2)) > 0 and var_576_5 < var_576_9 then
					arg_573_1.talkMaxDuration = var_576_9

					if var_576_9 + var_576_4 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_9 + var_576_4
					end
				end

				arg_573_1.text_.text = var_576_7
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb") ~= 0 then
					local var_576_10 = manager.audio:GetVoiceLength("story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb") / 1000

					if var_576_10 + var_576_4 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_10 + var_576_4
					end

					if var_576_6.prefab_name ~= "" and arg_573_1.actors_[var_576_6.prefab_name] ~= nil then
						local var_576_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_6.prefab_name].transform, "story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb")

						arg_573_1:RecordAudio("1101105139", var_576_11)
						arg_573_1:RecordAudio("1101105139", var_576_11)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1101105", "1101105139", "story_v_side_new_1101105.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_12 = math.max(var_576_5, arg_573_1.talkMaxDuration)

			if var_576_4 <= arg_573_1.time_ and arg_573_1.time_ < var_576_4 + var_576_12 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_4) / var_576_12

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_4 + var_576_12 and arg_573_1.time_ < var_576_4 + var_576_12 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D999",
		"TextureConfig/Background/ST01_blur",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_side_new_1101105.awb"
	}
}
