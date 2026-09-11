return {
	Play1109511001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109511001
		arg_1_1.duration_ = 4.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109511002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0104 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0104")
				var_4_0.name = "ST0104"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0104 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0104

				arg_1_1.bgs_.ST0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0104" then
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

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

			local var_4_14 = 1.83333333333333
			local var_4_15 = 0.275

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1140].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(1109511001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 11 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 11)

				if (11 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 11)) > 0 and var_4_15 < var_4_20 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb")

						arg_1_1:RecordAudio("1109511001", var_4_22)
						arg_1_1:RecordAudio("1109511001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511001", "story_v_side_new_1109511.awb")
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
	Play1109511002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1109511002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1109511003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1109511002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 5 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 5)

				if (5 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 5)) > 0 and var_11_0 < var_11_3 then
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
	Play1109511003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1109511003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1109511004(arg_12_1)
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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1109511003).content)

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
	Play1109511004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1109511004
		arg_16_1.duration_ = 3.23

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1109511005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1140].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(1109511004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 14 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 14)

				if (14 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 14)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb")

						arg_16_1:RecordAudio("1109511004", var_19_6)
						arg_16_1:RecordAudio("1109511004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511004", "story_v_side_new_1109511.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1109511005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1109511005
		arg_20_1.duration_ = 1

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"

			SetActive(arg_20_1.choicesGo_, true)

			for iter_21_0, iter_21_1 in ipairs(arg_20_1.choices_) do
				SetActive(iter_21_1.go, iter_21_0 <= 2)
			end

			arg_20_1.choices_[1].txt.text = arg_20_1:FormatText(StoryChoiceCfg[1743].name)
			arg_20_1.choices_[2].txt.text = arg_20_1:FormatText(StoryChoiceCfg[1744].name)
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1109511006(arg_20_1)
			end

			if arg_22_0 == 2 then
				arg_20_0:Play1109511006(arg_20_1)
			end

			arg_20_1:RecordChoiceLog(1109511005, 1743, 1744)
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			return
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1109511006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1109511006
		arg_24_1.duration_ = 4.97

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1109511007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.5

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1140].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(1109511006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 20 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 20)

				if (20 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 20)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb")

						arg_24_1:RecordAudio("1109511006", var_27_6)
						arg_24_1:RecordAudio("1109511006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511006", "story_v_side_new_1109511.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1109511007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1109511007
		arg_28_1.duration_ = 2.67

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1109511008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.3

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1140].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(1109511007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 12 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 12)

				if (12 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 12)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb")

						arg_28_1:RecordAudio("1109511007", var_31_6)
						arg_28_1:RecordAudio("1109511007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511007", "story_v_side_new_1109511.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1109511008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1109511008
		arg_32_1.duration_ = 1

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"

			SetActive(arg_32_1.choicesGo_, true)

			for iter_33_0, iter_33_1 in ipairs(arg_32_1.choices_) do
				SetActive(iter_33_1.go, iter_33_0 <= 1)
			end

			arg_32_1.choices_[1].txt.text = arg_32_1:FormatText(StoryChoiceCfg[1745].name)
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1109511009(arg_32_1)
			end

			arg_32_1:RecordChoiceLog(1109511008, 1745)
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			return
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1109511009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1109511009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1109511010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.875

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

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(1109511009).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 35 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 35)

				if (35 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 35)) > 0 and var_39_0 < var_39_3 then
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
	Play1109511010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1109511010
		arg_40_1.duration_ = 5.9

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1109511011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.4

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1140].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(1109511010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 16 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 16)

				if (16 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 16)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb")

						arg_40_1:RecordAudio("1109511010", var_43_6)
						arg_40_1:RecordAudio("1109511010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511010", "story_v_side_new_1109511.awb")
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
	Play1109511011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1109511011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1109511012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.325

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

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1109511011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 13 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 13)

				if (13 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 13)) > 0 and var_47_0 < var_47_3 then
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
	Play1109511012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1109511012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1109511013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.15

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1109511012).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 46 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 46)

				if (46 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 46)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1109511013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1109511013
		arg_52_1.duration_ = 6.12

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1109511014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.bgs_.STblack == nil then
				local var_55_0 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_55_0.name = "STblack"
				var_55_0.transform.parent = arg_52_1.stage_.transform
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_.STblack = var_55_0
			end

			if 1.11666666666667 < arg_52_1.time_ and arg_52_1.time_ <= 1.11666666666667 + arg_55_0 then
				local var_55_1 = arg_52_1.bgs_.STblack

				arg_52_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_2 = var_55_1:GetComponent("SpriteRenderer")

				if var_55_2 and var_55_2.sprite then
					local var_55_3 = 2 * (var_55_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_1.transform.localScale = Vector3.New(var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "STblack" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_4 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			if arg_52_1.time_ >= var_55_4 + 0.3 and arg_52_1.time_ < var_55_4 + 0.3 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_5 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_6 = 1.11666666666667

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 then
				local var_55_7 = Color.New(0, 0, 0)

				var_55_7.a = Mathf.Lerp(0, 1, (arg_52_1.time_ - var_55_5) / var_55_6)
				arg_52_1.mask_.color = var_55_7
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 then
				local var_55_8 = Color.New(0, 0, 0)

				var_55_8.a = 1
				arg_52_1.mask_.color = var_55_8
			end

			local var_55_9 = 1.11666666666667

			if 1.11666666666667 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_10 = 1.31666666666667

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_10 then
				local var_55_11 = Color.New(0, 0, 0)

				var_55_11.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_9) / var_55_10)
				arg_52_1.mask_.color = var_55_11
			end

			if arg_52_1.time_ >= var_55_9 + var_55_10 and arg_52_1.time_ < var_55_9 + var_55_10 + arg_55_0 then
				local var_55_12 = Color.New(0, 0, 0)

				arg_52_1.mask_.enabled = false
				var_55_12.a = 0
				arg_52_1.mask_.color = var_55_12
			end

			if 1.11666666666667 < arg_52_1.time_ and arg_52_1.time_ <= 1.11666666666667 + arg_55_0 then
				local var_55_13 = arg_52_1.fswbg_.transform:Find("textbox/adapt/content") or arg_52_1.fswbg_.transform:Find("textbox/content")
				local var_55_14 = arg_52_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_55_15 = var_55_13:GetComponent("RectTransform")

				var_55_13:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_55_15.offsetMin = Vector2.New(0, 0)
				var_55_15.offsetMax = Vector2.New(0, 0)
			end

			if 1.11666666666667 < arg_52_1.time_ and arg_52_1.time_ <= 1.11666666666667 + arg_55_0 then
				arg_52_1.fswbg_:SetActive(true)
				arg_52_1.dialog_:SetActive(false)

				arg_52_1.fswtw_.percent = 0
				arg_52_1.fswt_.text = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.fswt_)

				arg_52_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_52_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_52_1.fswtw_:SetDirty()

				arg_52_1.typewritterCharCountI18N = 0

				SetActive(arg_52_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_52_1:ShowNextGo(false)
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = false,
				enableEffect = true,
				className = "StoryTextGroupNode",
				contentID = 1109511013,
				charCount = 23,
				enableLayoutChange = true,
				duration = 1.53333333333333,
				groupID = "2323",
				startTime = 2.08333333333333,
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
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play1109511014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1109511014
		arg_56_1.duration_ = 3.93

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1109511015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if arg_56_1.bgs_.X203I == nil then
				local var_59_0 = Object.Instantiate(arg_56_1.paintGo_)

				var_59_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X203I")
				var_59_0.name = "X203I"
				var_59_0.transform.parent = arg_56_1.stage_.transform
				var_59_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.bgs_.X203I = var_59_0
			end

			if 1.20000000298023 < arg_56_1.time_ and arg_56_1.time_ <= 1.20000000298023 + arg_59_0 then
				local var_59_1 = arg_56_1.bgs_.X203I

				arg_56_1.bgs_.X203I.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_59_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_2 = var_59_1:GetComponent("SpriteRenderer")

				if var_59_2 and var_59_2.sprite then
					local var_59_3 = 2 * (var_59_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_59_1.transform.localScale = Vector3.New(var_59_3 / var_59_2.sprite.bounds.size.y < var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x and var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x or var_59_3 / var_59_2.sprite.bounds.size.y, var_59_3 / var_59_2.sprite.bounds.size.y < var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x and var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x or var_59_3 / var_59_2.sprite.bounds.size.y, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "X203I" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_4 = 1.20000000298023

			if 1.20000000298023 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_4 + 0.3 and arg_56_1.time_ < var_59_4 + 0.3 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			local var_59_5 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_6 = 1.20000000298023

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 then
				local var_59_7 = Color.New(0, 0, 0)

				var_59_7.a = Mathf.Lerp(0, 1, (arg_56_1.time_ - var_59_5) / var_59_6)
				arg_56_1.mask_.color = var_59_7
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 then
				local var_59_8 = Color.New(0, 0, 0)

				var_59_8.a = 1
				arg_56_1.mask_.color = var_59_8
			end

			local var_59_9 = 1.20000000298023

			if 1.20000000298023 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_10 = 1.65

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_10 then
				local var_59_11 = Color.New(0, 0, 0)

				var_59_11.a = Mathf.Lerp(1, 0, (arg_56_1.time_ - var_59_9) / var_59_10)
				arg_56_1.mask_.color = var_59_11
			end

			if arg_56_1.time_ >= var_59_9 + var_59_10 and arg_56_1.time_ < var_59_9 + var_59_10 + arg_59_0 then
				local var_59_12 = Color.New(0, 0, 0)

				arg_56_1.mask_.enabled = false
				var_59_12.a = 0
				arg_56_1.mask_.color = var_59_12
			end

			local var_59_13 = "10058ui_story"

			if arg_56_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_59_14 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_56_1.stage_.transform)

				var_59_14.name = var_59_13
				var_59_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_[var_59_13] = var_59_14

				local var_59_15 = var_59_14:GetComponentInChildren(typeof(CharacterEffect))

				var_59_15.enabled = true

				local var_59_16 = GameObjectTools.GetOrAddComponent(var_59_14, typeof(DynamicBoneHelper))

				if var_59_16 then
					var_59_16:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_15.transform, false)

				arg_56_1.var_[var_59_13 .. "Animator"] = var_59_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_[var_59_13 .. "Animator"].applyRootMotion = true
				arg_56_1.var_[var_59_13 .. "LipSync"] = var_59_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_59_17 = arg_56_1.actors_["10058ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_17) and arg_56_1.var_.characterEffect10058ui_story == nil then
				arg_56_1.var_.characterEffect10058ui_story = var_59_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_18 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_18 and not isNil(var_59_17) then
				if arg_56_1.var_.characterEffect10058ui_story and not isNil(var_59_17) then
					arg_56_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_18 and arg_56_1.time_ < 0 + var_59_18 + arg_59_0 and not isNil(var_59_17) and arg_56_1.var_.characterEffect10058ui_story then
				arg_56_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 1.20000000298023 < arg_56_1.time_ and arg_56_1.time_ <= 1.20000000298023 + arg_59_0 then
				arg_56_1.fswbg_:SetActive(false)
				arg_56_1.dialog_:SetActive(false)
				SetActive(arg_56_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_56_1:ShowNextGo(false)
			end

			if 1.2166666696469 < arg_56_1.time_ and arg_56_1.time_ <= 1.2166666696469 + arg_59_0 then
				arg_56_1.fswbg_:SetActive(false)
				arg_56_1.dialog_:SetActive(false)
				SetActive(arg_56_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_56_1:ShowNextGo(false)
			end

			if 1 < arg_56_1.time_ and arg_56_1.time_ <= 1 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 0.2 < arg_56_1.time_ and arg_56_1.time_ <= 0.2 + arg_59_0 then
				arg_56_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 1 < arg_56_1.time_ and arg_56_1.time_ <= 1 + arg_59_0 then
				arg_56_1:AudioAction("play", "music", "bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night.awb")

				local var_59_24 = manager.audio:GetAudioName("bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night")

				if "" ~= "" then
					if arg_56_1.bgmTxt_.text ~= var_59_24 and arg_56_1.bgmTxt_.text ~= "" then
						if arg_56_1.bgmTxt2_.text ~= "" then
							arg_56_1.bgmTxt_.text = arg_56_1.bgmTxt2_.text
						end

						arg_56_1.bgmTxt2_.text = var_59_24

						arg_56_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_56_1.bgmTxt_.text = var_59_24
						arg_56_1.bgmTxt2_.text = var_59_24
					end

					if arg_56_1.bgmTimer then
						arg_56_1.bgmTimer:Stop()

						arg_56_1.bgmTimer = nil
					end

					if arg_56_1.settingData.show_music_name == 1 then
						arg_56_1.musicController:SetSelectedState("show")
						arg_56_1.musicAnimator_:Play("open", 0, 0)

						if arg_56_1.settingData.music_time ~= 0 then
							arg_56_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_56_1.settingData.music_time), function()
								if arg_56_1 == nil or isNil(arg_56_1.bgmTxt_) then
									return
								end

								arg_56_1.musicController:SetSelectedState("hide")
								arg_56_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_25 = 2.43333333333333
			local var_59_26 = 0.075

			if 2.43333333333333 < arg_56_1.time_ and arg_56_1.time_ <= var_59_25 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_27 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_27:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_56_1.dialogCg_.alpha = arg_61_0
				end))
				var_59_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_28 = arg_56_1:GetWordFromCfg(1109511014)
				local var_59_29 = arg_56_1:FormatText(var_59_28.content)

				arg_56_1.text_.text = var_59_29

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_31 = 3 <= 0 and var_59_26 or var_59_26 * (utf8.len(var_59_29) / 3)

				if (3 <= 0 and var_59_26 or var_59_26 * (utf8.len(var_59_29) / 3)) > 0 and var_59_26 < var_59_31 then
					arg_56_1.talkMaxDuration = var_59_31
					var_59_25 = var_59_25 + 0.3

					if var_59_31 + var_59_25 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_31 + var_59_25
					end
				end

				arg_56_1.text_.text = var_59_29
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb") ~= 0 then
					local var_59_32 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb") / 1000

					if var_59_32 + var_59_25 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_32 + var_59_25
					end

					if var_59_28.prefab_name ~= "" and arg_56_1.actors_[var_59_28.prefab_name] ~= nil then
						local var_59_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_28.prefab_name].transform, "story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb")

						arg_56_1:RecordAudio("1109511014", var_59_33)
						arg_56_1:RecordAudio("1109511014", var_59_33)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511014", "story_v_side_new_1109511.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_34 = var_59_25 + 0.3
			local var_59_35 = math.max(var_59_26, arg_56_1.talkMaxDuration)

			if var_59_25 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_34 + var_59_35 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_34) / var_59_35

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_34 + var_59_35 and arg_56_1.time_ < var_59_34 + var_59_35 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				groupID = "2323",
				duration = 1.53333333333333,
				className = "StoryTextGroupNode",
				startTime = 1.20000000298023,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play1109511015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109511015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109511016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10058ui_story"]) and arg_63_1.var_.characterEffect10058ui_story == nil then
				arg_63_1.var_.characterEffect10058ui_story = arg_63_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10058ui_story"]) then
				if arg_63_1.var_.characterEffect10058ui_story and not isNil(arg_63_1.actors_["10058ui_story"]) then
					arg_63_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10058ui_story"]) and arg_63_1.var_.characterEffect10058ui_story then
				arg_63_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.225

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
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

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(1109511015).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 9 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 9)

				if (9 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 9)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1109511016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109511016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109511017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.65

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1109511016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 26 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 26)

				if (26 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 26)) > 0 and var_70_0 < var_70_3 then
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
	Play1109511017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109511017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1109511018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.75

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1109511017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 30 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 30)

				if (30 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 30)) > 0 and var_74_0 < var_74_3 then
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
	Play1109511018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109511018
		arg_75_1.duration_ = 3.83

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109511019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10058ui_story = arg_75_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10058ui_story"].transform.position).z)
				arg_75_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10058ui_story"].transform.localEulerAngles = arg_75_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_75_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10058ui_story"].transform.position).z)
				arg_75_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10058ui_story"].transform.localEulerAngles = arg_75_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["10058ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect10058ui_story == nil then
				arg_75_1.var_.characterEffect10058ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect10058ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect10058ui_story then
				arg_75_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_78_4 = 0
			local var_78_5 = 0.45

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
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

				local var_78_6 = arg_75_1:GetWordFromCfg(1109511018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 18 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 18)

				if (18 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 18)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb")

						arg_75_1:RecordAudio("1109511018", var_78_11)
						arg_75_1:RecordAudio("1109511018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511018", "story_v_side_new_1109511.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_12 and arg_75_1.time_ < var_78_4 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play1109511019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1109511019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1109511020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["10058ui_story"]) and arg_79_1.var_.characterEffect10058ui_story == nil then
				arg_79_1.var_.characterEffect10058ui_story = arg_79_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["10058ui_story"]) then
				if arg_79_1.var_.characterEffect10058ui_story and not isNil(arg_79_1.actors_["10058ui_story"]) then
					arg_79_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["10058ui_story"]) and arg_79_1.var_.characterEffect10058ui_story then
				arg_79_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_82_1 = 0
			local var_82_2 = 0.5

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
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

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(1109511019).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 20 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 20)

				if (20 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 20)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1109511020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1109511020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1109511021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.525

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

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(1109511020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 21 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 21)

				if (21 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 21)) > 0 and var_86_0 < var_86_3 then
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
	Play1109511021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1109511021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1109511022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10058ui_story = arg_87_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["10058ui_story"].transform.position).z)
				arg_87_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["10058ui_story"].transform.localEulerAngles = arg_87_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["10058ui_story"].transform.position).z)
				arg_87_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["10058ui_story"].transform.localEulerAngles = arg_87_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_90_1 = 0
			local var_90_2 = 0.825

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1109511021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 33 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 33)

				if (33 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 33)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play1109511022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1109511022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1109511023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.5

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1109511022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 20 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 20)

				if (20 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 20)) > 0 and var_94_0 < var_94_3 then
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
	Play1109511023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1109511023
		arg_95_1.duration_ = 6.2

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1109511024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10058ui_story = arg_95_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10058ui_story"].transform.position).z)
				arg_95_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10058ui_story"].transform.localEulerAngles = arg_95_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_95_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10058ui_story"].transform.position).z)
				arg_95_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10058ui_story"].transform.localEulerAngles = arg_95_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["10058ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10058ui_story == nil then
				arg_95_1.var_.characterEffect10058ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect10058ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10058ui_story then
				arg_95_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action425")
			end

			local var_98_4 = 0
			local var_98_5 = 0.725

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(1109511023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 29 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 29)

				if (29 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 29)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb")

						arg_95_1:RecordAudio("1109511023", var_98_11)
						arg_95_1:RecordAudio("1109511023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511023", "story_v_side_new_1109511.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play1109511024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1109511024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1109511025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["10058ui_story"]) and arg_99_1.var_.characterEffect10058ui_story == nil then
				arg_99_1.var_.characterEffect10058ui_story = arg_99_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["10058ui_story"]) then
				if arg_99_1.var_.characterEffect10058ui_story and not isNil(arg_99_1.actors_["10058ui_story"]) then
					arg_99_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["10058ui_story"]) and arg_99_1.var_.characterEffect10058ui_story then
				arg_99_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.525

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
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

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1109511024).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 21 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 21)

				if (21 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 21)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1109511025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1109511025
		arg_103_1.duration_ = 8.73

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1109511026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10058ui_story"]) and arg_103_1.var_.characterEffect10058ui_story == nil then
				arg_103_1.var_.characterEffect10058ui_story = arg_103_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10058ui_story"]) then
				if arg_103_1.var_.characterEffect10058ui_story and not isNil(arg_103_1.actors_["10058ui_story"]) then
					arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10058ui_story"]) and arg_103_1.var_.characterEffect10058ui_story then
				arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_106_2 = 0
			local var_106_3 = 0.975

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(1109511025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 39 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 39)

				if (39 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 39)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb")

						arg_103_1:RecordAudio("1109511025", var_106_9)
						arg_103_1:RecordAudio("1109511025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511025", "story_v_side_new_1109511.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1109511026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1109511026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1109511027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10058ui_story"]) and arg_107_1.var_.characterEffect10058ui_story == nil then
				arg_107_1.var_.characterEffect10058ui_story = arg_107_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10058ui_story"]) then
				if arg_107_1.var_.characterEffect10058ui_story and not isNil(arg_107_1.actors_["10058ui_story"]) then
					arg_107_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10058ui_story"]) and arg_107_1.var_.characterEffect10058ui_story then
				arg_107_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.25

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

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1109511026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 10 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 10)

				if (10 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 10)) > 0 and var_110_2 < var_110_5 then
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
	Play1109511027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1109511027
		arg_111_1.duration_ = 2.2

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1109511028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10058ui_story"]) and arg_111_1.var_.characterEffect10058ui_story == nil then
				arg_111_1.var_.characterEffect10058ui_story = arg_111_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10058ui_story"]) then
				if arg_111_1.var_.characterEffect10058ui_story and not isNil(arg_111_1.actors_["10058ui_story"]) then
					arg_111_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10058ui_story"]) and arg_111_1.var_.characterEffect10058ui_story then
				arg_111_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			local var_114_2 = 0
			local var_114_3 = 0.15

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(1109511027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 6 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 6)

				if (6 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 6)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb")

						arg_111_1:RecordAudio("1109511027", var_114_9)
						arg_111_1:RecordAudio("1109511027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511027", "story_v_side_new_1109511.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1109511028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1109511028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1109511029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) and arg_115_1.var_.characterEffect10058ui_story == nil then
				arg_115_1.var_.characterEffect10058ui_story = arg_115_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) then
				if arg_115_1.var_.characterEffect10058ui_story and not isNil(arg_115_1.actors_["10058ui_story"]) then
					arg_115_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10058ui_story"]) and arg_115_1.var_.characterEffect10058ui_story then
				arg_115_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_118_1 = arg_115_1.actors_["10058ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10058ui_story = var_118_1.localPosition
			end

			local var_118_2 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 then
				var_118_1.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_2)
				var_118_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_1.position).x, (manager.ui.mainCamera.transform.position - var_118_1.position).y, (manager.ui.mainCamera.transform.position - var_118_1.position).z)
				var_118_1.localEulerAngles.z = 0
				var_118_1.localEulerAngles.x = 0
				var_118_1.localEulerAngles = var_118_1.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 then
				var_118_1.localPosition = Vector3.New(0, 100, 0)
				var_118_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_1.position).x, (manager.ui.mainCamera.transform.position - var_118_1.position).y, (manager.ui.mainCamera.transform.position - var_118_1.position).z)
				var_118_1.localEulerAngles.z = 0
				var_118_1.localEulerAngles.x = 0
				var_118_1.localEulerAngles = var_118_1.localEulerAngles
			end

			local var_118_3 = 0
			local var_118_4 = 0.85

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_5 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1109511028).content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 34 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 34)

				if (34 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 34)) > 0 and var_118_4 < var_118_7 then
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
				actorName = "10058ui_story",
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
	Play1109511029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1109511029
		arg_119_1.duration_ = 1

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"

			SetActive(arg_119_1.choicesGo_, true)

			for iter_120_0, iter_120_1 in ipairs(arg_119_1.choices_) do
				SetActive(iter_120_1.go, iter_120_0 <= 2)
			end

			arg_119_1.choices_[1].txt.text = arg_119_1:FormatText(StoryChoiceCfg[1746].name)
			arg_119_1.choices_[2].txt.text = arg_119_1:FormatText(StoryChoiceCfg[1747].name)
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1109511030(arg_119_1)
			end

			if arg_121_0 == 2 then
				arg_119_0:Play1109511030(arg_119_1)
			end

			arg_119_1:RecordChoiceLog(1109511029, 1746, 1747)
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			return
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1109511030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1109511030
		arg_123_1.duration_ = 2.13

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1109511031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10058ui_story = arg_123_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).z)
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles = arg_123_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_123_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10058ui_story"].transform.position).z)
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10058ui_story"].transform.localEulerAngles = arg_123_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["10058ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10058ui_story == nil then
				arg_123_1.var_.characterEffect10058ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect10058ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10058ui_story then
				arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_126_4 = "10058ui_story"

			if arg_123_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_126_5 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_123_1.stage_.transform)

				var_126_5.name = var_126_4
				var_126_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_[var_126_4] = var_126_5

				local var_126_6 = var_126_5:GetComponentInChildren(typeof(CharacterEffect))

				var_126_6.enabled = true

				local var_126_7 = GameObjectTools.GetOrAddComponent(var_126_5, typeof(DynamicBoneHelper))

				if var_126_7 then
					var_126_7:EnableDynamicBone(false)
				end

				arg_123_1:ShowWeapon(var_126_6.transform, false)

				arg_123_1.var_[var_126_4 .. "Animator"] = var_126_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_123_1.var_[var_126_4 .. "Animator"].applyRootMotion = true
				arg_123_1.var_[var_126_4 .. "LipSync"] = var_126_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_126_8 = "10058ui_story"

			if arg_123_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_126_9 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_123_1.stage_.transform)

				var_126_9.name = var_126_8
				var_126_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_[var_126_8] = var_126_9

				local var_126_10 = var_126_9:GetComponentInChildren(typeof(CharacterEffect))

				var_126_10.enabled = true

				local var_126_11 = GameObjectTools.GetOrAddComponent(var_126_9, typeof(DynamicBoneHelper))

				if var_126_11 then
					var_126_11:EnableDynamicBone(false)
				end

				arg_123_1:ShowWeapon(var_126_10.transform, false)

				arg_123_1.var_[var_126_8 .. "Animator"] = var_126_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_123_1.var_[var_126_8 .. "Animator"].applyRootMotion = true
				arg_123_1.var_[var_126_8 .. "LipSync"] = var_126_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_12 = 0
			local var_126_13 = 0.2

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_14 = arg_123_1:GetWordFromCfg(1109511030)
				local var_126_15 = arg_123_1:FormatText(var_126_14.content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 8 <= 0 and var_126_13 or var_126_13 * (utf8.len(var_126_15) / 8)

				if (8 <= 0 and var_126_13 or var_126_13 * (utf8.len(var_126_15) / 8)) > 0 and var_126_13 < var_126_17 then
					arg_123_1.talkMaxDuration = var_126_17

					if var_126_17 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_12
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb") ~= 0 then
					local var_126_18 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb") / 1000

					if var_126_18 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_12
					end

					if var_126_14.prefab_name ~= "" and arg_123_1.actors_[var_126_14.prefab_name] ~= nil then
						local var_126_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_14.prefab_name].transform, "story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb")

						arg_123_1:RecordAudio("1109511030", var_126_19)
						arg_123_1:RecordAudio("1109511030", var_126_19)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511030", "story_v_side_new_1109511.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_20 = math.max(var_126_13, arg_123_1.talkMaxDuration)

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_20 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_12) / var_126_20

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_12 + var_126_20 and arg_123_1.time_ < var_126_12 + var_126_20 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play1109511031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1109511031
		arg_127_1.duration_ = 9.07

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1109511032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.95

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(1109511031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 38 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 38)

				if (38 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 38)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb")

						arg_127_1:RecordAudio("1109511031", var_130_6)
						arg_127_1:RecordAudio("1109511031", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511031", "story_v_side_new_1109511.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1109511032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1109511032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1109511033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10058ui_story"]) and arg_131_1.var_.characterEffect10058ui_story == nil then
				arg_131_1.var_.characterEffect10058ui_story = arg_131_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10058ui_story"]) then
				if arg_131_1.var_.characterEffect10058ui_story and not isNil(arg_131_1.actors_["10058ui_story"]) then
					arg_131_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10058ui_story"]) and arg_131_1.var_.characterEffect10058ui_story then
				arg_131_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 0.5

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

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1109511032).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 20 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 20)

				if (20 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 20)) > 0 and var_134_2 < var_134_5 then
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
	Play1109511033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1109511033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1109511034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.525

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1109511033).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 21 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 21)

				if (21 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 21)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1109511034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1109511034
		arg_139_1.duration_ = 3.57

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1109511035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10058ui_story"]) and arg_139_1.var_.characterEffect10058ui_story == nil then
				arg_139_1.var_.characterEffect10058ui_story = arg_139_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10058ui_story"]) then
				if arg_139_1.var_.characterEffect10058ui_story and not isNil(arg_139_1.actors_["10058ui_story"]) then
					arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10058ui_story"]) and arg_139_1.var_.characterEffect10058ui_story then
				arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_142_2 = 0
			local var_142_3 = 0.5

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:GetWordFromCfg(1109511034)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 20 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 20)

				if (20 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 20)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb")

						arg_139_1:RecordAudio("1109511034", var_142_9)
						arg_139_1:RecordAudio("1109511034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511034", "story_v_side_new_1109511.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1109511035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109511035
		arg_143_1.duration_ = 6.7

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1109511036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.7

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(1109511035)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 28 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 28)

				if (28 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 28)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb")

						arg_143_1:RecordAudio("1109511035", var_146_6)
						arg_143_1:RecordAudio("1109511035", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511035", "story_v_side_new_1109511.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1109511036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109511036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1109511037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = arg_147_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) then
				if arg_147_1.var_.characterEffect10058ui_story and not isNil(arg_147_1.actors_["10058ui_story"]) then
					arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10058ui_story"]) and arg_147_1.var_.characterEffect10058ui_story then
				arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.625

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

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1109511036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 25 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 25)

				if (25 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 25)) > 0 and var_150_2 < var_150_5 then
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
	Play1109511037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109511037
		arg_151_1.duration_ = 6.8

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109511038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10058ui_story"]) and arg_151_1.var_.characterEffect10058ui_story == nil then
				arg_151_1.var_.characterEffect10058ui_story = arg_151_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10058ui_story"]) then
				if arg_151_1.var_.characterEffect10058ui_story and not isNil(arg_151_1.actors_["10058ui_story"]) then
					arg_151_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10058ui_story"]) and arg_151_1.var_.characterEffect10058ui_story then
				arg_151_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_154_2 = 0
			local var_154_3 = 0.55

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:GetWordFromCfg(1109511037)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 22 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 22)

				if (22 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 22)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb")

						arg_151_1:RecordAudio("1109511037", var_154_9)
						arg_151_1:RecordAudio("1109511037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511037", "story_v_side_new_1109511.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1109511038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109511038
		arg_155_1.duration_ = 6.7

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1109511039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.7

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(1109511038)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 28 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 28)

				if (28 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 28)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb")

						arg_155_1:RecordAudio("1109511038", var_158_6)
						arg_155_1:RecordAudio("1109511038", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511038", "story_v_side_new_1109511.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1109511039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109511039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109511040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10058ui_story"]) and arg_159_1.var_.characterEffect10058ui_story == nil then
				arg_159_1.var_.characterEffect10058ui_story = arg_159_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10058ui_story"]) then
				if arg_159_1.var_.characterEffect10058ui_story and not isNil(arg_159_1.actors_["10058ui_story"]) then
					arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10058ui_story"]) and arg_159_1.var_.characterEffect10058ui_story then
				arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.075

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

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1109511039).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 3 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 3)

				if (3 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 3)) > 0 and var_162_2 < var_162_5 then
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
	Play1109511040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109511040
		arg_163_1.duration_ = 9.3

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1109511041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10058ui_story"]) and arg_163_1.var_.characterEffect10058ui_story == nil then
				arg_163_1.var_.characterEffect10058ui_story = arg_163_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10058ui_story"]) then
				if arg_163_1.var_.characterEffect10058ui_story and not isNil(arg_163_1.actors_["10058ui_story"]) then
					arg_163_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10058ui_story"]) and arg_163_1.var_.characterEffect10058ui_story then
				arg_163_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_166_2 = 0
			local var_166_3 = 0.725

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(1109511040)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 29 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 29)

				if (29 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 29)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb")

						arg_163_1:RecordAudio("1109511040", var_166_9)
						arg_163_1:RecordAudio("1109511040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511040", "story_v_side_new_1109511.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109511041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109511041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1109511042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10058ui_story"]) and arg_167_1.var_.characterEffect10058ui_story == nil then
				arg_167_1.var_.characterEffect10058ui_story = arg_167_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10058ui_story"]) then
				if arg_167_1.var_.characterEffect10058ui_story and not isNil(arg_167_1.actors_["10058ui_story"]) then
					arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10058ui_story"]) and arg_167_1.var_.characterEffect10058ui_story then
				arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.375

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

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1109511041).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 15 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 15)

				if (15 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 15)) > 0 and var_170_2 < var_170_5 then
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
	Play1109511042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109511042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1109511043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.55

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

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1109511042).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 22 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 22)

				if (22 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 22)) > 0 and var_174_0 < var_174_3 then
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
	Play1109511043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109511043
		arg_175_1.duration_ = 5.6

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109511044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = arg_175_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) then
				if arg_175_1.var_.characterEffect10058ui_story and not isNil(arg_175_1.actors_["10058ui_story"]) then
					arg_175_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10058ui_story"]) and arg_175_1.var_.characterEffect10058ui_story then
				arg_175_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_2 = 0
			local var_178_3 = 0.7

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
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

				local var_178_4 = arg_175_1:GetWordFromCfg(1109511043)
				local var_178_5 = arg_175_1:FormatText(var_178_4.content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 28 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 28)

				if (28 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 28)) > 0 and var_178_3 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_2
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb") / 1000

					if var_178_8 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_2
					end

					if var_178_4.prefab_name ~= "" and arg_175_1.actors_[var_178_4.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_4.prefab_name].transform, "story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb")

						arg_175_1:RecordAudio("1109511043", var_178_9)
						arg_175_1:RecordAudio("1109511043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511043", "story_v_side_new_1109511.awb")
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
	Play1109511044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109511044
		arg_179_1.duration_ = 7.6

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1109511045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.675

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(1109511044)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 27 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 27)

				if (27 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 27)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb")

						arg_179_1:RecordAudio("1109511044", var_182_6)
						arg_179_1:RecordAudio("1109511044", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511044", "story_v_side_new_1109511.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1109511045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109511045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1109511046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10058ui_story"]) and arg_183_1.var_.characterEffect10058ui_story == nil then
				arg_183_1.var_.characterEffect10058ui_story = arg_183_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10058ui_story"]) then
				if arg_183_1.var_.characterEffect10058ui_story and not isNil(arg_183_1.actors_["10058ui_story"]) then
					arg_183_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10058ui_story"]) and arg_183_1.var_.characterEffect10058ui_story then
				arg_183_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.975

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1109511045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 39 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 39)

				if (39 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 39)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1109511046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109511046
		arg_187_1.duration_ = 11.33

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109511047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10058ui_story"]) and arg_187_1.var_.characterEffect10058ui_story == nil then
				arg_187_1.var_.characterEffect10058ui_story = arg_187_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10058ui_story"]) then
				if arg_187_1.var_.characterEffect10058ui_story and not isNil(arg_187_1.actors_["10058ui_story"]) then
					arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10058ui_story"]) and arg_187_1.var_.characterEffect10058ui_story then
				arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_190_2 = 0
			local var_190_3 = 1.05

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(1109511046)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 42 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 42)

				if (42 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 42)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb")

						arg_187_1:RecordAudio("1109511046", var_190_9)
						arg_187_1:RecordAudio("1109511046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511046", "story_v_side_new_1109511.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_10 and arg_187_1.time_ < var_190_2 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109511047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1109511047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1109511048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10058ui_story"]) and arg_191_1.var_.characterEffect10058ui_story == nil then
				arg_191_1.var_.characterEffect10058ui_story = arg_191_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10058ui_story"]) then
				if arg_191_1.var_.characterEffect10058ui_story and not isNil(arg_191_1.actors_["10058ui_story"]) then
					arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10058ui_story"]) and arg_191_1.var_.characterEffect10058ui_story then
				arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.2

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

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1109511047).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 8 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 8)

				if (8 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 8)) > 0 and var_194_2 < var_194_5 then
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
	Play1109511048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1109511048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1109511049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10058ui_story = arg_195_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).z)
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles = arg_195_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).z)
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles = arg_195_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if 0.3 < arg_195_1.time_ and arg_195_1.time_ <= 0.3 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clap01", "")
			end

			local var_198_2 = 0
			local var_198_3 = 0.85

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1109511048).content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_6 = 34 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_4) / 34)

				if (34 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_4) / 34)) > 0 and var_198_3 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_3, arg_195_1.talkMaxDuration)

			if var_198_2 <= arg_195_1.time_ and arg_195_1.time_ < var_198_2 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_2) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_2 + var_198_7 and arg_195_1.time_ < var_198_2 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play1109511049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1109511049
		arg_199_1.duration_ = 3.43

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1109511050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10058ui_story = arg_199_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10058ui_story"].transform.position).z)
				arg_199_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10058ui_story"].transform.localEulerAngles = arg_199_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_199_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10058ui_story"].transform.position).z)
				arg_199_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10058ui_story"].transform.localEulerAngles = arg_199_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["10058ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10058ui_story == nil then
				arg_199_1.var_.characterEffect10058ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect10058ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10058ui_story then
				arg_199_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_202_4 = 0
			local var_202_5 = 0.325

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
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

				local var_202_6 = arg_199_1:GetWordFromCfg(1109511049)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 13 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 13)

				if (13 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 13)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb")

						arg_199_1:RecordAudio("1109511049", var_202_11)
						arg_199_1:RecordAudio("1109511049", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511049", "story_v_side_new_1109511.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play1109511050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1109511050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1109511051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10058ui_story"]) and arg_203_1.var_.characterEffect10058ui_story == nil then
				arg_203_1.var_.characterEffect10058ui_story = arg_203_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10058ui_story"]) then
				if arg_203_1.var_.characterEffect10058ui_story and not isNil(arg_203_1.actors_["10058ui_story"]) then
					arg_203_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10058ui_story"]) and arg_203_1.var_.characterEffect10058ui_story then
				arg_203_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.65

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
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

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(1109511050).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 26 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 26)

				if (26 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 26)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1109511051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1109511051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1109511052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.65

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1109511051).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 26 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 26)

				if (26 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 26)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1109511052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1109511052
		arg_211_1.duration_ = 6.48

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1109511053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if arg_211_1.bgs_.X203K == nil then
				local var_214_0 = Object.Instantiate(arg_211_1.paintGo_)

				var_214_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X203K")
				var_214_0.name = "X203K"
				var_214_0.transform.parent = arg_211_1.stage_.transform
				var_214_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.bgs_.X203K = var_214_0
			end

			if 1.71666666666667 < arg_211_1.time_ and arg_211_1.time_ <= 1.71666666666667 + arg_214_0 then
				local var_214_1 = arg_211_1.bgs_.X203K

				arg_211_1.bgs_.X203K.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_214_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_214_2 = var_214_1:GetComponent("SpriteRenderer")

				if var_214_2 and var_214_2.sprite then
					local var_214_3 = 2 * (var_214_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_214_1.transform.localScale = Vector3.New(var_214_3 / var_214_2.sprite.bounds.size.y < var_214_3 * manager.ui.mainCameraCom_.aspect / var_214_2.sprite.bounds.size.x and var_214_3 * manager.ui.mainCameraCom_.aspect / var_214_2.sprite.bounds.size.x or var_214_3 / var_214_2.sprite.bounds.size.y, var_214_3 / var_214_2.sprite.bounds.size.y < var_214_3 * manager.ui.mainCameraCom_.aspect / var_214_2.sprite.bounds.size.x and var_214_3 * manager.ui.mainCameraCom_.aspect / var_214_2.sprite.bounds.size.x or var_214_3 / var_214_2.sprite.bounds.size.y, 0)
				end

				for iter_214_0, iter_214_1 in pairs(arg_211_1.bgs_) do
					if iter_214_0 ~= "X203K" then
						iter_214_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_214_4 = 1.71666666666667

			if 1.71666666666667 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_4 + 0.3 and arg_211_1.time_ < var_214_4 + 0.3 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			local var_214_5 = 0

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.mask_.enabled = true
				arg_211_1.mask_.raycastTarget = true

				arg_211_1:SetGaussion(false)
			end

			local var_214_6 = 1.71666666666667

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_6 then
				local var_214_7 = Color.New(0, 0, 0)

				var_214_7.a = Mathf.Lerp(0, 1, (arg_211_1.time_ - var_214_5) / var_214_6)
				arg_211_1.mask_.color = var_214_7
			end

			if arg_211_1.time_ >= var_214_5 + var_214_6 and arg_211_1.time_ < var_214_5 + var_214_6 + arg_214_0 then
				local var_214_8 = Color.New(0, 0, 0)

				var_214_8.a = 1
				arg_211_1.mask_.color = var_214_8
			end

			local var_214_9 = 1.71666666666667

			if 1.71666666666667 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.mask_.enabled = true
				arg_211_1.mask_.raycastTarget = true

				arg_211_1:SetGaussion(false)
			end

			local var_214_10 = 2

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_10 then
				local var_214_11 = Color.New(0, 0, 0)

				var_214_11.a = Mathf.Lerp(1, 0, (arg_211_1.time_ - var_214_9) / var_214_10)
				arg_211_1.mask_.color = var_214_11
			end

			if arg_211_1.time_ >= var_214_9 + var_214_10 and arg_211_1.time_ < var_214_9 + var_214_10 + arg_214_0 then
				local var_214_12 = Color.New(0, 0, 0)

				arg_211_1.mask_.enabled = false
				var_214_12.a = 0
				arg_211_1.mask_.color = var_214_12
			end

			local var_214_13 = arg_211_1.actors_["10058ui_story"].transform

			if 1.71666666666667 < arg_211_1.time_ and arg_211_1.time_ <= 1.71666666666667 + arg_214_0 then
				arg_211_1.var_.moveOldPos10058ui_story = var_214_13.localPosition
			end

			local var_214_14 = 0.001

			if 1.71666666666667 <= arg_211_1.time_ and arg_211_1.time_ < 1.71666666666667 + var_214_14 then
				var_214_13.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 1.71666666666667) / var_214_14)
				var_214_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_13.position).x, (manager.ui.mainCamera.transform.position - var_214_13.position).y, (manager.ui.mainCamera.transform.position - var_214_13.position).z)
				var_214_13.localEulerAngles.z = 0
				var_214_13.localEulerAngles.x = 0
				var_214_13.localEulerAngles = var_214_13.localEulerAngles
			end

			if arg_211_1.time_ >= 1.71666666666667 + var_214_14 and arg_211_1.time_ < 1.71666666666667 + var_214_14 + arg_214_0 then
				var_214_13.localPosition = Vector3.New(0, 100, 0)
				var_214_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_13.position).x, (manager.ui.mainCamera.transform.position - var_214_13.position).y, (manager.ui.mainCamera.transform.position - var_214_13.position).z)
				var_214_13.localEulerAngles.z = 0
				var_214_13.localEulerAngles.x = 0
				var_214_13.localEulerAngles = var_214_13.localEulerAngles
			end

			local var_214_15 = arg_211_1.actors_["10058ui_story"].transform

			if 3.28333333333333 < arg_211_1.time_ and arg_211_1.time_ <= 3.28333333333333 + arg_214_0 then
				arg_211_1.var_.moveOldPos10058ui_story = var_214_15.localPosition
			end

			local var_214_16 = 0.001

			if 3.28333333333333 <= arg_211_1.time_ and arg_211_1.time_ < 3.28333333333333 + var_214_16 then
				var_214_15.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_211_1.time_ - 3.28333333333333) / var_214_16)
				var_214_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_15.position).x, (manager.ui.mainCamera.transform.position - var_214_15.position).y, (manager.ui.mainCamera.transform.position - var_214_15.position).z)
				var_214_15.localEulerAngles.z = 0
				var_214_15.localEulerAngles.x = 0
				var_214_15.localEulerAngles = var_214_15.localEulerAngles
			end

			if arg_211_1.time_ >= 3.28333333333333 + var_214_16 and arg_211_1.time_ < 3.28333333333333 + var_214_16 + arg_214_0 then
				var_214_15.localPosition = Vector3.New(0, -0.98, -6.1)
				var_214_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_15.position).x, (manager.ui.mainCamera.transform.position - var_214_15.position).y, (manager.ui.mainCamera.transform.position - var_214_15.position).z)
				var_214_15.localEulerAngles.z = 0
				var_214_15.localEulerAngles.x = 0
				var_214_15.localEulerAngles = var_214_15.localEulerAngles
			end

			local var_214_17 = arg_211_1.actors_["10058ui_story"]

			if 3.28333333333333 < arg_211_1.time_ and arg_211_1.time_ <= 3.28333333333333 + arg_214_0 and not isNil(var_214_17) and arg_211_1.var_.characterEffect10058ui_story == nil then
				arg_211_1.var_.characterEffect10058ui_story = var_214_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_18 = 0.200000002980232

			if 3.28333333333333 <= arg_211_1.time_ and arg_211_1.time_ < 3.28333333333333 + var_214_18 and not isNil(var_214_17) then
				if arg_211_1.var_.characterEffect10058ui_story and not isNil(var_214_17) then
					arg_211_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 3.28333333333333 + var_214_18 and arg_211_1.time_ < 3.28333333333333 + var_214_18 + arg_214_0 and not isNil(var_214_17) and arg_211_1.var_.characterEffect10058ui_story then
				arg_211_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 3.28333333333333 < arg_211_1.time_ and arg_211_1.time_ <= 3.28333333333333 + arg_214_0 then
				arg_211_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			if 3.28333333333333 < arg_211_1.time_ and arg_211_1.time_ <= 3.28333333333333 + arg_214_0 then
				arg_211_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_20 = 3.55
			local var_214_21 = 0.35

			if 3.55 < arg_211_1.time_ and arg_211_1.time_ <= var_214_20 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_22 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_22:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_23 = arg_211_1:GetWordFromCfg(1109511052)
				local var_214_24 = arg_211_1:FormatText(var_214_23.content)

				arg_211_1.text_.text = var_214_24

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_26 = 14 <= 0 and var_214_21 or var_214_21 * (utf8.len(var_214_24) / 14)

				if (14 <= 0 and var_214_21 or var_214_21 * (utf8.len(var_214_24) / 14)) > 0 and var_214_21 < var_214_26 then
					arg_211_1.talkMaxDuration = var_214_26
					var_214_20 = var_214_20 + 0.3

					if var_214_26 + var_214_20 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_26 + var_214_20
					end
				end

				arg_211_1.text_.text = var_214_24
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb") ~= 0 then
					local var_214_27 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb") / 1000

					if var_214_27 + var_214_20 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_27 + var_214_20
					end

					if var_214_23.prefab_name ~= "" and arg_211_1.actors_[var_214_23.prefab_name] ~= nil then
						local var_214_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_23.prefab_name].transform, "story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb")

						arg_211_1:RecordAudio("1109511052", var_214_28)
						arg_211_1:RecordAudio("1109511052", var_214_28)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511052", "story_v_side_new_1109511.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_29 = var_214_20 + 0.3
			local var_214_30 = math.max(var_214_21, arg_211_1.talkMaxDuration)

			if var_214_20 + 0.3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_29 + var_214_30 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_29) / var_214_30

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_29 + var_214_30 and arg_211_1.time_ < var_214_29 + var_214_30 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.71666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.28333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1109511053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109511053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109511054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10058ui_story"]) and arg_217_1.var_.characterEffect10058ui_story == nil then
				arg_217_1.var_.characterEffect10058ui_story = arg_217_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10058ui_story"]) then
				if arg_217_1.var_.characterEffect10058ui_story and not isNil(arg_217_1.actors_["10058ui_story"]) then
					arg_217_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10058ui_story"]) and arg_217_1.var_.characterEffect10058ui_story then
				arg_217_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.725

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

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1109511053).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 29 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 29)

				if (29 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 29)) > 0 and var_220_2 < var_220_5 then
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
	Play1109511054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109511054
		arg_221_1.duration_ = 2.8

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109511055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10058ui_story"]) and arg_221_1.var_.characterEffect10058ui_story == nil then
				arg_221_1.var_.characterEffect10058ui_story = arg_221_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10058ui_story"]) then
				if arg_221_1.var_.characterEffect10058ui_story and not isNil(arg_221_1.actors_["10058ui_story"]) then
					arg_221_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10058ui_story"]) and arg_221_1.var_.characterEffect10058ui_story then
				arg_221_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_224_2 = 0
			local var_224_3 = 0.325

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(1109511054)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 13 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 13)

				if (13 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 13)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb")

						arg_221_1:RecordAudio("1109511054", var_224_9)
						arg_221_1:RecordAudio("1109511054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511054", "story_v_side_new_1109511.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109511055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109511055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109511056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10058ui_story"]) and arg_225_1.var_.characterEffect10058ui_story == nil then
				arg_225_1.var_.characterEffect10058ui_story = arg_225_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10058ui_story"]) then
				if arg_225_1.var_.characterEffect10058ui_story and not isNil(arg_225_1.actors_["10058ui_story"]) then
					arg_225_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10058ui_story"]) and arg_225_1.var_.characterEffect10058ui_story then
				arg_225_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.425

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
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

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1109511055).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 17 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 17)

				if (17 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 17)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109511056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109511056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109511057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10058ui_story = arg_229_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10058ui_story"].transform.position).z)
				arg_229_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10058ui_story"].transform.localEulerAngles = arg_229_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10058ui_story"].transform.position).z)
				arg_229_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10058ui_story"].transform.localEulerAngles = arg_229_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_232_1 = 0
			local var_232_2 = 0.95

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1109511056).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 38 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 38)

				if (38 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 38)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play1109511057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109511057
		arg_233_1.duration_ = 3.6

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1109511058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10058ui_story"]) and arg_233_1.var_.characterEffect10058ui_story == nil then
				arg_233_1.var_.characterEffect10058ui_story = arg_233_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10058ui_story"]) then
				if arg_233_1.var_.characterEffect10058ui_story and not isNil(arg_233_1.actors_["10058ui_story"]) then
					arg_233_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10058ui_story"]) and arg_233_1.var_.characterEffect10058ui_story then
				arg_233_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_236_2 = arg_233_1.actors_["10058ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10058ui_story = var_236_2.localPosition
			end

			local var_236_3 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 then
				var_236_2.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_233_1.time_ - 0) / var_236_3)
				var_236_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_2.position).x, (manager.ui.mainCamera.transform.position - var_236_2.position).y, (manager.ui.mainCamera.transform.position - var_236_2.position).z)
				var_236_2.localEulerAngles.z = 0
				var_236_2.localEulerAngles.x = 0
				var_236_2.localEulerAngles = var_236_2.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 then
				var_236_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_236_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_2.position).x, (manager.ui.mainCamera.transform.position - var_236_2.position).y, (manager.ui.mainCamera.transform.position - var_236_2.position).z)
				var_236_2.localEulerAngles.z = 0
				var_236_2.localEulerAngles.x = 0
				var_236_2.localEulerAngles = var_236_2.localEulerAngles
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_236_4 = 0
			local var_236_5 = 0.325

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(1109511057)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 13 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 13)

				if (13 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 13)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb")

						arg_233_1:RecordAudio("1109511057", var_236_11)
						arg_233_1:RecordAudio("1109511057", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511057", "story_v_side_new_1109511.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play1109511058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109511058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109511059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10058ui_story"]) and arg_237_1.var_.characterEffect10058ui_story == nil then
				arg_237_1.var_.characterEffect10058ui_story = arg_237_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10058ui_story"]) then
				if arg_237_1.var_.characterEffect10058ui_story and not isNil(arg_237_1.actors_["10058ui_story"]) then
					arg_237_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10058ui_story"]) and arg_237_1.var_.characterEffect10058ui_story then
				arg_237_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.075

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1109511058).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 3 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 3)

				if (3 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 3)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1109511059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1109511059
		arg_241_1.duration_ = 2.9

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1109511060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10058ui_story"]) and arg_241_1.var_.characterEffect10058ui_story == nil then
				arg_241_1.var_.characterEffect10058ui_story = arg_241_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10058ui_story"]) then
				if arg_241_1.var_.characterEffect10058ui_story and not isNil(arg_241_1.actors_["10058ui_story"]) then
					arg_241_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10058ui_story"]) and arg_241_1.var_.characterEffect10058ui_story then
				arg_241_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_244_2 = 0
			local var_244_3 = 0.3

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(1109511059)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 12 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 12)

				if (12 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 12)) > 0 and var_244_3 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb") / 1000

					if var_244_8 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_2
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb")

						arg_241_1:RecordAudio("1109511059", var_244_9)
						arg_241_1:RecordAudio("1109511059", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511059", "story_v_side_new_1109511.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_3, arg_241_1.talkMaxDuration)

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_2) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_2 + var_244_10 and arg_241_1.time_ < var_244_2 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1109511060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1109511060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1109511061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10058ui_story"]) and arg_245_1.var_.characterEffect10058ui_story == nil then
				arg_245_1.var_.characterEffect10058ui_story = arg_245_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10058ui_story"]) then
				if arg_245_1.var_.characterEffect10058ui_story and not isNil(arg_245_1.actors_["10058ui_story"]) then
					arg_245_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10058ui_story"]) and arg_245_1.var_.characterEffect10058ui_story then
				arg_245_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.675

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(1109511060).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 27 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 27)

				if (27 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 27)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1109511061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1109511061
		arg_249_1.duration_ = 4.6

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1109511062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["10058ui_story"]) and arg_249_1.var_.characterEffect10058ui_story == nil then
				arg_249_1.var_.characterEffect10058ui_story = arg_249_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["10058ui_story"]) then
				if arg_249_1.var_.characterEffect10058ui_story and not isNil(arg_249_1.actors_["10058ui_story"]) then
					arg_249_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["10058ui_story"]) and arg_249_1.var_.characterEffect10058ui_story then
				arg_249_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_252_2 = 0
			local var_252_3 = 0.45

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(1109511061)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 18 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 18)

				if (18 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 18)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb")

						arg_249_1:RecordAudio("1109511061", var_252_9)
						arg_249_1:RecordAudio("1109511061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511061", "story_v_side_new_1109511.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1109511062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1109511062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1109511063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10058ui_story"]) and arg_253_1.var_.characterEffect10058ui_story == nil then
				arg_253_1.var_.characterEffect10058ui_story = arg_253_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10058ui_story"]) then
				if arg_253_1.var_.characterEffect10058ui_story and not isNil(arg_253_1.actors_["10058ui_story"]) then
					arg_253_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10058ui_story"]) and arg_253_1.var_.characterEffect10058ui_story then
				arg_253_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.25

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
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

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1109511062).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 10 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 10)

				if (10 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 10)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1109511063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109511063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1109511064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.85

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1109511063).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 34 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 34)

				if (34 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 34)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1109511064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1109511064
		arg_261_1.duration_ = 3.17

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1109511065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["10058ui_story"]) and arg_261_1.var_.characterEffect10058ui_story == nil then
				arg_261_1.var_.characterEffect10058ui_story = arg_261_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["10058ui_story"]) then
				if arg_261_1.var_.characterEffect10058ui_story and not isNil(arg_261_1.actors_["10058ui_story"]) then
					arg_261_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["10058ui_story"]) and arg_261_1.var_.characterEffect10058ui_story then
				arg_261_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_264_3 = 0
			local var_264_4 = 0.325

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_3 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_5 = arg_261_1:GetWordFromCfg(1109511064)
				local var_264_6 = arg_261_1:FormatText(var_264_5.content)

				arg_261_1.text_.text = var_264_6

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_8 = 13 <= 0 and var_264_4 or var_264_4 * (utf8.len(var_264_6) / 13)

				if (13 <= 0 and var_264_4 or var_264_4 * (utf8.len(var_264_6) / 13)) > 0 and var_264_4 < var_264_8 then
					arg_261_1.talkMaxDuration = var_264_8

					if var_264_8 + var_264_3 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_3
					end
				end

				arg_261_1.text_.text = var_264_6
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb") ~= 0 then
					local var_264_9 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb") / 1000

					if var_264_9 + var_264_3 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_3
					end

					if var_264_5.prefab_name ~= "" and arg_261_1.actors_[var_264_5.prefab_name] ~= nil then
						local var_264_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_5.prefab_name].transform, "story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb")

						arg_261_1:RecordAudio("1109511064", var_264_10)
						arg_261_1:RecordAudio("1109511064", var_264_10)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511064", "story_v_side_new_1109511.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_11 = math.max(var_264_4, arg_261_1.talkMaxDuration)

			if var_264_3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_3 + var_264_11 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_3) / var_264_11

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_3 + var_264_11 and arg_261_1.time_ < var_264_3 + var_264_11 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1109511065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1109511065
		arg_265_1.duration_ = 8.05

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1109511066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if arg_265_1.bgs_.X203g == nil then
				local var_268_0 = Object.Instantiate(arg_265_1.paintGo_)

				var_268_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X203g")
				var_268_0.name = "X203g"
				var_268_0.transform.parent = arg_265_1.stage_.transform
				var_268_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.bgs_.X203g = var_268_0
			end

			if 1.46666666666667 < arg_265_1.time_ and arg_265_1.time_ <= 1.46666666666667 + arg_268_0 then
				local var_268_1 = arg_265_1.bgs_.X203g

				arg_265_1.bgs_.X203g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_2 = var_268_1:GetComponent("SpriteRenderer")

				if var_268_2 and var_268_2.sprite then
					local var_268_3 = 2 * (var_268_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_1.transform.localScale = Vector3.New(var_268_3 / var_268_2.sprite.bounds.size.y < var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x and var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x or var_268_3 / var_268_2.sprite.bounds.size.y, var_268_3 / var_268_2.sprite.bounds.size.y < var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x and var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x or var_268_3 / var_268_2.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "X203g" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_4 = 1.46666666666667

			if 1.46666666666667 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_4 + 0.3 and arg_265_1.time_ < var_268_4 + 0.3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_5 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_6 = 1.46666666666667

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 then
				local var_268_7 = Color.New(0, 0, 0)

				var_268_7.a = Mathf.Lerp(0, 1, (arg_265_1.time_ - var_268_5) / var_268_6)
				arg_265_1.mask_.color = var_268_7
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 then
				local var_268_8 = Color.New(0, 0, 0)

				var_268_8.a = 1
				arg_265_1.mask_.color = var_268_8
			end

			local var_268_9 = 1.46666666666667

			if 1.46666666666667 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_10 = 2

			if var_268_9 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_10 then
				local var_268_11 = Color.New(0, 0, 0)

				var_268_11.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_9) / var_268_10)
				arg_265_1.mask_.color = var_268_11
			end

			if arg_265_1.time_ >= var_268_9 + var_268_10 and arg_265_1.time_ < var_268_9 + var_268_10 + arg_268_0 then
				local var_268_12 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_12.a = 0
				arg_265_1.mask_.color = var_268_12
			end

			local var_268_13 = arg_265_1.actors_["10058ui_story"].transform

			if 1.46666666666667 < arg_265_1.time_ and arg_265_1.time_ <= 1.46666666666667 + arg_268_0 then
				arg_265_1.var_.moveOldPos10058ui_story = var_268_13.localPosition
			end

			local var_268_14 = 0.001

			if 1.46666666666667 <= arg_265_1.time_ and arg_265_1.time_ < 1.46666666666667 + var_268_14 then
				var_268_13.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 1.46666666666667) / var_268_14)
				var_268_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_13.position).x, (manager.ui.mainCamera.transform.position - var_268_13.position).y, (manager.ui.mainCamera.transform.position - var_268_13.position).z)
				var_268_13.localEulerAngles.z = 0
				var_268_13.localEulerAngles.x = 0
				var_268_13.localEulerAngles = var_268_13.localEulerAngles
			end

			if arg_265_1.time_ >= 1.46666666666667 + var_268_14 and arg_265_1.time_ < 1.46666666666667 + var_268_14 + arg_268_0 then
				var_268_13.localPosition = Vector3.New(0, 100, 0)
				var_268_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_13.position).x, (manager.ui.mainCamera.transform.position - var_268_13.position).y, (manager.ui.mainCamera.transform.position - var_268_13.position).z)
				var_268_13.localEulerAngles.z = 0
				var_268_13.localEulerAngles.x = 0
				var_268_13.localEulerAngles = var_268_13.localEulerAngles
			end

			local var_268_15 = arg_265_1.actors_["10058ui_story"]

			if 1.46666666666667 < arg_265_1.time_ and arg_265_1.time_ <= 1.46666666666667 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.characterEffect10058ui_story == nil then
				arg_265_1.var_.characterEffect10058ui_story = var_268_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_16 = 0.200000002980232

			if 1.46666666666667 <= arg_265_1.time_ and arg_265_1.time_ < 1.46666666666667 + var_268_16 and not isNil(var_268_15) then
				if arg_265_1.var_.characterEffect10058ui_story and not isNil(var_268_15) then
					arg_265_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 1.46666666666667) / var_268_16)
				end
			end

			if arg_265_1.time_ >= 1.46666666666667 + var_268_16 and arg_265_1.time_ < 1.46666666666667 + var_268_16 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.characterEffect10058ui_story then
				arg_265_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 1 < arg_265_1.time_ and arg_265_1.time_ <= 1 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0.2 < arg_265_1.time_ and arg_265_1.time_ <= 0.2 + arg_268_0 then
				arg_265_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.4 < arg_265_1.time_ and arg_265_1.time_ <= 1.4 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_139", "se_story_139_bed", "")
			end

			if 1 < arg_265_1.time_ and arg_265_1.time_ <= 1 + arg_268_0 then
				arg_265_1:AudioAction("play", "music", "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day.awb")

				local var_268_22 = manager.audio:GetAudioName("bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day")

				if "" ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_22 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_22

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_22
						arg_265_1.bgmTxt2_.text = var_268_22
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_23 = 3.05
			local var_268_24 = 0.9

			if 3.05 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_25 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_25:setOnUpdate(LuaHelper.FloatAction(function(arg_270_0)
					arg_265_1.dialogCg_.alpha = arg_270_0
				end))
				var_268_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1109511065).content)

				arg_265_1.text_.text = var_268_26

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_28 = 36 <= 0 and var_268_24 or var_268_24 * (utf8.len(var_268_26) / 36)

				if (36 <= 0 and var_268_24 or var_268_24 * (utf8.len(var_268_26) / 36)) > 0 and var_268_24 < var_268_28 then
					arg_265_1.talkMaxDuration = var_268_28
					var_268_23 = var_268_23 + 0.3

					if var_268_28 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_28 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_26
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_29 = var_268_23 + 0.3
			local var_268_30 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_29 + var_268_30 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_29) / var_268_30

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_29 + var_268_30 and arg_265_1.time_ < var_268_29 + var_268_30 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play1109511066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1109511066
		arg_272_1.duration_ = 4.63

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1109511067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos10058ui_story = arg_272_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["10058ui_story"].transform.position).z)
				arg_272_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["10058ui_story"].transform.localEulerAngles = arg_272_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_272_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["10058ui_story"].transform.position).z)
				arg_272_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["10058ui_story"].transform.localEulerAngles = arg_272_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_275_1 = arg_272_1.actors_["10058ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect10058ui_story == nil then
				arg_272_1.var_.characterEffect10058ui_story = var_275_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_2 and not isNil(var_275_1) then
				if arg_272_1.var_.characterEffect10058ui_story and not isNil(var_275_1) then
					arg_272_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_2 and arg_272_1.time_ < 0 + var_275_2 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect10058ui_story then
				arg_272_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_275_4 = 0
			local var_275_5 = 0.375

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_6 = arg_272_1:GetWordFromCfg(1109511066)
				local var_275_7 = arg_272_1:FormatText(var_275_6.content)

				arg_272_1.text_.text = var_275_7

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_9 = 15 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 15)

				if (15 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 15)) > 0 and var_275_5 < var_275_9 then
					arg_272_1.talkMaxDuration = var_275_9

					if var_275_9 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_7
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb") ~= 0 then
					local var_275_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb") / 1000

					if var_275_10 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_4
					end

					if var_275_6.prefab_name ~= "" and arg_272_1.actors_[var_275_6.prefab_name] ~= nil then
						local var_275_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_6.prefab_name].transform, "story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb")

						arg_272_1:RecordAudio("1109511066", var_275_11)
						arg_272_1:RecordAudio("1109511066", var_275_11)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511066", "story_v_side_new_1109511.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_12 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_12 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_12

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_12 and arg_272_1.time_ < var_275_4 + var_275_12 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
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

		arg_272_1:InitPlayNodeList()
	end,
	Play1109511067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1109511067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1109511068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["10058ui_story"]) and arg_276_1.var_.characterEffect10058ui_story == nil then
				arg_276_1.var_.characterEffect10058ui_story = arg_276_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["10058ui_story"]) then
				if arg_276_1.var_.characterEffect10058ui_story and not isNil(arg_276_1.actors_["10058ui_story"]) then
					arg_276_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_276_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_0)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["10058ui_story"]) and arg_276_1.var_.characterEffect10058ui_story then
				arg_276_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_276_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_279_1 = 0
			local var_279_2 = 0.2

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(1109511067).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 8 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 8)

				if (8 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 8)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1109511068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1109511068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1109511069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.65

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_1 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(1109511068).content)

				arg_280_1.text_.text = var_283_1

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_3 = 26 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 26)

				if (26 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 26)) > 0 and var_283_0 < var_283_3 then
					arg_280_1.talkMaxDuration = var_283_3

					if var_283_3 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_3 + 0
					end
				end

				arg_280_1.text_.text = var_283_1
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_4 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_4

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1109511069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1109511069
		arg_284_1.duration_ = 6.33

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1109511070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["10058ui_story"]) and arg_284_1.var_.characterEffect10058ui_story == nil then
				arg_284_1.var_.characterEffect10058ui_story = arg_284_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["10058ui_story"]) then
				if arg_284_1.var_.characterEffect10058ui_story and not isNil(arg_284_1.actors_["10058ui_story"]) then
					arg_284_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["10058ui_story"]) and arg_284_1.var_.characterEffect10058ui_story then
				arg_284_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_287_2 = 0
			local var_287_3 = 0.775

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_4 = arg_284_1:GetWordFromCfg(1109511069)
				local var_287_5 = arg_284_1:FormatText(var_287_4.content)

				arg_284_1.text_.text = var_287_5

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 31 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_5) / 31)

				if (31 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_5) / 31)) > 0 and var_287_3 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_2
					end
				end

				arg_284_1.text_.text = var_287_5
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb") / 1000

					if var_287_8 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_2
					end

					if var_287_4.prefab_name ~= "" and arg_284_1.actors_[var_287_4.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_4.prefab_name].transform, "story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb")

						arg_284_1:RecordAudio("1109511069", var_287_9)
						arg_284_1:RecordAudio("1109511069", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511069", "story_v_side_new_1109511.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_3, arg_284_1.talkMaxDuration)

			if var_287_2 <= arg_284_1.time_ and arg_284_1.time_ < var_287_2 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_2) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_2 + var_287_10 and arg_284_1.time_ < var_287_2 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1109511070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1109511070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1109511071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["10058ui_story"]) and arg_288_1.var_.characterEffect10058ui_story == nil then
				arg_288_1.var_.characterEffect10058ui_story = arg_288_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["10058ui_story"]) then
				if arg_288_1.var_.characterEffect10058ui_story and not isNil(arg_288_1.actors_["10058ui_story"]) then
					arg_288_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_288_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_0)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["10058ui_story"]) and arg_288_1.var_.characterEffect10058ui_story then
				arg_288_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_288_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_291_1 = 0
			local var_291_2 = 0.625

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_3 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(1109511070).content)

				arg_288_1.text_.text = var_291_3

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 25 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 25)

				if (25 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 25)) > 0 and var_291_2 < var_291_5 then
					arg_288_1.talkMaxDuration = var_291_5

					if var_291_5 + var_291_1 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + var_291_1
					end
				end

				arg_288_1.text_.text = var_291_3
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_6 = math.max(var_291_2, arg_288_1.talkMaxDuration)

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_6 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_1) / var_291_6

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_1 + var_291_6 and arg_288_1.time_ < var_291_1 + var_291_6 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1109511071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1109511071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1109511072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 1.075

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(1109511071).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 43 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 43)

				if (43 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 43)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1109511072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1109511072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1109511074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:AudioAction("play", "effect", "se_story_152", "se_story_152_snack", "")
			end

			local var_299_1 = 0
			local var_299_2 = 0.85

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(1109511072).content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 34 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 34)

				if (34 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 34)) > 0 and var_299_2 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_6 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_6 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_6

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_6 and arg_296_1.time_ < var_299_1 + var_299_6 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play1109511074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1109511074
		arg_300_1.duration_ = 6.67

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1109511075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_303_0 = arg_300_1.actors_["10058ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10058ui_story = var_303_0.localPosition
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_300_1.time_ - 0) / var_303_1)
				var_303_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_0.position).x, (manager.ui.mainCamera.transform.position - var_303_0.position).y, (manager.ui.mainCamera.transform.position - var_303_0.position).z)
				var_303_0.localEulerAngles.z = 0
				var_303_0.localEulerAngles.x = 0
				var_303_0.localEulerAngles = var_303_0.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, -0.98, -6.1)
				var_303_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_0.position).x, (manager.ui.mainCamera.transform.position - var_303_0.position).y, (manager.ui.mainCamera.transform.position - var_303_0.position).z)
				var_303_0.localEulerAngles.z = 0
				var_303_0.localEulerAngles.x = 0
				var_303_0.localEulerAngles = var_303_0.localEulerAngles
			end

			local var_303_2 = arg_300_1.actors_["10058ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.characterEffect10058ui_story == nil then
				arg_300_1.var_.characterEffect10058ui_story = var_303_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_3 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_3 and not isNil(var_303_2) then
				if arg_300_1.var_.characterEffect10058ui_story and not isNil(var_303_2) then
					arg_300_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_3 and arg_300_1.time_ < 0 + var_303_3 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.characterEffect10058ui_story then
				arg_300_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_303_5 = 0
			local var_303_6 = 0.825

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_7 = arg_300_1:GetWordFromCfg(1109511074)
				local var_303_8 = arg_300_1:FormatText(var_303_7.content)

				arg_300_1.text_.text = var_303_8

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_10 = 33 <= 0 and var_303_6 or var_303_6 * (utf8.len(var_303_8) / 33)

				if (33 <= 0 and var_303_6 or var_303_6 * (utf8.len(var_303_8) / 33)) > 0 and var_303_6 < var_303_10 then
					arg_300_1.talkMaxDuration = var_303_10

					if var_303_10 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_5
					end
				end

				arg_300_1.text_.text = var_303_8
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb") ~= 0 then
					local var_303_11 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb") / 1000

					if var_303_11 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_5
					end

					if var_303_7.prefab_name ~= "" and arg_300_1.actors_[var_303_7.prefab_name] ~= nil then
						local var_303_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_7.prefab_name].transform, "story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb")

						arg_300_1:RecordAudio("1109511074", var_303_12)
						arg_300_1:RecordAudio("1109511074", var_303_12)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511074", "story_v_side_new_1109511.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_13 = math.max(var_303_6, arg_300_1.talkMaxDuration)

			if var_303_5 <= arg_300_1.time_ and arg_300_1.time_ < var_303_5 + var_303_13 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_5) / var_303_13

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_5 + var_303_13 and arg_300_1.time_ < var_303_5 + var_303_13 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play1109511075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1109511075
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1109511076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 1.075

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(1109511075).content)

				arg_304_1.text_.text = var_307_1

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_3 = 43 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 43)

				if (43 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 43)) > 0 and var_307_0 < var_307_3 then
					arg_304_1.talkMaxDuration = var_307_3

					if var_307_3 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_3 + 0
					end
				end

				arg_304_1.text_.text = var_307_1
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_4 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_4

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1109511076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1109511076
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1109511077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 1.1

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_1 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1109511076).content)

				arg_308_1.text_.text = var_311_1

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_3 = 44 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 44)

				if (44 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 44)) > 0 and var_311_0 < var_311_3 then
					arg_308_1.talkMaxDuration = var_311_3

					if var_311_3 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_3 + 0
					end
				end

				arg_308_1.text_.text = var_311_1
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_4 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_4

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1109511077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1109511077
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1109511078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.45

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_1 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(1109511077).content)

				arg_312_1.text_.text = var_315_1

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_3 = 18 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 18)

				if (18 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 18)) > 0 and var_315_0 < var_315_3 then
					arg_312_1.talkMaxDuration = var_315_3

					if var_315_3 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_3 + 0
					end
				end

				arg_312_1.text_.text = var_315_1
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_4 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_4

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1109511078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1109511078
		arg_316_1.duration_ = 6.43

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1109511079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10058ui_story = arg_316_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_319_0 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 then
				arg_316_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_316_1.time_ - 0) / var_319_0)
				arg_316_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["10058ui_story"].transform.position).z)
				arg_316_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["10058ui_story"].transform.localEulerAngles = arg_316_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 then
				arg_316_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_316_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["10058ui_story"].transform.position).z)
				arg_316_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["10058ui_story"].transform.localEulerAngles = arg_316_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_319_1 = arg_316_1.actors_["10058ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect10058ui_story == nil then
				arg_316_1.var_.characterEffect10058ui_story = var_319_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_2 and not isNil(var_319_1) then
				if arg_316_1.var_.characterEffect10058ui_story and not isNil(var_319_1) then
					arg_316_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_2 and arg_316_1.time_ < 0 + var_319_2 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect10058ui_story then
				arg_316_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_319_4 = 0
			local var_319_5 = 0.7

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_6 = arg_316_1:GetWordFromCfg(1109511078)
				local var_319_7 = arg_316_1:FormatText(var_319_6.content)

				arg_316_1.text_.text = var_319_7

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_9 = 28 <= 0 and var_319_5 or var_319_5 * (utf8.len(var_319_7) / 28)

				if (28 <= 0 and var_319_5 or var_319_5 * (utf8.len(var_319_7) / 28)) > 0 and var_319_5 < var_319_9 then
					arg_316_1.talkMaxDuration = var_319_9

					if var_319_9 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_9 + var_319_4
					end
				end

				arg_316_1.text_.text = var_319_7
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb") ~= 0 then
					local var_319_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb") / 1000

					if var_319_10 + var_319_4 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_4
					end

					if var_319_6.prefab_name ~= "" and arg_316_1.actors_[var_319_6.prefab_name] ~= nil then
						local var_319_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_6.prefab_name].transform, "story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb")

						arg_316_1:RecordAudio("1109511078", var_319_11)
						arg_316_1:RecordAudio("1109511078", var_319_11)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511078", "story_v_side_new_1109511.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_12 = math.max(var_319_5, arg_316_1.talkMaxDuration)

			if var_319_4 <= arg_316_1.time_ and arg_316_1.time_ < var_319_4 + var_319_12 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_4) / var_319_12

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_4 + var_319_12 and arg_316_1.time_ < var_319_4 + var_319_12 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
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

		arg_316_1:InitPlayNodeList()
	end,
	Play1109511079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1109511079
		arg_320_1.duration_ = 7.6

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1109511080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.825

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(1109511079)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 33 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 33)

				if (33 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 33)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb")

						arg_320_1:RecordAudio("1109511079", var_323_6)
						arg_320_1:RecordAudio("1109511079", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511079", "story_v_side_new_1109511.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1109511080 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1109511080
		arg_324_1.duration_ = 9.7

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1109511081(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_327_0 = 0
			local var_327_1 = 1.1

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_2 = arg_324_1:GetWordFromCfg(1109511080)
				local var_327_3 = arg_324_1:FormatText(var_327_2.content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 44 <= 0 and var_327_1 or var_327_1 * (utf8.len(var_327_3) / 44)

				if (44 <= 0 and var_327_1 or var_327_1 * (utf8.len(var_327_3) / 44)) > 0 and var_327_1 < var_327_5 then
					arg_324_1.talkMaxDuration = var_327_5

					if var_327_5 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb") ~= 0 then
					local var_327_6 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb") / 1000

					if var_327_6 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_6 + var_327_0
					end

					if var_327_2.prefab_name ~= "" and arg_324_1.actors_[var_327_2.prefab_name] ~= nil then
						local var_327_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_2.prefab_name].transform, "story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb")

						arg_324_1:RecordAudio("1109511080", var_327_7)
						arg_324_1:RecordAudio("1109511080", var_327_7)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511080", "story_v_side_new_1109511.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_8 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_8 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_8

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_8 and arg_324_1.time_ < var_327_0 + var_327_8 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1109511081 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1109511081
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1109511082(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["10058ui_story"]) and arg_328_1.var_.characterEffect10058ui_story == nil then
				arg_328_1.var_.characterEffect10058ui_story = arg_328_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["10058ui_story"]) then
				if arg_328_1.var_.characterEffect10058ui_story and not isNil(arg_328_1.actors_["10058ui_story"]) then
					arg_328_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_328_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0) / var_331_0)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["10058ui_story"]) and arg_328_1.var_.characterEffect10058ui_story then
				arg_328_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_328_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_331_1 = 0
			local var_331_2 = 0.2

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(1109511081).content)

				arg_328_1.text_.text = var_331_3

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 8 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_3) / 8)

				if (8 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_3) / 8)) > 0 and var_331_2 < var_331_5 then
					arg_328_1.talkMaxDuration = var_331_5

					if var_331_5 + var_331_1 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + var_331_1
					end
				end

				arg_328_1.text_.text = var_331_3
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_6 = math.max(var_331_2, arg_328_1.talkMaxDuration)

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_6 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_1) / var_331_6

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_1 + var_331_6 and arg_328_1.time_ < var_331_1 + var_331_6 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1109511082 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1109511082
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1109511083(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10058ui_story = arg_332_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10058ui_story"].transform.position).z)
				arg_332_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["10058ui_story"].transform.localEulerAngles = arg_332_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_332_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10058ui_story"].transform.position).z)
				arg_332_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["10058ui_story"].transform.localEulerAngles = arg_332_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_335_1 = 0
			local var_335_2 = 0.875

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_3 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(1109511082).content)

				arg_332_1.text_.text = var_335_3

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 35 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 35)

				if (35 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 35)) > 0 and var_335_2 < var_335_5 then
					arg_332_1.talkMaxDuration = var_335_5

					if var_335_5 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_3
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_6 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_6 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_6

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_6 and arg_332_1.time_ < var_335_1 + var_335_6 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
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

		arg_332_1:InitPlayNodeList()
	end,
	Play1109511083 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1109511083
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1109511084(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.875

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_1 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(1109511083).content)

				arg_336_1.text_.text = var_339_1

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_3 = 35 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 35)

				if (35 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 35)) > 0 and var_339_0 < var_339_3 then
					arg_336_1.talkMaxDuration = var_339_3

					if var_339_3 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_3 + 0
					end
				end

				arg_336_1.text_.text = var_339_1
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_4 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_4

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1109511084 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1109511084
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1109511085(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.4

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_1 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(1109511084).content)

				arg_340_1.text_.text = var_343_1

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_3 = 16 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 16)

				if (16 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 16)) > 0 and var_343_0 < var_343_3 then
					arg_340_1.talkMaxDuration = var_343_3

					if var_343_3 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_3 + 0
					end
				end

				arg_340_1.text_.text = var_343_1
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_4 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_4

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1109511085 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1109511085
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1109511086(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10058ui_story = arg_344_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_347_0 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 then
				arg_344_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_344_1.time_ - 0) / var_347_0)
				arg_344_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10058ui_story"].transform.position).z)
				arg_344_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["10058ui_story"].transform.localEulerAngles = arg_344_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 then
				arg_344_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_344_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10058ui_story"].transform.position).z)
				arg_344_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["10058ui_story"].transform.localEulerAngles = arg_344_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_347_1 = 0
			local var_347_2 = 0.7

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(1109511085).content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 28 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 28)

				if (28 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 28)) > 0 and var_347_2 < var_347_5 then
					arg_344_1.talkMaxDuration = var_347_5

					if var_347_5 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_6 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_6 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_6

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_6 and arg_344_1.time_ < var_347_1 + var_347_6 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
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

		arg_344_1:InitPlayNodeList()
	end,
	Play1109511086 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1109511086
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1109511087(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.425

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_1 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(1109511086).content)

				arg_348_1.text_.text = var_351_1

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_3 = 17 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 17)

				if (17 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 17)) > 0 and var_351_0 < var_351_3 then
					arg_348_1.talkMaxDuration = var_351_3

					if var_351_3 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_3 + 0
					end
				end

				arg_348_1.text_.text = var_351_1
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_4 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_4 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_4

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_4 and arg_348_1.time_ < 0 + var_351_4 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1109511087 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1109511087
		arg_352_1.duration_ = 2

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1109511088(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos10058ui_story = arg_352_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_355_0 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 then
				arg_352_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_352_1.time_ - 0) / var_355_0)
				arg_352_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["10058ui_story"].transform.position).z)
				arg_352_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["10058ui_story"].transform.localEulerAngles = arg_352_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 then
				arg_352_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_352_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["10058ui_story"].transform.position).z)
				arg_352_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["10058ui_story"].transform.localEulerAngles = arg_352_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_355_1 = arg_352_1.actors_["10058ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect10058ui_story == nil then
				arg_352_1.var_.characterEffect10058ui_story = var_355_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_2 and not isNil(var_355_1) then
				if arg_352_1.var_.characterEffect10058ui_story and not isNil(var_355_1) then
					arg_352_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_2 and arg_352_1.time_ < 0 + var_355_2 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect10058ui_story then
				arg_352_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_355_4 = 0
			local var_355_5 = 0.075

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_6 = arg_352_1:GetWordFromCfg(1109511087)
				local var_355_7 = arg_352_1:FormatText(var_355_6.content)

				arg_352_1.text_.text = var_355_7

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_9 = 3 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 3)

				if (3 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 3)) > 0 and var_355_5 < var_355_9 then
					arg_352_1.talkMaxDuration = var_355_9

					if var_355_9 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_9 + var_355_4
					end
				end

				arg_352_1.text_.text = var_355_7
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb") ~= 0 then
					local var_355_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb") / 1000

					if var_355_10 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_10 + var_355_4
					end

					if var_355_6.prefab_name ~= "" and arg_352_1.actors_[var_355_6.prefab_name] ~= nil then
						local var_355_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_6.prefab_name].transform, "story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb")

						arg_352_1:RecordAudio("1109511087", var_355_11)
						arg_352_1:RecordAudio("1109511087", var_355_11)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511087", "story_v_side_new_1109511.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_12 = math.max(var_355_5, arg_352_1.talkMaxDuration)

			if var_355_4 <= arg_352_1.time_ and arg_352_1.time_ < var_355_4 + var_355_12 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_4) / var_355_12

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_4 + var_355_12 and arg_352_1.time_ < var_355_4 + var_355_12 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
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

		arg_352_1:InitPlayNodeList()
	end,
	Play1109511088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1109511088
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1109511089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["10058ui_story"]) and arg_356_1.var_.characterEffect10058ui_story == nil then
				arg_356_1.var_.characterEffect10058ui_story = arg_356_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["10058ui_story"]) then
				if arg_356_1.var_.characterEffect10058ui_story and not isNil(arg_356_1.actors_["10058ui_story"]) then
					arg_356_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_356_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_356_1.time_ - 0) / var_359_0)
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["10058ui_story"]) and arg_356_1.var_.characterEffect10058ui_story then
				arg_356_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_356_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_359_1 = 0
			local var_359_2 = 1

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(1109511088).content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 40 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 40)

				if (40 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 40)) > 0 and var_359_2 < var_359_5 then
					arg_356_1.talkMaxDuration = var_359_5

					if var_359_5 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_6 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_6 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_6

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_6 and arg_356_1.time_ < var_359_1 + var_359_6 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1109511089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1109511089
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1109511090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.625

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_1 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(1109511089).content)

				arg_360_1.text_.text = var_363_1

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_3 = 25 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 25)

				if (25 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 25)) > 0 and var_363_0 < var_363_3 then
					arg_360_1.talkMaxDuration = var_363_3

					if var_363_3 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_3 + 0
					end
				end

				arg_360_1.text_.text = var_363_1
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_4 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_4

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1109511090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1109511090
		arg_364_1.duration_ = 8.23

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1109511091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(arg_364_1.actors_["10058ui_story"]) and arg_364_1.var_.characterEffect10058ui_story == nil then
				arg_364_1.var_.characterEffect10058ui_story = arg_364_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_0 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 and not isNil(arg_364_1.actors_["10058ui_story"]) then
				if arg_364_1.var_.characterEffect10058ui_story and not isNil(arg_364_1.actors_["10058ui_story"]) then
					arg_364_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 and not isNil(arg_364_1.actors_["10058ui_story"]) and arg_364_1.var_.characterEffect10058ui_story then
				arg_364_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_367_2 = 0
			local var_367_3 = 0.825

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_2 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_4 = arg_364_1:GetWordFromCfg(1109511090)
				local var_367_5 = arg_364_1:FormatText(var_367_4.content)

				arg_364_1.text_.text = var_367_5

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_7 = 33 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_5) / 33)

				if (33 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_5) / 33)) > 0 and var_367_3 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_2
					end
				end

				arg_364_1.text_.text = var_367_5
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb") / 1000

					if var_367_8 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_2
					end

					if var_367_4.prefab_name ~= "" and arg_364_1.actors_[var_367_4.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_4.prefab_name].transform, "story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb")

						arg_364_1:RecordAudio("1109511090", var_367_9)
						arg_364_1:RecordAudio("1109511090", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511090", "story_v_side_new_1109511.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_3, arg_364_1.talkMaxDuration)

			if var_367_2 <= arg_364_1.time_ and arg_364_1.time_ < var_367_2 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_2) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_2 + var_367_10 and arg_364_1.time_ < var_367_2 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1109511091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1109511091
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1109511092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["10058ui_story"]) and arg_368_1.var_.characterEffect10058ui_story == nil then
				arg_368_1.var_.characterEffect10058ui_story = arg_368_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_0 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["10058ui_story"]) then
				if arg_368_1.var_.characterEffect10058ui_story and not isNil(arg_368_1.actors_["10058ui_story"]) then
					arg_368_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_368_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_368_1.time_ - 0) / var_371_0)
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["10058ui_story"]) and arg_368_1.var_.characterEffect10058ui_story then
				arg_368_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_368_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_371_1 = 0
			local var_371_2 = 0.575

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(1109511091).content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 23 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 23)

				if (23 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 23)) > 0 and var_371_2 < var_371_5 then
					arg_368_1.talkMaxDuration = var_371_5

					if var_371_5 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + var_371_1
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_6 = math.max(var_371_2, arg_368_1.talkMaxDuration)

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_6 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_1) / var_371_6

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_1 + var_371_6 and arg_368_1.time_ < var_371_1 + var_371_6 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1109511092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1109511092
		arg_372_1.duration_ = 8.37

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1109511093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["10058ui_story"]) and arg_372_1.var_.characterEffect10058ui_story == nil then
				arg_372_1.var_.characterEffect10058ui_story = arg_372_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["10058ui_story"]) then
				if arg_372_1.var_.characterEffect10058ui_story and not isNil(arg_372_1.actors_["10058ui_story"]) then
					arg_372_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["10058ui_story"]) and arg_372_1.var_.characterEffect10058ui_story then
				arg_372_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_375_2 = 0
			local var_375_3 = 0.825

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_2 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_4 = arg_372_1:GetWordFromCfg(1109511092)
				local var_375_5 = arg_372_1:FormatText(var_375_4.content)

				arg_372_1.text_.text = var_375_5

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_7 = 33 <= 0 and var_375_3 or var_375_3 * (utf8.len(var_375_5) / 33)

				if (33 <= 0 and var_375_3 or var_375_3 * (utf8.len(var_375_5) / 33)) > 0 and var_375_3 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_2
					end
				end

				arg_372_1.text_.text = var_375_5
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb") / 1000

					if var_375_8 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_2
					end

					if var_375_4.prefab_name ~= "" and arg_372_1.actors_[var_375_4.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_4.prefab_name].transform, "story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb")

						arg_372_1:RecordAudio("1109511092", var_375_9)
						arg_372_1:RecordAudio("1109511092", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511092", "story_v_side_new_1109511.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_3, arg_372_1.talkMaxDuration)

			if var_375_2 <= arg_372_1.time_ and arg_372_1.time_ < var_375_2 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_2) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_2 + var_375_10 and arg_372_1.time_ < var_375_2 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1109511093 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1109511093
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1109511094(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["10058ui_story"]) and arg_376_1.var_.characterEffect10058ui_story == nil then
				arg_376_1.var_.characterEffect10058ui_story = arg_376_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["10058ui_story"]) then
				if arg_376_1.var_.characterEffect10058ui_story and not isNil(arg_376_1.actors_["10058ui_story"]) then
					arg_376_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_376_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_376_1.time_ - 0) / var_379_0)
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["10058ui_story"]) and arg_376_1.var_.characterEffect10058ui_story then
				arg_376_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_376_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_379_1 = 0
			local var_379_2 = 0.4

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_3 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(1109511093).content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 16 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 16)

				if (16 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 16)) > 0 and var_379_2 < var_379_5 then
					arg_376_1.talkMaxDuration = var_379_5

					if var_379_5 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_6 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_6 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_6

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_6 and arg_376_1.time_ < var_379_1 + var_379_6 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1109511094 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1109511094
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1109511095(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.475

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(1109511094).content)

				arg_380_1.text_.text = var_383_1

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_3 = 19 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 19)

				if (19 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 19)) > 0 and var_383_0 < var_383_3 then
					arg_380_1.talkMaxDuration = var_383_3

					if var_383_3 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_3 + 0
					end
				end

				arg_380_1.text_.text = var_383_1
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_4 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_4

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1109511095 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1109511095
		arg_384_1.duration_ = 8.2

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1109511096(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["10058ui_story"]) and arg_384_1.var_.characterEffect10058ui_story == nil then
				arg_384_1.var_.characterEffect10058ui_story = arg_384_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_0 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["10058ui_story"]) then
				if arg_384_1.var_.characterEffect10058ui_story and not isNil(arg_384_1.actors_["10058ui_story"]) then
					arg_384_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["10058ui_story"]) and arg_384_1.var_.characterEffect10058ui_story then
				arg_384_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action424")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_387_2 = 0
			local var_387_3 = 0.75

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_2 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_4 = arg_384_1:GetWordFromCfg(1109511095)
				local var_387_5 = arg_384_1:FormatText(var_387_4.content)

				arg_384_1.text_.text = var_387_5

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_7 = 30 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_5) / 30)

				if (30 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_5) / 30)) > 0 and var_387_3 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_2
					end
				end

				arg_384_1.text_.text = var_387_5
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb") / 1000

					if var_387_8 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_2
					end

					if var_387_4.prefab_name ~= "" and arg_384_1.actors_[var_387_4.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_4.prefab_name].transform, "story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb")

						arg_384_1:RecordAudio("1109511095", var_387_9)
						arg_384_1:RecordAudio("1109511095", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511095", "story_v_side_new_1109511.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_3, arg_384_1.talkMaxDuration)

			if var_387_2 <= arg_384_1.time_ and arg_384_1.time_ < var_387_2 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_2) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_2 + var_387_10 and arg_384_1.time_ < var_387_2 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1109511096 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1109511096
		arg_388_1.duration_ = 7.97

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1109511097(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 1.31666666666667 < arg_388_1.time_ and arg_388_1.time_ <= 1.31666666666667 + arg_391_0 then
				local var_391_0 = arg_388_1.bgs_.X203g

				arg_388_1.bgs_.X203g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_391_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_1 = var_391_0:GetComponent("SpriteRenderer")

				if var_391_1 and var_391_1.sprite then
					local var_391_2 = 2 * (var_391_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_391_0.transform.localScale = Vector3.New(var_391_2 / var_391_1.sprite.bounds.size.y < var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x and var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x or var_391_2 / var_391_1.sprite.bounds.size.y, var_391_2 / var_391_1.sprite.bounds.size.y < var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x and var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x or var_391_2 / var_391_1.sprite.bounds.size.y, 0)
				end

				for iter_391_0, iter_391_1 in pairs(arg_388_1.bgs_) do
					if iter_391_0 ~= "X203g" then
						iter_391_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_3 = 1.31666666666667

			if 1.31666666666667 < arg_388_1.time_ and arg_388_1.time_ <= var_391_3 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			if arg_388_1.time_ >= var_391_3 + 0.3 and arg_388_1.time_ < var_391_3 + 0.3 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end

			local var_391_4 = 0

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_5 = 1.31666666666667

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_5 then
				local var_391_6 = Color.New(0, 0, 0)

				var_391_6.a = Mathf.Lerp(0, 1, (arg_388_1.time_ - var_391_4) / var_391_5)
				arg_388_1.mask_.color = var_391_6
			end

			if arg_388_1.time_ >= var_391_4 + var_391_5 and arg_388_1.time_ < var_391_4 + var_391_5 + arg_391_0 then
				local var_391_7 = Color.New(0, 0, 0)

				var_391_7.a = 1
				arg_388_1.mask_.color = var_391_7
			end

			local var_391_8 = 1.31666666666667

			if 1.31666666666667 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_9 = 2

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_9 then
				local var_391_10 = Color.New(0, 0, 0)

				var_391_10.a = Mathf.Lerp(1, 0, (arg_388_1.time_ - var_391_8) / var_391_9)
				arg_388_1.mask_.color = var_391_10
			end

			if arg_388_1.time_ >= var_391_8 + var_391_9 and arg_388_1.time_ < var_391_8 + var_391_9 + arg_391_0 then
				local var_391_11 = Color.New(0, 0, 0)

				arg_388_1.mask_.enabled = false
				var_391_11.a = 0
				arg_388_1.mask_.color = var_391_11
			end

			local var_391_12 = arg_388_1.actors_["10058ui_story"].transform

			if 1.31666666666667 < arg_388_1.time_ and arg_388_1.time_ <= 1.31666666666667 + arg_391_0 then
				arg_388_1.var_.moveOldPos10058ui_story = var_391_12.localPosition
			end

			local var_391_13 = 0.001

			if 1.31666666666667 <= arg_388_1.time_ and arg_388_1.time_ < 1.31666666666667 + var_391_13 then
				var_391_12.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_388_1.time_ - 1.31666666666667) / var_391_13)
				var_391_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_12.position).x, (manager.ui.mainCamera.transform.position - var_391_12.position).y, (manager.ui.mainCamera.transform.position - var_391_12.position).z)
				var_391_12.localEulerAngles.z = 0
				var_391_12.localEulerAngles.x = 0
				var_391_12.localEulerAngles = var_391_12.localEulerAngles
			end

			if arg_388_1.time_ >= 1.31666666666667 + var_391_13 and arg_388_1.time_ < 1.31666666666667 + var_391_13 + arg_391_0 then
				var_391_12.localPosition = Vector3.New(0, 100, 0)
				var_391_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_12.position).x, (manager.ui.mainCamera.transform.position - var_391_12.position).y, (manager.ui.mainCamera.transform.position - var_391_12.position).z)
				var_391_12.localEulerAngles.z = 0
				var_391_12.localEulerAngles.x = 0
				var_391_12.localEulerAngles = var_391_12.localEulerAngles
			end

			local var_391_14 = arg_388_1.actors_["10058ui_story"]

			if 1.31666666666667 < arg_388_1.time_ and arg_388_1.time_ <= 1.31666666666667 + arg_391_0 and not isNil(var_391_14) and arg_388_1.var_.characterEffect10058ui_story == nil then
				arg_388_1.var_.characterEffect10058ui_story = var_391_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_15 = 0.200000002980232

			if 1.31666666666667 <= arg_388_1.time_ and arg_388_1.time_ < 1.31666666666667 + var_391_15 and not isNil(var_391_14) then
				if arg_388_1.var_.characterEffect10058ui_story and not isNil(var_391_14) then
					arg_388_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_388_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 1.31666666666667) / var_391_15)
				end
			end

			if arg_388_1.time_ >= 1.31666666666667 + var_391_15 and arg_388_1.time_ < 1.31666666666667 + var_391_15 + arg_391_0 and not isNil(var_391_14) and arg_388_1.var_.characterEffect10058ui_story then
				arg_388_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_388_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if arg_388_1.frameCnt_ <= 1 then
				arg_388_1.dialog_:SetActive(false)
			end

			local var_391_16 = 2.96666666666667
			local var_391_17 = 0.5

			if 2.96666666666667 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				arg_388_1.dialog_:SetActive(true)

				arg_388_1.dialogCg_.alpha = 0

				local var_391_18 = LeanTween.value(arg_388_1.dialog_, 0, 1, 0.3)

				var_391_18:setOnUpdate(LuaHelper.FloatAction(function(arg_392_0)
					arg_388_1.dialogCg_.alpha = arg_392_0
				end))
				var_391_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_388_1.dialog_)
					var_391_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_388_1.duration_ = arg_388_1.duration_ + 0.3

				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_19 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(1109511096).content)

				arg_388_1.text_.text = var_391_19

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_21 = 20 <= 0 and var_391_17 or var_391_17 * (utf8.len(var_391_19) / 20)

				if (20 <= 0 and var_391_17 or var_391_17 * (utf8.len(var_391_19) / 20)) > 0 and var_391_17 < var_391_21 then
					arg_388_1.talkMaxDuration = var_391_21
					var_391_16 = var_391_16 + 0.3

					if var_391_21 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_21 + var_391_16
					end
				end

				arg_388_1.text_.text = var_391_19
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_22 = var_391_16 + 0.3
			local var_391_23 = math.max(var_391_17, arg_388_1.talkMaxDuration)

			if var_391_16 + 0.3 <= arg_388_1.time_ and arg_388_1.time_ < var_391_22 + var_391_23 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_22) / var_391_23

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_22 + var_391_23 and arg_388_1.time_ < var_391_22 + var_391_23 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.31666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1109511097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1109511097
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1109511098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.975

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(1109511097).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 39 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 39)

				if (39 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 39)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1109511098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1109511098
		arg_398_1.duration_ = 4.67

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1109511099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos10058ui_story = arg_398_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_401_0 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 then
				arg_398_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_398_1.time_ - 0) / var_401_0)
				arg_398_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["10058ui_story"].transform.position).z)
				arg_398_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["10058ui_story"].transform.localEulerAngles = arg_398_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 then
				arg_398_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_398_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["10058ui_story"].transform.position).z)
				arg_398_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["10058ui_story"].transform.localEulerAngles = arg_398_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_401_1 = arg_398_1.actors_["10058ui_story"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect10058ui_story == nil then
				arg_398_1.var_.characterEffect10058ui_story = var_401_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_2 and not isNil(var_401_1) then
				if arg_398_1.var_.characterEffect10058ui_story and not isNil(var_401_1) then
					arg_398_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_2 and arg_398_1.time_ < 0 + var_401_2 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect10058ui_story then
				arg_398_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_401_4 = 0
			local var_401_5 = 0.45

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_6 = arg_398_1:GetWordFromCfg(1109511098)
				local var_401_7 = arg_398_1:FormatText(var_401_6.content)

				arg_398_1.text_.text = var_401_7

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_9 = 18 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 18)

				if (18 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 18)) > 0 and var_401_5 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_7
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb") / 1000

					if var_401_10 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_4
					end

					if var_401_6.prefab_name ~= "" and arg_398_1.actors_[var_401_6.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_6.prefab_name].transform, "story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb")

						arg_398_1:RecordAudio("1109511098", var_401_11)
						arg_398_1:RecordAudio("1109511098", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511098", "story_v_side_new_1109511.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_12 = math.max(var_401_5, arg_398_1.talkMaxDuration)

			if var_401_4 <= arg_398_1.time_ and arg_398_1.time_ < var_401_4 + var_401_12 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_4) / var_401_12

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_4 + var_401_12 and arg_398_1.time_ < var_401_4 + var_401_12 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
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

		arg_398_1:InitPlayNodeList()
	end,
	Play1109511099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1109511099
		arg_402_1.duration_ = 4.1

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1109511100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.475

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_1 = arg_402_1:GetWordFromCfg(1109511099)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 19 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 19)

				if (19 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 19)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb")

						arg_402_1:RecordAudio("1109511099", var_405_6)
						arg_402_1:RecordAudio("1109511099", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511099", "story_v_side_new_1109511.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1109511100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1109511100
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1109511101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["10058ui_story"]) and arg_406_1.var_.characterEffect10058ui_story == nil then
				arg_406_1.var_.characterEffect10058ui_story = arg_406_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["10058ui_story"]) then
				if arg_406_1.var_.characterEffect10058ui_story and not isNil(arg_406_1.actors_["10058ui_story"]) then
					arg_406_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_406_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_0)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["10058ui_story"]) and arg_406_1.var_.characterEffect10058ui_story then
				arg_406_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_406_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_409_1 = 0
			local var_409_2 = 0.525

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(1109511100).content)

				arg_406_1.text_.text = var_409_3

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 21 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 21)

				if (21 <= 0 and var_409_2 or var_409_2 * (utf8.len(var_409_3) / 21)) > 0 and var_409_2 < var_409_5 then
					arg_406_1.talkMaxDuration = var_409_5

					if var_409_5 + var_409_1 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + var_409_1
					end
				end

				arg_406_1.text_.text = var_409_3
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_6 = math.max(var_409_2, arg_406_1.talkMaxDuration)

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_6 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_1) / var_409_6

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_1 + var_409_6 and arg_406_1.time_ < var_409_1 + var_409_6 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1109511101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1109511101
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1109511102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.25

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_1 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(1109511101).content)

				arg_410_1.text_.text = var_413_1

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_3 = 10 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 10)

				if (10 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 10)) > 0 and var_413_0 < var_413_3 then
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
	Play1109511102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1109511102
		arg_414_1.duration_ = 3.7

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1109511103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["10058ui_story"]) and arg_414_1.var_.characterEffect10058ui_story == nil then
				arg_414_1.var_.characterEffect10058ui_story = arg_414_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_0 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["10058ui_story"]) then
				if arg_414_1.var_.characterEffect10058ui_story and not isNil(arg_414_1.actors_["10058ui_story"]) then
					arg_414_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["10058ui_story"]) and arg_414_1.var_.characterEffect10058ui_story then
				arg_414_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_417_2 = 0
			local var_417_3 = 0.45

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_2 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_4 = arg_414_1:GetWordFromCfg(1109511102)
				local var_417_5 = arg_414_1:FormatText(var_417_4.content)

				arg_414_1.text_.text = var_417_5

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_7 = 18 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_5) / 18)

				if (18 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_5) / 18)) > 0 and var_417_3 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_2
					end
				end

				arg_414_1.text_.text = var_417_5
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb") / 1000

					if var_417_8 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_2
					end

					if var_417_4.prefab_name ~= "" and arg_414_1.actors_[var_417_4.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_4.prefab_name].transform, "story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb")

						arg_414_1:RecordAudio("1109511102", var_417_9)
						arg_414_1:RecordAudio("1109511102", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511102", "story_v_side_new_1109511.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_3, arg_414_1.talkMaxDuration)

			if var_417_2 <= arg_414_1.time_ and arg_414_1.time_ < var_417_2 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_2) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_2 + var_417_10 and arg_414_1.time_ < var_417_2 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1109511103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1109511103
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1109511104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["10058ui_story"]) and arg_418_1.var_.characterEffect10058ui_story == nil then
				arg_418_1.var_.characterEffect10058ui_story = arg_418_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["10058ui_story"]) then
				if arg_418_1.var_.characterEffect10058ui_story and not isNil(arg_418_1.actors_["10058ui_story"]) then
					arg_418_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_418_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_0)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["10058ui_story"]) and arg_418_1.var_.characterEffect10058ui_story then
				arg_418_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_418_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_421_1 = 0
			local var_421_2 = 0.375

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

				local var_421_3 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(1109511103).content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 15 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 15)

				if (15 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 15)) > 0 and var_421_2 < var_421_5 then
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
	Play1109511104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1109511104
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1109511105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.85

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
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

				local var_425_1 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(1109511104).content)

				arg_422_1.text_.text = var_425_1

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_3 = 34 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 34)

				if (34 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 34)) > 0 and var_425_0 < var_425_3 then
					arg_422_1.talkMaxDuration = var_425_3

					if var_425_3 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_3 + 0
					end
				end

				arg_422_1.text_.text = var_425_1
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_4 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_4

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1109511105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1109511105
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1109511106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.675

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_1 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(1109511105).content)

				arg_426_1.text_.text = var_429_1

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_3 = 27 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 27)

				if (27 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_1) / 27)) > 0 and var_429_0 < var_429_3 then
					arg_426_1.talkMaxDuration = var_429_3

					if var_429_3 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_3 + 0
					end
				end

				arg_426_1.text_.text = var_429_1
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_4 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_4 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_4

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_4 and arg_426_1.time_ < 0 + var_429_4 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1109511106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1109511106
		arg_430_1.duration_ = 9.13

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1109511107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["10058ui_story"]) and arg_430_1.var_.characterEffect10058ui_story == nil then
				arg_430_1.var_.characterEffect10058ui_story = arg_430_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["10058ui_story"]) then
				if arg_430_1.var_.characterEffect10058ui_story and not isNil(arg_430_1.actors_["10058ui_story"]) then
					arg_430_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["10058ui_story"]) and arg_430_1.var_.characterEffect10058ui_story then
				arg_430_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_433_2 = 0
			local var_433_3 = 0.875

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_2 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_4 = arg_430_1:GetWordFromCfg(1109511106)
				local var_433_5 = arg_430_1:FormatText(var_433_4.content)

				arg_430_1.text_.text = var_433_5

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_7 = 35 <= 0 and var_433_3 or var_433_3 * (utf8.len(var_433_5) / 35)

				if (35 <= 0 and var_433_3 or var_433_3 * (utf8.len(var_433_5) / 35)) > 0 and var_433_3 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_2 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_2
					end
				end

				arg_430_1.text_.text = var_433_5
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb") / 1000

					if var_433_8 + var_433_2 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_2
					end

					if var_433_4.prefab_name ~= "" and arg_430_1.actors_[var_433_4.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_4.prefab_name].transform, "story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb")

						arg_430_1:RecordAudio("1109511106", var_433_9)
						arg_430_1:RecordAudio("1109511106", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511106", "story_v_side_new_1109511.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_3, arg_430_1.talkMaxDuration)

			if var_433_2 <= arg_430_1.time_ and arg_430_1.time_ < var_433_2 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_2) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_2 + var_433_10 and arg_430_1.time_ < var_433_2 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1109511107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1109511107
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1109511108(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["10058ui_story"]) and arg_434_1.var_.characterEffect10058ui_story == nil then
				arg_434_1.var_.characterEffect10058ui_story = arg_434_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_0 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["10058ui_story"]) then
				if arg_434_1.var_.characterEffect10058ui_story and not isNil(arg_434_1.actors_["10058ui_story"]) then
					arg_434_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_434_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_0)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["10058ui_story"]) and arg_434_1.var_.characterEffect10058ui_story then
				arg_434_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_434_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_437_1 = 0
			local var_437_2 = 0.725

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(1109511107).content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 29 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 29)

				if (29 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 29)) > 0 and var_437_2 < var_437_5 then
					arg_434_1.talkMaxDuration = var_437_5

					if var_437_5 + var_437_1 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + var_437_1
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_6 = math.max(var_437_2, arg_434_1.talkMaxDuration)

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_6 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_1) / var_437_6

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_1 + var_437_6 and arg_434_1.time_ < var_437_1 + var_437_6 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1109511108 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1109511108
		arg_438_1.duration_ = 4.4

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1109511109(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["10058ui_story"]) and arg_438_1.var_.characterEffect10058ui_story == nil then
				arg_438_1.var_.characterEffect10058ui_story = arg_438_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_0 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["10058ui_story"]) then
				if arg_438_1.var_.characterEffect10058ui_story and not isNil(arg_438_1.actors_["10058ui_story"]) then
					arg_438_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["10058ui_story"]) and arg_438_1.var_.characterEffect10058ui_story then
				arg_438_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_441_2 = 0
			local var_441_3 = 0.475

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_2 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_4 = arg_438_1:GetWordFromCfg(1109511108)
				local var_441_5 = arg_438_1:FormatText(var_441_4.content)

				arg_438_1.text_.text = var_441_5

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_7 = 19 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_5) / 19)

				if (19 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_5) / 19)) > 0 and var_441_3 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_2
					end
				end

				arg_438_1.text_.text = var_441_5
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb") / 1000

					if var_441_8 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_2
					end

					if var_441_4.prefab_name ~= "" and arg_438_1.actors_[var_441_4.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_4.prefab_name].transform, "story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb")

						arg_438_1:RecordAudio("1109511108", var_441_9)
						arg_438_1:RecordAudio("1109511108", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511108", "story_v_side_new_1109511.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_3, arg_438_1.talkMaxDuration)

			if var_441_2 <= arg_438_1.time_ and arg_438_1.time_ < var_441_2 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_2) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_2 + var_441_10 and arg_438_1.time_ < var_441_2 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1109511109 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1109511109
		arg_442_1.duration_ = 5.3

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1109511110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_445_0 = 0
			local var_445_1 = 0.6

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_2 = arg_442_1:GetWordFromCfg(1109511109)
				local var_445_3 = arg_442_1:FormatText(var_445_2.content)

				arg_442_1.text_.text = var_445_3

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 24 <= 0 and var_445_1 or var_445_1 * (utf8.len(var_445_3) / 24)

				if (24 <= 0 and var_445_1 or var_445_1 * (utf8.len(var_445_3) / 24)) > 0 and var_445_1 < var_445_5 then
					arg_442_1.talkMaxDuration = var_445_5

					if var_445_5 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_3
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb") ~= 0 then
					local var_445_6 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb") / 1000

					if var_445_6 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_6 + var_445_0
					end

					if var_445_2.prefab_name ~= "" and arg_442_1.actors_[var_445_2.prefab_name] ~= nil then
						local var_445_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_2.prefab_name].transform, "story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb")

						arg_442_1:RecordAudio("1109511109", var_445_7)
						arg_442_1:RecordAudio("1109511109", var_445_7)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511109", "story_v_side_new_1109511.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_8 and arg_442_1.time_ < var_445_0 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1109511110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1109511110
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1109511111(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["10058ui_story"]) and arg_446_1.var_.characterEffect10058ui_story == nil then
				arg_446_1.var_.characterEffect10058ui_story = arg_446_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_0 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["10058ui_story"]) then
				if arg_446_1.var_.characterEffect10058ui_story and not isNil(arg_446_1.actors_["10058ui_story"]) then
					arg_446_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_446_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_0)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["10058ui_story"]) and arg_446_1.var_.characterEffect10058ui_story then
				arg_446_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_446_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_449_1 = 0
			local var_449_2 = 0.75

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(1109511110).content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 30 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_3) / 30)

				if (30 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_3) / 30)) > 0 and var_449_2 < var_449_5 then
					arg_446_1.talkMaxDuration = var_449_5

					if var_449_5 + var_449_1 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + var_449_1
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_6 = math.max(var_449_2, arg_446_1.talkMaxDuration)

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_6 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_1) / var_449_6

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_1 + var_449_6 and arg_446_1.time_ < var_449_1 + var_449_6 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1109511111 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1109511111
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1109511112(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.85

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_1 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(1109511111).content)

				arg_450_1.text_.text = var_453_1

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_3 = 34 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 34)

				if (34 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_1) / 34)) > 0 and var_453_0 < var_453_3 then
					arg_450_1.talkMaxDuration = var_453_3

					if var_453_3 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_3 + 0
					end
				end

				arg_450_1.text_.text = var_453_1
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_4 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_4 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_4

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_4 and arg_450_1.time_ < 0 + var_453_4 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1109511112 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1109511112
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1109511113(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.975

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_1 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(1109511112).content)

				arg_454_1.text_.text = var_457_1

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_3 = 39 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 39)

				if (39 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 39)) > 0 and var_457_0 < var_457_3 then
					arg_454_1.talkMaxDuration = var_457_3

					if var_457_3 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_3 + 0
					end
				end

				arg_454_1.text_.text = var_457_1
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_4 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_4

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1109511113 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1109511113
		arg_458_1.duration_ = 1.23

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1109511114(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["10058ui_story"]) and arg_458_1.var_.characterEffect10058ui_story == nil then
				arg_458_1.var_.characterEffect10058ui_story = arg_458_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["10058ui_story"]) then
				if arg_458_1.var_.characterEffect10058ui_story and not isNil(arg_458_1.actors_["10058ui_story"]) then
					arg_458_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["10058ui_story"]) and arg_458_1.var_.characterEffect10058ui_story then
				arg_458_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_461_2 = 0
			local var_461_3 = 0.1

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_2 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_4 = arg_458_1:GetWordFromCfg(1109511113)
				local var_461_5 = arg_458_1:FormatText(var_461_4.content)

				arg_458_1.text_.text = var_461_5

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_7 = 4 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_5) / 4)

				if (4 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_5) / 4)) > 0 and var_461_3 < var_461_7 then
					arg_458_1.talkMaxDuration = var_461_7

					if var_461_7 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_2
					end
				end

				arg_458_1.text_.text = var_461_5
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb") ~= 0 then
					local var_461_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb") / 1000

					if var_461_8 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_8 + var_461_2
					end

					if var_461_4.prefab_name ~= "" and arg_458_1.actors_[var_461_4.prefab_name] ~= nil then
						local var_461_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_4.prefab_name].transform, "story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb")

						arg_458_1:RecordAudio("1109511113", var_461_9)
						arg_458_1:RecordAudio("1109511113", var_461_9)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511113", "story_v_side_new_1109511.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_10 = math.max(var_461_3, arg_458_1.talkMaxDuration)

			if var_461_2 <= arg_458_1.time_ and arg_458_1.time_ < var_461_2 + var_461_10 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_2) / var_461_10

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_2 + var_461_10 and arg_458_1.time_ < var_461_2 + var_461_10 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1109511114 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1109511114
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1109511115(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos10058ui_story = arg_462_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_465_0 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 then
				arg_462_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_462_1.time_ - 0) / var_465_0)
				arg_462_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["10058ui_story"].transform.position).z)
				arg_462_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["10058ui_story"].transform.localEulerAngles = arg_462_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 then
				arg_462_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_462_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_462_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_462_1.actors_["10058ui_story"].transform.position).z)
				arg_462_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_462_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_462_1.actors_["10058ui_story"].transform.localEulerAngles = arg_462_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_465_1 = 0
			local var_465_2 = 0.425

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_3 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(1109511114).content)

				arg_462_1.text_.text = var_465_3

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_5 = 17 <= 0 and var_465_2 or var_465_2 * (utf8.len(var_465_3) / 17)

				if (17 <= 0 and var_465_2 or var_465_2 * (utf8.len(var_465_3) / 17)) > 0 and var_465_2 < var_465_5 then
					arg_462_1.talkMaxDuration = var_465_5

					if var_465_5 + var_465_1 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_5 + var_465_1
					end
				end

				arg_462_1.text_.text = var_465_3
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_6 = math.max(var_465_2, arg_462_1.talkMaxDuration)

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_6 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_1) / var_465_6

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_1 + var_465_6 and arg_462_1.time_ < var_465_1 + var_465_6 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
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

		arg_462_1:InitPlayNodeList()
	end,
	Play1109511115 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1109511115
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1109511116(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0.75

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_1 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(1109511115).content)

				arg_466_1.text_.text = var_469_1

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_3 = 30 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_1) / 30)

				if (30 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_1) / 30)) > 0 and var_469_0 < var_469_3 then
					arg_466_1.talkMaxDuration = var_469_3

					if var_469_3 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_3 + 0
					end
				end

				arg_466_1.text_.text = var_469_1
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_4 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_4 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_4

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_4 and arg_466_1.time_ < 0 + var_469_4 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1109511116 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1109511116
		arg_470_1.duration_ = 4.7

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1109511117(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(arg_470_1.actors_["10058ui_story"]) and arg_470_1.var_.characterEffect10058ui_story == nil then
				arg_470_1.var_.characterEffect10058ui_story = arg_470_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_0 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 and not isNil(arg_470_1.actors_["10058ui_story"]) then
				if arg_470_1.var_.characterEffect10058ui_story and not isNil(arg_470_1.actors_["10058ui_story"]) then
					arg_470_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 and not isNil(arg_470_1.actors_["10058ui_story"]) and arg_470_1.var_.characterEffect10058ui_story then
				arg_470_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_473_2 = arg_470_1.actors_["10058ui_story"].transform

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos10058ui_story = var_473_2.localPosition
			end

			local var_473_3 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_3 then
				var_473_2.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_470_1.time_ - 0) / var_473_3)
				var_473_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_2.position).x, (manager.ui.mainCamera.transform.position - var_473_2.position).y, (manager.ui.mainCamera.transform.position - var_473_2.position).z)
				var_473_2.localEulerAngles.z = 0
				var_473_2.localEulerAngles.x = 0
				var_473_2.localEulerAngles = var_473_2.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_3 and arg_470_1.time_ < 0 + var_473_3 + arg_473_0 then
				var_473_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_473_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_2.position).x, (manager.ui.mainCamera.transform.position - var_473_2.position).y, (manager.ui.mainCamera.transform.position - var_473_2.position).z)
				var_473_2.localEulerAngles.z = 0
				var_473_2.localEulerAngles.x = 0
				var_473_2.localEulerAngles = var_473_2.localEulerAngles
			end

			local var_473_4 = 0
			local var_473_5 = 0.4

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_4 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_6 = arg_470_1:GetWordFromCfg(1109511116)
				local var_473_7 = arg_470_1:FormatText(var_473_6.content)

				arg_470_1.text_.text = var_473_7

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_9 = 16 <= 0 and var_473_5 or var_473_5 * (utf8.len(var_473_7) / 16)

				if (16 <= 0 and var_473_5 or var_473_5 * (utf8.len(var_473_7) / 16)) > 0 and var_473_5 < var_473_9 then
					arg_470_1.talkMaxDuration = var_473_9

					if var_473_9 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_9 + var_473_4
					end
				end

				arg_470_1.text_.text = var_473_7
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb") ~= 0 then
					local var_473_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb") / 1000

					if var_473_10 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_10 + var_473_4
					end

					if var_473_6.prefab_name ~= "" and arg_470_1.actors_[var_473_6.prefab_name] ~= nil then
						local var_473_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_6.prefab_name].transform, "story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb")

						arg_470_1:RecordAudio("1109511116", var_473_11)
						arg_470_1:RecordAudio("1109511116", var_473_11)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511116", "story_v_side_new_1109511.awb")
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
				actorName = "10058ui_story",
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
	Play1109511117 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1109511117
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1109511118(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(arg_474_1.actors_["10058ui_story"]) and arg_474_1.var_.characterEffect10058ui_story == nil then
				arg_474_1.var_.characterEffect10058ui_story = arg_474_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_0 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 and not isNil(arg_474_1.actors_["10058ui_story"]) then
				if arg_474_1.var_.characterEffect10058ui_story and not isNil(arg_474_1.actors_["10058ui_story"]) then
					arg_474_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_474_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_474_1.time_ - 0) / var_477_0)
				end
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 and not isNil(arg_474_1.actors_["10058ui_story"]) and arg_474_1.var_.characterEffect10058ui_story then
				arg_474_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_474_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_477_1 = 0
			local var_477_2 = 0.525

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_3 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(1109511117).content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 21 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 21)

				if (21 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 21)) > 0 and var_477_2 < var_477_5 then
					arg_474_1.talkMaxDuration = var_477_5

					if var_477_5 + var_477_1 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + var_477_1
					end
				end

				arg_474_1.text_.text = var_477_3
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_6 = math.max(var_477_2, arg_474_1.talkMaxDuration)

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_6 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_1) / var_477_6

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_1 + var_477_6 and arg_474_1.time_ < var_477_1 + var_477_6 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play1109511118 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1109511118
		arg_478_1.duration_ = 5.27

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1109511119(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["10058ui_story"]) and arg_478_1.var_.characterEffect10058ui_story == nil then
				arg_478_1.var_.characterEffect10058ui_story = arg_478_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_0 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["10058ui_story"]) then
				if arg_478_1.var_.characterEffect10058ui_story and not isNil(arg_478_1.actors_["10058ui_story"]) then
					arg_478_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["10058ui_story"]) and arg_478_1.var_.characterEffect10058ui_story then
				arg_478_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_481_2 = 0
			local var_481_3 = 0.6

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_2 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_4 = arg_478_1:GetWordFromCfg(1109511118)
				local var_481_5 = arg_478_1:FormatText(var_481_4.content)

				arg_478_1.text_.text = var_481_5

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_7 = 24 <= 0 and var_481_3 or var_481_3 * (utf8.len(var_481_5) / 24)

				if (24 <= 0 and var_481_3 or var_481_3 * (utf8.len(var_481_5) / 24)) > 0 and var_481_3 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_2 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_2
					end
				end

				arg_478_1.text_.text = var_481_5
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb") / 1000

					if var_481_8 + var_481_2 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_2
					end

					if var_481_4.prefab_name ~= "" and arg_478_1.actors_[var_481_4.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_4.prefab_name].transform, "story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb")

						arg_478_1:RecordAudio("1109511118", var_481_9)
						arg_478_1:RecordAudio("1109511118", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511118", "story_v_side_new_1109511.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_3, arg_478_1.talkMaxDuration)

			if var_481_2 <= arg_478_1.time_ and arg_478_1.time_ < var_481_2 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_2) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_2 + var_481_10 and arg_478_1.time_ < var_481_2 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play1109511119 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1109511119
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1109511120(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["10058ui_story"]) and arg_482_1.var_.characterEffect10058ui_story == nil then
				arg_482_1.var_.characterEffect10058ui_story = arg_482_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_0 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["10058ui_story"]) then
				if arg_482_1.var_.characterEffect10058ui_story and not isNil(arg_482_1.actors_["10058ui_story"]) then
					arg_482_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_482_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_0)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["10058ui_story"]) and arg_482_1.var_.characterEffect10058ui_story then
				arg_482_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_482_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_485_1 = 0
			local var_485_2 = 0.825

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_3 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(1109511119).content)

				arg_482_1.text_.text = var_485_3

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 33 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_3) / 33)

				if (33 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_3) / 33)) > 0 and var_485_2 < var_485_5 then
					arg_482_1.talkMaxDuration = var_485_5

					if var_485_5 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + var_485_1
					end
				end

				arg_482_1.text_.text = var_485_3
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_6 = math.max(var_485_2, arg_482_1.talkMaxDuration)

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_6 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_1) / var_485_6

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_1 + var_485_6 and arg_482_1.time_ < var_485_1 + var_485_6 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1109511120 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1109511120
		arg_486_1.duration_ = 4.3

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1109511121(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(arg_486_1.actors_["10058ui_story"]) and arg_486_1.var_.characterEffect10058ui_story == nil then
				arg_486_1.var_.characterEffect10058ui_story = arg_486_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_0 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 and not isNil(arg_486_1.actors_["10058ui_story"]) then
				if arg_486_1.var_.characterEffect10058ui_story and not isNil(arg_486_1.actors_["10058ui_story"]) then
					arg_486_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 and not isNil(arg_486_1.actors_["10058ui_story"]) and arg_486_1.var_.characterEffect10058ui_story then
				arg_486_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_489_2 = 0
			local var_489_3 = 0.35

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_2 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_4 = arg_486_1:GetWordFromCfg(1109511120)
				local var_489_5 = arg_486_1:FormatText(var_489_4.content)

				arg_486_1.text_.text = var_489_5

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_7 = 14 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_5) / 14)

				if (14 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_5) / 14)) > 0 and var_489_3 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_2 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_2
					end
				end

				arg_486_1.text_.text = var_489_5
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb") ~= 0 then
					local var_489_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb") / 1000

					if var_489_8 + var_489_2 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_8 + var_489_2
					end

					if var_489_4.prefab_name ~= "" and arg_486_1.actors_[var_489_4.prefab_name] ~= nil then
						local var_489_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_4.prefab_name].transform, "story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb")

						arg_486_1:RecordAudio("1109511120", var_489_9)
						arg_486_1:RecordAudio("1109511120", var_489_9)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511120", "story_v_side_new_1109511.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_3, arg_486_1.talkMaxDuration)

			if var_489_2 <= arg_486_1.time_ and arg_486_1.time_ < var_489_2 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_2) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_2 + var_489_10 and arg_486_1.time_ < var_489_2 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1109511121 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1109511121
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1109511122(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["10058ui_story"]) and arg_490_1.var_.characterEffect10058ui_story == nil then
				arg_490_1.var_.characterEffect10058ui_story = arg_490_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["10058ui_story"]) then
				if arg_490_1.var_.characterEffect10058ui_story and not isNil(arg_490_1.actors_["10058ui_story"]) then
					arg_490_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_490_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_490_1.time_ - 0) / var_493_0)
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["10058ui_story"]) and arg_490_1.var_.characterEffect10058ui_story then
				arg_490_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_490_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_493_1 = 0
			local var_493_2 = 0.425

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_3 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(1109511121).content)

				arg_490_1.text_.text = var_493_3

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 17 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 17)

				if (17 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 17)) > 0 and var_493_2 < var_493_5 then
					arg_490_1.talkMaxDuration = var_493_5

					if var_493_5 + var_493_1 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + var_493_1
					end
				end

				arg_490_1.text_.text = var_493_3
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_6 = math.max(var_493_2, arg_490_1.talkMaxDuration)

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_6 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_1) / var_493_6

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_1 + var_493_6 and arg_490_1.time_ < var_493_1 + var_493_6 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1109511122 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1109511122
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1109511123(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.575

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
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

				local var_497_1 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(1109511122).content)

				arg_494_1.text_.text = var_497_1

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_3 = 23 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 23)

				if (23 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 23)) > 0 and var_497_0 < var_497_3 then
					arg_494_1.talkMaxDuration = var_497_3

					if var_497_3 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_3 + 0
					end
				end

				arg_494_1.text_.text = var_497_1
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_4 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_4 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_4

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_4 and arg_494_1.time_ < 0 + var_497_4 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1109511123 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1109511123
		arg_498_1.duration_ = 9.23

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1109511124(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["10058ui_story"]) and arg_498_1.var_.characterEffect10058ui_story == nil then
				arg_498_1.var_.characterEffect10058ui_story = arg_498_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["10058ui_story"]) then
				if arg_498_1.var_.characterEffect10058ui_story and not isNil(arg_498_1.actors_["10058ui_story"]) then
					arg_498_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["10058ui_story"]) and arg_498_1.var_.characterEffect10058ui_story then
				arg_498_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_501_2 = 0
			local var_501_3 = 0.925

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_2 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_4 = arg_498_1:GetWordFromCfg(1109511123)
				local var_501_5 = arg_498_1:FormatText(var_501_4.content)

				arg_498_1.text_.text = var_501_5

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_7 = 37 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 37)

				if (37 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 37)) > 0 and var_501_3 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_2
					end
				end

				arg_498_1.text_.text = var_501_5
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb") ~= 0 then
					local var_501_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb") / 1000

					if var_501_8 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_8 + var_501_2
					end

					if var_501_4.prefab_name ~= "" and arg_498_1.actors_[var_501_4.prefab_name] ~= nil then
						local var_501_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_4.prefab_name].transform, "story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb")

						arg_498_1:RecordAudio("1109511123", var_501_9)
						arg_498_1:RecordAudio("1109511123", var_501_9)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511123", "story_v_side_new_1109511.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_10 = math.max(var_501_3, arg_498_1.talkMaxDuration)

			if var_501_2 <= arg_498_1.time_ and arg_498_1.time_ < var_501_2 + var_501_10 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_2) / var_501_10

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_2 + var_501_10 and arg_498_1.time_ < var_501_2 + var_501_10 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1109511124 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1109511124
		arg_502_1.duration_ = 7.53

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1109511125(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_505_0 = 0
			local var_505_1 = 0.775

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_2 = arg_502_1:GetWordFromCfg(1109511124)
				local var_505_3 = arg_502_1:FormatText(var_505_2.content)

				arg_502_1.text_.text = var_505_3

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 31 <= 0 and var_505_1 or var_505_1 * (utf8.len(var_505_3) / 31)

				if (31 <= 0 and var_505_1 or var_505_1 * (utf8.len(var_505_3) / 31)) > 0 and var_505_1 < var_505_5 then
					arg_502_1.talkMaxDuration = var_505_5

					if var_505_5 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_3
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb") ~= 0 then
					local var_505_6 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb") / 1000

					if var_505_6 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_6 + var_505_0
					end

					if var_505_2.prefab_name ~= "" and arg_502_1.actors_[var_505_2.prefab_name] ~= nil then
						local var_505_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_2.prefab_name].transform, "story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb")

						arg_502_1:RecordAudio("1109511124", var_505_7)
						arg_502_1:RecordAudio("1109511124", var_505_7)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511124", "story_v_side_new_1109511.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_8 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_8 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_8

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_8 and arg_502_1.time_ < var_505_0 + var_505_8 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play1109511125 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1109511125
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1109511126(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["10058ui_story"]) and arg_506_1.var_.characterEffect10058ui_story == nil then
				arg_506_1.var_.characterEffect10058ui_story = arg_506_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_0 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["10058ui_story"]) then
				if arg_506_1.var_.characterEffect10058ui_story and not isNil(arg_506_1.actors_["10058ui_story"]) then
					arg_506_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_506_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_506_1.time_ - 0) / var_509_0)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["10058ui_story"]) and arg_506_1.var_.characterEffect10058ui_story then
				arg_506_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_506_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_509_1 = 0
			local var_509_2 = 0.675

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
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

				local var_509_3 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(1109511125).content)

				arg_506_1.text_.text = var_509_3

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 27 <= 0 and var_509_2 or var_509_2 * (utf8.len(var_509_3) / 27)

				if (27 <= 0 and var_509_2 or var_509_2 * (utf8.len(var_509_3) / 27)) > 0 and var_509_2 < var_509_5 then
					arg_506_1.talkMaxDuration = var_509_5

					if var_509_5 + var_509_1 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_5 + var_509_1
					end
				end

				arg_506_1.text_.text = var_509_3
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_6 = math.max(var_509_2, arg_506_1.talkMaxDuration)

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_6 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_1) / var_509_6

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_1 + var_509_6 and arg_506_1.time_ < var_509_1 + var_509_6 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1109511126 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1109511126
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1109511127(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.875

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_1 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(1109511126).content)

				arg_510_1.text_.text = var_513_1

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_3 = 35 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 35)

				if (35 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 35)) > 0 and var_513_0 < var_513_3 then
					arg_510_1.talkMaxDuration = var_513_3

					if var_513_3 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_3 + 0
					end
				end

				arg_510_1.text_.text = var_513_1
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_4 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_4 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_4

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_4 and arg_510_1.time_ < 0 + var_513_4 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play1109511127 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1109511127
		arg_514_1.duration_ = 8.25

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1109511128(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if arg_514_1.bgs_.ST70 == nil then
				local var_517_0 = Object.Instantiate(arg_514_1.paintGo_)

				var_517_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST70")
				var_517_0.name = "ST70"
				var_517_0.transform.parent = arg_514_1.stage_.transform
				var_517_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_514_1.bgs_.ST70 = var_517_0
			end

			if 1.5 < arg_514_1.time_ and arg_514_1.time_ <= 1.5 + arg_517_0 then
				local var_517_1 = arg_514_1.bgs_.ST70

				arg_514_1.bgs_.ST70.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_517_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_517_2 = var_517_1:GetComponent("SpriteRenderer")

				if var_517_2 and var_517_2.sprite then
					local var_517_3 = 2 * (var_517_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_517_1.transform.localScale = Vector3.New(var_517_3 / var_517_2.sprite.bounds.size.y < var_517_3 * manager.ui.mainCameraCom_.aspect / var_517_2.sprite.bounds.size.x and var_517_3 * manager.ui.mainCameraCom_.aspect / var_517_2.sprite.bounds.size.x or var_517_3 / var_517_2.sprite.bounds.size.y, var_517_3 / var_517_2.sprite.bounds.size.y < var_517_3 * manager.ui.mainCameraCom_.aspect / var_517_2.sprite.bounds.size.x and var_517_3 * manager.ui.mainCameraCom_.aspect / var_517_2.sprite.bounds.size.x or var_517_3 / var_517_2.sprite.bounds.size.y, 0)
				end

				for iter_517_0, iter_517_1 in pairs(arg_514_1.bgs_) do
					if iter_517_0 ~= "ST70" then
						iter_517_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_517_4 = 1.5

			if 1.5 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.allBtn_.enabled = false
			end

			if arg_514_1.time_ >= var_517_4 + 0.3 and arg_514_1.time_ < var_517_4 + 0.3 + arg_517_0 then
				arg_514_1.allBtn_.enabled = true
			end

			local var_517_5 = 0

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_5 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_6 = 1.5

			if var_517_5 <= arg_514_1.time_ and arg_514_1.time_ < var_517_5 + var_517_6 then
				local var_517_7 = Color.New(0, 0, 0)

				var_517_7.a = Mathf.Lerp(0, 1, (arg_514_1.time_ - var_517_5) / var_517_6)
				arg_514_1.mask_.color = var_517_7
			end

			if arg_514_1.time_ >= var_517_5 + var_517_6 and arg_514_1.time_ < var_517_5 + var_517_6 + arg_517_0 then
				local var_517_8 = Color.New(0, 0, 0)

				var_517_8.a = 1
				arg_514_1.mask_.color = var_517_8
			end

			local var_517_9 = 1.5

			if 1.5 < arg_514_1.time_ and arg_514_1.time_ <= var_517_9 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_10 = 2

			if var_517_9 <= arg_514_1.time_ and arg_514_1.time_ < var_517_9 + var_517_10 then
				local var_517_11 = Color.New(0, 0, 0)

				var_517_11.a = Mathf.Lerp(1, 0, (arg_514_1.time_ - var_517_9) / var_517_10)
				arg_514_1.mask_.color = var_517_11
			end

			if arg_514_1.time_ >= var_517_9 + var_517_10 and arg_514_1.time_ < var_517_9 + var_517_10 + arg_517_0 then
				local var_517_12 = Color.New(0, 0, 0)

				arg_514_1.mask_.enabled = false
				var_517_12.a = 0
				arg_514_1.mask_.color = var_517_12
			end

			local var_517_13 = arg_514_1.actors_["10058ui_story"].transform

			if 1.5 < arg_514_1.time_ and arg_514_1.time_ <= 1.5 + arg_517_0 then
				arg_514_1.var_.moveOldPos10058ui_story = var_517_13.localPosition
			end

			local var_517_14 = 0.001

			if 1.5 <= arg_514_1.time_ and arg_514_1.time_ < 1.5 + var_517_14 then
				var_517_13.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_514_1.time_ - 1.5) / var_517_14)
				var_517_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_13.position).x, (manager.ui.mainCamera.transform.position - var_517_13.position).y, (manager.ui.mainCamera.transform.position - var_517_13.position).z)
				var_517_13.localEulerAngles.z = 0
				var_517_13.localEulerAngles.x = 0
				var_517_13.localEulerAngles = var_517_13.localEulerAngles
			end

			if arg_514_1.time_ >= 1.5 + var_517_14 and arg_514_1.time_ < 1.5 + var_517_14 + arg_517_0 then
				var_517_13.localPosition = Vector3.New(0, 100, 0)
				var_517_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_13.position).x, (manager.ui.mainCamera.transform.position - var_517_13.position).y, (manager.ui.mainCamera.transform.position - var_517_13.position).z)
				var_517_13.localEulerAngles.z = 0
				var_517_13.localEulerAngles.x = 0
				var_517_13.localEulerAngles = var_517_13.localEulerAngles
			end

			if 1 < arg_514_1.time_ and arg_514_1.time_ <= 1 + arg_517_0 then
				arg_514_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_fountain", "")
			end

			if 0.2 < arg_514_1.time_ and arg_514_1.time_ <= 0.2 + arg_517_0 then
				arg_514_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 1 < arg_514_1.time_ and arg_514_1.time_ <= 1 + arg_517_0 then
				arg_514_1:AudioAction("play", "music", "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_517_19 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if "" ~= "" then
					if arg_514_1.bgmTxt_.text ~= var_517_19 and arg_514_1.bgmTxt_.text ~= "" then
						if arg_514_1.bgmTxt2_.text ~= "" then
							arg_514_1.bgmTxt_.text = arg_514_1.bgmTxt2_.text
						end

						arg_514_1.bgmTxt2_.text = var_517_19

						arg_514_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_514_1.bgmTxt_.text = var_517_19
						arg_514_1.bgmTxt2_.text = var_517_19
					end

					if arg_514_1.bgmTimer then
						arg_514_1.bgmTimer:Stop()

						arg_514_1.bgmTimer = nil
					end

					if arg_514_1.settingData.show_music_name == 1 then
						arg_514_1.musicController:SetSelectedState("show")
						arg_514_1.musicAnimator_:Play("open", 0, 0)

						if arg_514_1.settingData.music_time ~= 0 then
							arg_514_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_514_1.settingData.music_time), function()
								if arg_514_1 == nil or isNil(arg_514_1.bgmTxt_) then
									return
								end

								arg_514_1.musicController:SetSelectedState("hide")
								arg_514_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_514_1.frameCnt_ <= 1 then
				arg_514_1.dialog_:SetActive(false)
			end

			local var_517_21 = 3.25
			local var_517_22 = 1.375

			if 3.25 < arg_514_1.time_ and arg_514_1.time_ <= var_517_21 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0

				arg_514_1.dialog_:SetActive(true)

				arg_514_1.dialogCg_.alpha = 0

				local var_517_23 = LeanTween.value(arg_514_1.dialog_, 0, 1, 0.3)

				var_517_23:setOnUpdate(LuaHelper.FloatAction(function(arg_519_0)
					arg_514_1.dialogCg_.alpha = arg_519_0
				end))
				var_517_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_514_1.dialog_)
					var_517_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_514_1.duration_ = arg_514_1.duration_ + 0.3

				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_24 = arg_514_1:FormatText(arg_514_1:GetWordFromCfg(1109511127).content)

				arg_514_1.text_.text = var_517_24

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_26 = 55 <= 0 and var_517_22 or var_517_22 * (utf8.len(var_517_24) / 55)

				if (55 <= 0 and var_517_22 or var_517_22 * (utf8.len(var_517_24) / 55)) > 0 and var_517_22 < var_517_26 then
					arg_514_1.talkMaxDuration = var_517_26
					var_517_21 = var_517_21 + 0.3

					if var_517_26 + var_517_21 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_26 + var_517_21
					end
				end

				arg_514_1.text_.text = var_517_24
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_27 = var_517_21 + 0.3
			local var_517_28 = math.max(var_517_22, arg_514_1.talkMaxDuration)

			if var_517_21 + 0.3 <= arg_514_1.time_ and arg_514_1.time_ < var_517_27 + var_517_28 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_27) / var_517_28

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_27 + var_517_28 and arg_514_1.time_ < var_517_27 + var_517_28 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play1109511128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1109511128
		arg_521_1.duration_ = 6.53

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1109511129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.9

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[1555].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_1 = arg_521_1:GetWordFromCfg(1109511128)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 36 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 36)

				if (36 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 36)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb")

						arg_521_1:RecordAudio("1109511128", var_524_6)
						arg_521_1:RecordAudio("1109511128", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511128", "story_v_side_new_1109511.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_7 and arg_521_1.time_ < 0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1109511129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1109511129
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1109511130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.65

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
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

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_1 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(1109511129).content)

				arg_525_1.text_.text = var_528_1

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_3 = 26 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 26)

				if (26 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 26)) > 0 and var_528_0 < var_528_3 then
					arg_525_1.talkMaxDuration = var_528_3

					if var_528_3 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_3 + 0
					end
				end

				arg_525_1.text_.text = var_528_1
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_4 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_4

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1109511130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1109511130
		arg_529_1.duration_ = 11.53

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1109511131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 1.45

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[1555].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_1 = arg_529_1:GetWordFromCfg(1109511130)
				local var_532_2 = arg_529_1:FormatText(var_532_1.content)

				arg_529_1.text_.text = var_532_2

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_4 = 58 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 58)

				if (58 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 58)) > 0 and var_532_0 < var_532_4 then
					arg_529_1.talkMaxDuration = var_532_4

					if var_532_4 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_4 + 0
					end
				end

				arg_529_1.text_.text = var_532_2
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb") ~= 0 then
					local var_532_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb") / 1000

					if var_532_5 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + 0
					end

					if var_532_1.prefab_name ~= "" and arg_529_1.actors_[var_532_1.prefab_name] ~= nil then
						local var_532_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_1.prefab_name].transform, "story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb")

						arg_529_1:RecordAudio("1109511130", var_532_6)
						arg_529_1:RecordAudio("1109511130", var_532_6)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511130", "story_v_side_new_1109511.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_7 and arg_529_1.time_ < 0 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1109511131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1109511131
		arg_533_1.duration_ = 6.73

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1109511132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.825

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[1555].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_1 = arg_533_1:GetWordFromCfg(1109511131)
				local var_536_2 = arg_533_1:FormatText(var_536_1.content)

				arg_533_1.text_.text = var_536_2

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_4 = 33 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 33)

				if (33 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 33)) > 0 and var_536_0 < var_536_4 then
					arg_533_1.talkMaxDuration = var_536_4

					if var_536_4 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_4 + 0
					end
				end

				arg_533_1.text_.text = var_536_2
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb") ~= 0 then
					local var_536_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb") / 1000

					if var_536_5 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + 0
					end

					if var_536_1.prefab_name ~= "" and arg_533_1.actors_[var_536_1.prefab_name] ~= nil then
						local var_536_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_1.prefab_name].transform, "story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb")

						arg_533_1:RecordAudio("1109511131", var_536_6)
						arg_533_1:RecordAudio("1109511131", var_536_6)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511131", "story_v_side_new_1109511.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_7 and arg_533_1.time_ < 0 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1109511132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1109511132
		arg_537_1.duration_ = 3.43

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1109511133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos10058ui_story = arg_537_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_540_0 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 then
				arg_537_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_537_1.time_ - 0) / var_540_0)
				arg_537_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["10058ui_story"].transform.position).z)
				arg_537_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["10058ui_story"].transform.localEulerAngles = arg_537_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 then
				arg_537_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_537_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["10058ui_story"].transform.position).z)
				arg_537_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["10058ui_story"].transform.localEulerAngles = arg_537_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_540_1 = arg_537_1.actors_["10058ui_story"]

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect10058ui_story == nil then
				arg_537_1.var_.characterEffect10058ui_story = var_540_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_2 and not isNil(var_540_1) then
				if arg_537_1.var_.characterEffect10058ui_story and not isNil(var_540_1) then
					arg_537_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= 0 + var_540_2 and arg_537_1.time_ < 0 + var_540_2 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect10058ui_story then
				arg_537_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_540_4 = 0
			local var_540_5 = 0.45

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_4 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_6 = arg_537_1:GetWordFromCfg(1109511132)
				local var_540_7 = arg_537_1:FormatText(var_540_6.content)

				arg_537_1.text_.text = var_540_7

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_9 = 18 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 18)

				if (18 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 18)) > 0 and var_540_5 < var_540_9 then
					arg_537_1.talkMaxDuration = var_540_9

					if var_540_9 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_9 + var_540_4
					end
				end

				arg_537_1.text_.text = var_540_7
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb") ~= 0 then
					local var_540_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb") / 1000

					if var_540_10 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_10 + var_540_4
					end

					if var_540_6.prefab_name ~= "" and arg_537_1.actors_[var_540_6.prefab_name] ~= nil then
						local var_540_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_6.prefab_name].transform, "story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb")

						arg_537_1:RecordAudio("1109511132", var_540_11)
						arg_537_1:RecordAudio("1109511132", var_540_11)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511132", "story_v_side_new_1109511.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_12 = math.max(var_540_5, arg_537_1.talkMaxDuration)

			if var_540_4 <= arg_537_1.time_ and arg_537_1.time_ < var_540_4 + var_540_12 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_4) / var_540_12

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_4 + var_540_12 and arg_537_1.time_ < var_540_4 + var_540_12 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
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

		arg_537_1:InitPlayNodeList()
	end,
	Play1109511133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1109511133
		arg_541_1.duration_ = 6.9

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1109511134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.925

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_1 = arg_541_1:GetWordFromCfg(1109511133)
				local var_544_2 = arg_541_1:FormatText(var_544_1.content)

				arg_541_1.text_.text = var_544_2

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 37 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 37)

				if (37 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 37)) > 0 and var_544_0 < var_544_4 then
					arg_541_1.talkMaxDuration = var_544_4

					if var_544_4 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_4 + 0
					end
				end

				arg_541_1.text_.text = var_544_2
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb") ~= 0 then
					local var_544_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb") / 1000

					if var_544_5 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + 0
					end

					if var_544_1.prefab_name ~= "" and arg_541_1.actors_[var_544_1.prefab_name] ~= nil then
						local var_544_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_1.prefab_name].transform, "story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb")

						arg_541_1:RecordAudio("1109511133", var_544_6)
						arg_541_1:RecordAudio("1109511133", var_544_6)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511133", "story_v_side_new_1109511.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1109511134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1109511134
		arg_545_1.duration_ = 3.87

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1109511135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["10058ui_story"]) and arg_545_1.var_.characterEffect10058ui_story == nil then
				arg_545_1.var_.characterEffect10058ui_story = arg_545_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_0 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["10058ui_story"]) then
				if arg_545_1.var_.characterEffect10058ui_story and not isNil(arg_545_1.actors_["10058ui_story"]) then
					arg_545_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_545_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_545_1.time_ - 0) / var_548_0)
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["10058ui_story"]) and arg_545_1.var_.characterEffect10058ui_story then
				arg_545_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_545_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_548_1 = 0
			local var_548_2 = 0.5

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[1555].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_3 = arg_545_1:GetWordFromCfg(1109511134)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_6 = 20 <= 0 and var_548_2 or var_548_2 * (utf8.len(var_548_4) / 20)

				if (20 <= 0 and var_548_2 or var_548_2 * (utf8.len(var_548_4) / 20)) > 0 and var_548_2 < var_548_6 then
					arg_545_1.talkMaxDuration = var_548_6

					if var_548_6 + var_548_1 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_6 + var_548_1
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb") ~= 0 then
					local var_548_7 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb") / 1000

					if var_548_7 + var_548_1 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_1
					end

					if var_548_3.prefab_name ~= "" and arg_545_1.actors_[var_548_3.prefab_name] ~= nil then
						local var_548_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_3.prefab_name].transform, "story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb")

						arg_545_1:RecordAudio("1109511134", var_548_8)
						arg_545_1:RecordAudio("1109511134", var_548_8)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511134", "story_v_side_new_1109511.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_9 = math.max(var_548_2, arg_545_1.talkMaxDuration)

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_9 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_1) / var_548_9

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_1 + var_548_9 and arg_545_1.time_ < var_548_1 + var_548_9 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1109511135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1109511135
		arg_549_1.duration_ = 5.9

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1109511136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.725

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[1555].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_1 = arg_549_1:GetWordFromCfg(1109511135)
				local var_552_2 = arg_549_1:FormatText(var_552_1.content)

				arg_549_1.text_.text = var_552_2

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 29 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 29)

				if (29 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 29)) > 0 and var_552_0 < var_552_4 then
					arg_549_1.talkMaxDuration = var_552_4

					if var_552_4 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_4 + 0
					end
				end

				arg_549_1.text_.text = var_552_2
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb") ~= 0 then
					local var_552_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb") / 1000

					if var_552_5 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + 0
					end

					if var_552_1.prefab_name ~= "" and arg_549_1.actors_[var_552_1.prefab_name] ~= nil then
						local var_552_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_1.prefab_name].transform, "story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb")

						arg_549_1:RecordAudio("1109511135", var_552_6)
						arg_549_1:RecordAudio("1109511135", var_552_6)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511135", "story_v_side_new_1109511.awb")
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
	Play1109511136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1109511136
		arg_553_1.duration_ = 6.07

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1109511137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["10058ui_story"]) and arg_553_1.var_.characterEffect10058ui_story == nil then
				arg_553_1.var_.characterEffect10058ui_story = arg_553_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["10058ui_story"]) then
				if arg_553_1.var_.characterEffect10058ui_story and not isNil(arg_553_1.actors_["10058ui_story"]) then
					arg_553_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["10058ui_story"]) and arg_553_1.var_.characterEffect10058ui_story then
				arg_553_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_556_2 = 0
			local var_556_3 = 0.85

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_2 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_4 = arg_553_1:GetWordFromCfg(1109511136)
				local var_556_5 = arg_553_1:FormatText(var_556_4.content)

				arg_553_1.text_.text = var_556_5

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_7 = 34 <= 0 and var_556_3 or var_556_3 * (utf8.len(var_556_5) / 34)

				if (34 <= 0 and var_556_3 or var_556_3 * (utf8.len(var_556_5) / 34)) > 0 and var_556_3 < var_556_7 then
					arg_553_1.talkMaxDuration = var_556_7

					if var_556_7 + var_556_2 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_7 + var_556_2
					end
				end

				arg_553_1.text_.text = var_556_5
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb") ~= 0 then
					local var_556_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb") / 1000

					if var_556_8 + var_556_2 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_8 + var_556_2
					end

					if var_556_4.prefab_name ~= "" and arg_553_1.actors_[var_556_4.prefab_name] ~= nil then
						local var_556_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_4.prefab_name].transform, "story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb")

						arg_553_1:RecordAudio("1109511136", var_556_9)
						arg_553_1:RecordAudio("1109511136", var_556_9)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511136", "story_v_side_new_1109511.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_10 = math.max(var_556_3, arg_553_1.talkMaxDuration)

			if var_556_2 <= arg_553_1.time_ and arg_553_1.time_ < var_556_2 + var_556_10 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_2) / var_556_10

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_2 + var_556_10 and arg_553_1.time_ < var_556_2 + var_556_10 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1109511137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1109511137
		arg_557_1.duration_ = 5.5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1109511138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["10058ui_story"]) and arg_557_1.var_.characterEffect10058ui_story == nil then
				arg_557_1.var_.characterEffect10058ui_story = arg_557_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["10058ui_story"]) then
				if arg_557_1.var_.characterEffect10058ui_story and not isNil(arg_557_1.actors_["10058ui_story"]) then
					arg_557_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_557_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_557_1.time_ - 0) / var_560_0)
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["10058ui_story"]) and arg_557_1.var_.characterEffect10058ui_story then
				arg_557_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_557_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_560_1 = 0
			local var_560_2 = 0.675

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[1555].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_3 = arg_557_1:GetWordFromCfg(1109511137)
				local var_560_4 = arg_557_1:FormatText(var_560_3.content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_6 = 27 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_4) / 27)

				if (27 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_4) / 27)) > 0 and var_560_2 < var_560_6 then
					arg_557_1.talkMaxDuration = var_560_6

					if var_560_6 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_6 + var_560_1
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb") ~= 0 then
					local var_560_7 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb") / 1000

					if var_560_7 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_1
					end

					if var_560_3.prefab_name ~= "" and arg_557_1.actors_[var_560_3.prefab_name] ~= nil then
						local var_560_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_3.prefab_name].transform, "story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb")

						arg_557_1:RecordAudio("1109511137", var_560_8)
						arg_557_1:RecordAudio("1109511137", var_560_8)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511137", "story_v_side_new_1109511.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_9 = math.max(var_560_2, arg_557_1.talkMaxDuration)

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_9 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_1) / var_560_9

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_1 + var_560_9 and arg_557_1.time_ < var_560_1 + var_560_9 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1109511138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1109511138
		arg_561_1.duration_ = 4.77

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1109511139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.65

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[1555].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_1 = arg_561_1:GetWordFromCfg(1109511138)
				local var_564_2 = arg_561_1:FormatText(var_564_1.content)

				arg_561_1.text_.text = var_564_2

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 26 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 26)

				if (26 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 26)) > 0 and var_564_0 < var_564_4 then
					arg_561_1.talkMaxDuration = var_564_4

					if var_564_4 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_4 + 0
					end
				end

				arg_561_1.text_.text = var_564_2
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb") ~= 0 then
					local var_564_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb") / 1000

					if var_564_5 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_5 + 0
					end

					if var_564_1.prefab_name ~= "" and arg_561_1.actors_[var_564_1.prefab_name] ~= nil then
						local var_564_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_1.prefab_name].transform, "story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb")

						arg_561_1:RecordAudio("1109511138", var_564_6)
						arg_561_1:RecordAudio("1109511138", var_564_6)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511138", "story_v_side_new_1109511.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_7 and arg_561_1.time_ < 0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1109511139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1109511139
		arg_565_1.duration_ = 9.07

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1109511140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["10058ui_story"]) and arg_565_1.var_.characterEffect10058ui_story == nil then
				arg_565_1.var_.characterEffect10058ui_story = arg_565_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["10058ui_story"]) then
				if arg_565_1.var_.characterEffect10058ui_story and not isNil(arg_565_1.actors_["10058ui_story"]) then
					arg_565_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["10058ui_story"]) and arg_565_1.var_.characterEffect10058ui_story then
				arg_565_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action427")
			end

			local var_568_2 = 0
			local var_568_3 = 0.925

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_2 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_4 = arg_565_1:GetWordFromCfg(1109511139)
				local var_568_5 = arg_565_1:FormatText(var_568_4.content)

				arg_565_1.text_.text = var_568_5

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_7 = 37 <= 0 and var_568_3 or var_568_3 * (utf8.len(var_568_5) / 37)

				if (37 <= 0 and var_568_3 or var_568_3 * (utf8.len(var_568_5) / 37)) > 0 and var_568_3 < var_568_7 then
					arg_565_1.talkMaxDuration = var_568_7

					if var_568_7 + var_568_2 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_2
					end
				end

				arg_565_1.text_.text = var_568_5
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb") ~= 0 then
					local var_568_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb") / 1000

					if var_568_8 + var_568_2 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_8 + var_568_2
					end

					if var_568_4.prefab_name ~= "" and arg_565_1.actors_[var_568_4.prefab_name] ~= nil then
						local var_568_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_4.prefab_name].transform, "story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb")

						arg_565_1:RecordAudio("1109511139", var_568_9)
						arg_565_1:RecordAudio("1109511139", var_568_9)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511139", "story_v_side_new_1109511.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_10 = math.max(var_568_3, arg_565_1.talkMaxDuration)

			if var_568_2 <= arg_565_1.time_ and arg_565_1.time_ < var_568_2 + var_568_10 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_2) / var_568_10

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_2 + var_568_10 and arg_565_1.time_ < var_568_2 + var_568_10 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1109511140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1109511140
		arg_569_1.duration_ = 7.92

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1109511141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 1.35 < arg_569_1.time_ and arg_569_1.time_ <= 1.35 + arg_572_0 then
				local var_572_0 = arg_569_1.bgs_.ST70

				arg_569_1.bgs_.ST70.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_572_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_572_1 = var_572_0:GetComponent("SpriteRenderer")

				if var_572_1 and var_572_1.sprite then
					local var_572_2 = 2 * (var_572_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_572_0.transform.localScale = Vector3.New(var_572_2 / var_572_1.sprite.bounds.size.y < var_572_2 * manager.ui.mainCameraCom_.aspect / var_572_1.sprite.bounds.size.x and var_572_2 * manager.ui.mainCameraCom_.aspect / var_572_1.sprite.bounds.size.x or var_572_2 / var_572_1.sprite.bounds.size.y, var_572_2 / var_572_1.sprite.bounds.size.y < var_572_2 * manager.ui.mainCameraCom_.aspect / var_572_1.sprite.bounds.size.x and var_572_2 * manager.ui.mainCameraCom_.aspect / var_572_1.sprite.bounds.size.x or var_572_2 / var_572_1.sprite.bounds.size.y, 0)
				end

				for iter_572_0, iter_572_1 in pairs(arg_569_1.bgs_) do
					if iter_572_0 ~= "ST70" then
						iter_572_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_572_3 = 0

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_3 + arg_572_0 then
				arg_569_1.allBtn_.enabled = false
			end

			if arg_569_1.time_ >= var_572_3 + 0.3 and arg_569_1.time_ < var_572_3 + 0.3 + arg_572_0 then
				arg_569_1.allBtn_.enabled = true
			end

			local var_572_4 = 0

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_4 + arg_572_0 then
				arg_569_1.mask_.enabled = true
				arg_569_1.mask_.raycastTarget = true

				arg_569_1:SetGaussion(false)
			end

			local var_572_5 = 1.35

			if var_572_4 <= arg_569_1.time_ and arg_569_1.time_ < var_572_4 + var_572_5 then
				local var_572_6 = Color.New(0, 0, 0)

				var_572_6.a = Mathf.Lerp(0, 1, (arg_569_1.time_ - var_572_4) / var_572_5)
				arg_569_1.mask_.color = var_572_6
			end

			if arg_569_1.time_ >= var_572_4 + var_572_5 and arg_569_1.time_ < var_572_4 + var_572_5 + arg_572_0 then
				local var_572_7 = Color.New(0, 0, 0)

				var_572_7.a = 1
				arg_569_1.mask_.color = var_572_7
			end

			local var_572_8 = 1.35

			if 1.35 < arg_569_1.time_ and arg_569_1.time_ <= var_572_8 + arg_572_0 then
				arg_569_1.mask_.enabled = true
				arg_569_1.mask_.raycastTarget = true

				arg_569_1:SetGaussion(false)
			end

			local var_572_9 = 2

			if var_572_8 <= arg_569_1.time_ and arg_569_1.time_ < var_572_8 + var_572_9 then
				local var_572_10 = Color.New(0, 0, 0)

				var_572_10.a = Mathf.Lerp(1, 0, (arg_569_1.time_ - var_572_8) / var_572_9)
				arg_569_1.mask_.color = var_572_10
			end

			if arg_569_1.time_ >= var_572_8 + var_572_9 and arg_569_1.time_ < var_572_8 + var_572_9 + arg_572_0 then
				local var_572_11 = Color.New(0, 0, 0)

				arg_569_1.mask_.enabled = false
				var_572_11.a = 0
				arg_569_1.mask_.color = var_572_11
			end

			local var_572_12 = arg_569_1.actors_["10058ui_story"]

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(var_572_12) and arg_569_1.var_.characterEffect10058ui_story == nil then
				arg_569_1.var_.characterEffect10058ui_story = var_572_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_13 = 0.200000002980232

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_13 and not isNil(var_572_12) then
				if arg_569_1.var_.characterEffect10058ui_story and not isNil(var_572_12) then
					arg_569_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_569_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_569_1.time_ - 0) / var_572_13)
				end
			end

			if arg_569_1.time_ >= 0 + var_572_13 and arg_569_1.time_ < 0 + var_572_13 + arg_572_0 and not isNil(var_572_12) and arg_569_1.var_.characterEffect10058ui_story then
				arg_569_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_569_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_572_14 = arg_569_1.actors_["10058ui_story"].transform

			if 1.35 < arg_569_1.time_ and arg_569_1.time_ <= 1.35 + arg_572_0 then
				arg_569_1.var_.moveOldPos10058ui_story = var_572_14.localPosition
			end

			local var_572_15 = 0.001

			if 1.35 <= arg_569_1.time_ and arg_569_1.time_ < 1.35 + var_572_15 then
				var_572_14.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_569_1.time_ - 1.35) / var_572_15)
				var_572_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_572_14.position).x, (manager.ui.mainCamera.transform.position - var_572_14.position).y, (manager.ui.mainCamera.transform.position - var_572_14.position).z)
				var_572_14.localEulerAngles.z = 0
				var_572_14.localEulerAngles.x = 0
				var_572_14.localEulerAngles = var_572_14.localEulerAngles
			end

			if arg_569_1.time_ >= 1.35 + var_572_15 and arg_569_1.time_ < 1.35 + var_572_15 + arg_572_0 then
				var_572_14.localPosition = Vector3.New(0, 100, 0)
				var_572_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_572_14.position).x, (manager.ui.mainCamera.transform.position - var_572_14.position).y, (manager.ui.mainCamera.transform.position - var_572_14.position).z)
				var_572_14.localEulerAngles.z = 0
				var_572_14.localEulerAngles.x = 0
				var_572_14.localEulerAngles = var_572_14.localEulerAngles
			end

			if arg_569_1.frameCnt_ <= 1 then
				arg_569_1.dialog_:SetActive(false)
			end

			local var_572_16 = 2.91666666666667
			local var_572_17 = 1

			if 2.91666666666667 < arg_569_1.time_ and arg_569_1.time_ <= var_572_16 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0

				arg_569_1.dialog_:SetActive(true)

				arg_569_1.dialogCg_.alpha = 0

				local var_572_18 = LeanTween.value(arg_569_1.dialog_, 0, 1, 0.3)

				var_572_18:setOnUpdate(LuaHelper.FloatAction(function(arg_573_0)
					arg_569_1.dialogCg_.alpha = arg_573_0
				end))
				var_572_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_569_1.dialog_)
					var_572_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_569_1.duration_ = arg_569_1.duration_ + 0.3

				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_19 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(1109511140).content)

				arg_569_1.text_.text = var_572_19

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_21 = 40 <= 0 and var_572_17 or var_572_17 * (utf8.len(var_572_19) / 40)

				if (40 <= 0 and var_572_17 or var_572_17 * (utf8.len(var_572_19) / 40)) > 0 and var_572_17 < var_572_21 then
					arg_569_1.talkMaxDuration = var_572_21
					var_572_16 = var_572_16 + 0.3

					if var_572_21 + var_572_16 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_21 + var_572_16
					end
				end

				arg_569_1.text_.text = var_572_19
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_22 = var_572_16 + 0.3
			local var_572_23 = math.max(var_572_17, arg_569_1.talkMaxDuration)

			if var_572_16 + 0.3 <= arg_569_1.time_ and arg_569_1.time_ < var_572_22 + var_572_23 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_22) / var_572_23

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_22 + var_572_23 and arg_569_1.time_ < var_572_22 + var_572_23 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play1109511141 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1109511141
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1109511142(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0.775

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_1 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(1109511141).content)

				arg_575_1.text_.text = var_578_1

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_3 = 31 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 31)

				if (31 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_1) / 31)) > 0 and var_578_0 < var_578_3 then
					arg_575_1.talkMaxDuration = var_578_3

					if var_578_3 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_3 + 0
					end
				end

				arg_575_1.text_.text = var_578_1
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_4 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_4 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_4

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_4 and arg_575_1.time_ < 0 + var_578_4 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1109511142 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1109511142
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1109511143(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 1.1

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_1 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(1109511142).content)

				arg_579_1.text_.text = var_582_1

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_3 = 44 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_1) / 44)

				if (44 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_1) / 44)) > 0 and var_582_0 < var_582_3 then
					arg_579_1.talkMaxDuration = var_582_3

					if var_582_3 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_3 + 0
					end
				end

				arg_579_1.text_.text = var_582_1
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_4 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_4 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_4

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_4 and arg_579_1.time_ < 0 + var_582_4 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1109511143 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1109511143
		arg_583_1.duration_ = 4.23

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1109511144(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.425

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_1 = arg_583_1:GetWordFromCfg(1109511143)
				local var_586_2 = arg_583_1:FormatText(var_586_1.content)

				arg_583_1.text_.text = var_586_2

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_4 = 17 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 17)

				if (17 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 17)) > 0 and var_586_0 < var_586_4 then
					arg_583_1.talkMaxDuration = var_586_4

					if var_586_4 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_4 + 0
					end
				end

				arg_583_1.text_.text = var_586_2
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb") ~= 0 then
					local var_586_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb") / 1000

					if var_586_5 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + 0
					end

					if var_586_1.prefab_name ~= "" and arg_583_1.actors_[var_586_1.prefab_name] ~= nil then
						local var_586_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_1.prefab_name].transform, "story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb")

						arg_583_1:RecordAudio("1109511143", var_586_6)
						arg_583_1:RecordAudio("1109511143", var_586_6)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511143", "story_v_side_new_1109511.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_7 and arg_583_1.time_ < 0 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1109511144 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1109511144
		arg_587_1.duration_ = 6.4

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1109511145(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["10058ui_story"]) and arg_587_1.var_.characterEffect10058ui_story == nil then
				arg_587_1.var_.characterEffect10058ui_story = arg_587_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_0 = 0.200000002980232

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["10058ui_story"]) then
				if arg_587_1.var_.characterEffect10058ui_story and not isNil(arg_587_1.actors_["10058ui_story"]) then
					arg_587_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["10058ui_story"]) and arg_587_1.var_.characterEffect10058ui_story then
				arg_587_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_590_2 = arg_587_1.actors_["10058ui_story"].transform

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPos10058ui_story = var_590_2.localPosition
			end

			local var_590_3 = 0.001

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_3 then
				var_590_2.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_587_1.time_ - 0) / var_590_3)
				var_590_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_590_2.position).x, (manager.ui.mainCamera.transform.position - var_590_2.position).y, (manager.ui.mainCamera.transform.position - var_590_2.position).z)
				var_590_2.localEulerAngles.z = 0
				var_590_2.localEulerAngles.x = 0
				var_590_2.localEulerAngles = var_590_2.localEulerAngles
			end

			if arg_587_1.time_ >= 0 + var_590_3 and arg_587_1.time_ < 0 + var_590_3 + arg_590_0 then
				var_590_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_590_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_590_2.position).x, (manager.ui.mainCamera.transform.position - var_590_2.position).y, (manager.ui.mainCamera.transform.position - var_590_2.position).z)
				var_590_2.localEulerAngles.z = 0
				var_590_2.localEulerAngles.x = 0
				var_590_2.localEulerAngles = var_590_2.localEulerAngles
			end

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_590_4 = 0
			local var_590_5 = 0.675

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_4 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_6 = arg_587_1:GetWordFromCfg(1109511144)
				local var_590_7 = arg_587_1:FormatText(var_590_6.content)

				arg_587_1.text_.text = var_590_7

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_9 = 27 <= 0 and var_590_5 or var_590_5 * (utf8.len(var_590_7) / 27)

				if (27 <= 0 and var_590_5 or var_590_5 * (utf8.len(var_590_7) / 27)) > 0 and var_590_5 < var_590_9 then
					arg_587_1.talkMaxDuration = var_590_9

					if var_590_9 + var_590_4 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_9 + var_590_4
					end
				end

				arg_587_1.text_.text = var_590_7
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb") ~= 0 then
					local var_590_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb") / 1000

					if var_590_10 + var_590_4 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_10 + var_590_4
					end

					if var_590_6.prefab_name ~= "" and arg_587_1.actors_[var_590_6.prefab_name] ~= nil then
						local var_590_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_6.prefab_name].transform, "story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb")

						arg_587_1:RecordAudio("1109511144", var_590_11)
						arg_587_1:RecordAudio("1109511144", var_590_11)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511144", "story_v_side_new_1109511.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_12 = math.max(var_590_5, arg_587_1.talkMaxDuration)

			if var_590_4 <= arg_587_1.time_ and arg_587_1.time_ < var_590_4 + var_590_12 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_4) / var_590_12

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_4 + var_590_12 and arg_587_1.time_ < var_590_4 + var_590_12 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
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

		arg_587_1:InitPlayNodeList()
	end,
	Play1109511145 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1109511145
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1109511146(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(arg_591_1.actors_["10058ui_story"]) and arg_591_1.var_.characterEffect10058ui_story == nil then
				arg_591_1.var_.characterEffect10058ui_story = arg_591_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_0 = 0.200000002980232

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_0 and not isNil(arg_591_1.actors_["10058ui_story"]) then
				if arg_591_1.var_.characterEffect10058ui_story and not isNil(arg_591_1.actors_["10058ui_story"]) then
					arg_591_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_591_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_591_1.time_ - 0) / var_594_0)
				end
			end

			if arg_591_1.time_ >= 0 + var_594_0 and arg_591_1.time_ < 0 + var_594_0 + arg_594_0 and not isNil(arg_591_1.actors_["10058ui_story"]) and arg_591_1.var_.characterEffect10058ui_story then
				arg_591_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_591_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_594_1 = 0
			local var_594_2 = 1.1

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, false)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_3 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(1109511145).content)

				arg_591_1.text_.text = var_594_3

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 44 <= 0 and var_594_2 or var_594_2 * (utf8.len(var_594_3) / 44)

				if (44 <= 0 and var_594_2 or var_594_2 * (utf8.len(var_594_3) / 44)) > 0 and var_594_2 < var_594_5 then
					arg_591_1.talkMaxDuration = var_594_5

					if var_594_5 + var_594_1 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_5 + var_594_1
					end
				end

				arg_591_1.text_.text = var_594_3
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_6 = math.max(var_594_2, arg_591_1.talkMaxDuration)

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_6 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_1) / var_594_6

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_1 + var_594_6 and arg_591_1.time_ < var_594_1 + var_594_6 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1109511146 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1109511146
		arg_595_1.duration_ = 7.03

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1109511147(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.625

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_1 = arg_595_1:GetWordFromCfg(1109511146)
				local var_598_2 = arg_595_1:FormatText(var_598_1.content)

				arg_595_1.text_.text = var_598_2

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 25 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 25)

				if (25 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 25)) > 0 and var_598_0 < var_598_4 then
					arg_595_1.talkMaxDuration = var_598_4

					if var_598_4 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_4 + 0
					end
				end

				arg_595_1.text_.text = var_598_2
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb") ~= 0 then
					local var_598_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb") / 1000

					if var_598_5 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_5 + 0
					end

					if var_598_1.prefab_name ~= "" and arg_595_1.actors_[var_598_1.prefab_name] ~= nil then
						local var_598_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_1.prefab_name].transform, "story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb")

						arg_595_1:RecordAudio("1109511146", var_598_6)
						arg_595_1:RecordAudio("1109511146", var_598_6)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511146", "story_v_side_new_1109511.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_7 and arg_595_1.time_ < 0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1109511147 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1109511147
		arg_599_1.duration_ = 7.4

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1109511148(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(arg_599_1.actors_["10058ui_story"]) and arg_599_1.var_.characterEffect10058ui_story == nil then
				arg_599_1.var_.characterEffect10058ui_story = arg_599_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_0 = 0.200000002980232

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 and not isNil(arg_599_1.actors_["10058ui_story"]) then
				if arg_599_1.var_.characterEffect10058ui_story and not isNil(arg_599_1.actors_["10058ui_story"]) then
					arg_599_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 and not isNil(arg_599_1.actors_["10058ui_story"]) and arg_599_1.var_.characterEffect10058ui_story then
				arg_599_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_602_2 = 0
			local var_602_3 = 0.725

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_2 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_4 = arg_599_1:GetWordFromCfg(1109511147)
				local var_602_5 = arg_599_1:FormatText(var_602_4.content)

				arg_599_1.text_.text = var_602_5

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_7 = 29 <= 0 and var_602_3 or var_602_3 * (utf8.len(var_602_5) / 29)

				if (29 <= 0 and var_602_3 or var_602_3 * (utf8.len(var_602_5) / 29)) > 0 and var_602_3 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_2 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_2
					end
				end

				arg_599_1.text_.text = var_602_5
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb") / 1000

					if var_602_8 + var_602_2 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_2
					end

					if var_602_4.prefab_name ~= "" and arg_599_1.actors_[var_602_4.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_4.prefab_name].transform, "story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb")

						arg_599_1:RecordAudio("1109511147", var_602_9)
						arg_599_1:RecordAudio("1109511147", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511147", "story_v_side_new_1109511.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_3, arg_599_1.talkMaxDuration)

			if var_602_2 <= arg_599_1.time_ and arg_599_1.time_ < var_602_2 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_2) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_2 + var_602_10 and arg_599_1.time_ < var_602_2 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1109511148 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1109511148
		arg_603_1.duration_ = 1.23

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1109511149(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["10058ui_story"]) and arg_603_1.var_.characterEffect10058ui_story == nil then
				arg_603_1.var_.characterEffect10058ui_story = arg_603_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_0 = 0.200000002980232

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 and not isNil(arg_603_1.actors_["10058ui_story"]) then
				if arg_603_1.var_.characterEffect10058ui_story and not isNil(arg_603_1.actors_["10058ui_story"]) then
					arg_603_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_603_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_603_1.time_ - 0) / var_606_0)
				end
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 and not isNil(arg_603_1.actors_["10058ui_story"]) and arg_603_1.var_.characterEffect10058ui_story then
				arg_603_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_603_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_606_1 = 0
			local var_606_2 = 0.075

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_3 = arg_603_1:GetWordFromCfg(1109511148)
				local var_606_4 = arg_603_1:FormatText(var_606_3.content)

				arg_603_1.text_.text = var_606_4

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_6 = 3 <= 0 and var_606_2 or var_606_2 * (utf8.len(var_606_4) / 3)

				if (3 <= 0 and var_606_2 or var_606_2 * (utf8.len(var_606_4) / 3)) > 0 and var_606_2 < var_606_6 then
					arg_603_1.talkMaxDuration = var_606_6

					if var_606_6 + var_606_1 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_6 + var_606_1
					end
				end

				arg_603_1.text_.text = var_606_4
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb") ~= 0 then
					local var_606_7 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb") / 1000

					if var_606_7 + var_606_1 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_1
					end

					if var_606_3.prefab_name ~= "" and arg_603_1.actors_[var_606_3.prefab_name] ~= nil then
						local var_606_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_3.prefab_name].transform, "story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb")

						arg_603_1:RecordAudio("1109511148", var_606_8)
						arg_603_1:RecordAudio("1109511148", var_606_8)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511148", "story_v_side_new_1109511.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_9 = math.max(var_606_2, arg_603_1.talkMaxDuration)

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_9 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_1) / var_606_9

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_1 + var_606_9 and arg_603_1.time_ < var_606_1 + var_606_9 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1109511149 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1109511149
		arg_607_1.duration_ = 4.8

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1109511150(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(arg_607_1.actors_["10058ui_story"]) and arg_607_1.var_.characterEffect10058ui_story == nil then
				arg_607_1.var_.characterEffect10058ui_story = arg_607_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_0 = 0.200000002980232

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 and not isNil(arg_607_1.actors_["10058ui_story"]) then
				if arg_607_1.var_.characterEffect10058ui_story and not isNil(arg_607_1.actors_["10058ui_story"]) then
					arg_607_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 and not isNil(arg_607_1.actors_["10058ui_story"]) and arg_607_1.var_.characterEffect10058ui_story then
				arg_607_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_610_2 = 0
			local var_610_3 = 0.35

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_2 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_4 = arg_607_1:GetWordFromCfg(1109511149)
				local var_610_5 = arg_607_1:FormatText(var_610_4.content)

				arg_607_1.text_.text = var_610_5

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_7 = 14 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_5) / 14)

				if (14 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_5) / 14)) > 0 and var_610_3 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_2
					end
				end

				arg_607_1.text_.text = var_610_5
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb") ~= 0 then
					local var_610_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb") / 1000

					if var_610_8 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_8 + var_610_2
					end

					if var_610_4.prefab_name ~= "" and arg_607_1.actors_[var_610_4.prefab_name] ~= nil then
						local var_610_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_4.prefab_name].transform, "story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb")

						arg_607_1:RecordAudio("1109511149", var_610_9)
						arg_607_1:RecordAudio("1109511149", var_610_9)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511149", "story_v_side_new_1109511.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_10 = math.max(var_610_3, arg_607_1.talkMaxDuration)

			if var_610_2 <= arg_607_1.time_ and arg_607_1.time_ < var_610_2 + var_610_10 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_2) / var_610_10

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_2 + var_610_10 and arg_607_1.time_ < var_610_2 + var_610_10 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1109511150 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1109511150
		arg_611_1.duration_ = 6.83

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1109511151(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["10058ui_story"]) and arg_611_1.var_.characterEffect10058ui_story == nil then
				arg_611_1.var_.characterEffect10058ui_story = arg_611_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["10058ui_story"]) then
				if arg_611_1.var_.characterEffect10058ui_story and not isNil(arg_611_1.actors_["10058ui_story"]) then
					arg_611_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_611_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_611_1.time_ - 0) / var_614_0)
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["10058ui_story"]) and arg_611_1.var_.characterEffect10058ui_story then
				arg_611_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_611_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_614_1 = 0
			local var_614_2 = 0.625

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_3 = arg_611_1:GetWordFromCfg(1109511150)
				local var_614_4 = arg_611_1:FormatText(var_614_3.content)

				arg_611_1.text_.text = var_614_4

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_6 = 25 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_4) / 25)

				if (25 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_4) / 25)) > 0 and var_614_2 < var_614_6 then
					arg_611_1.talkMaxDuration = var_614_6

					if var_614_6 + var_614_1 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_6 + var_614_1
					end
				end

				arg_611_1.text_.text = var_614_4
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb") ~= 0 then
					local var_614_7 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb") / 1000

					if var_614_7 + var_614_1 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_7 + var_614_1
					end

					if var_614_3.prefab_name ~= "" and arg_611_1.actors_[var_614_3.prefab_name] ~= nil then
						local var_614_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_3.prefab_name].transform, "story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb")

						arg_611_1:RecordAudio("1109511150", var_614_8)
						arg_611_1:RecordAudio("1109511150", var_614_8)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511150", "story_v_side_new_1109511.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_9 = math.max(var_614_2, arg_611_1.talkMaxDuration)

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_9 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_1) / var_614_9

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_1 + var_614_9 and arg_611_1.time_ < var_614_1 + var_614_9 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1109511151 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1109511151
		arg_615_1.duration_ = 5.23

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1109511152(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0.325

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_1 = arg_615_1:GetWordFromCfg(1109511151)
				local var_618_2 = arg_615_1:FormatText(var_618_1.content)

				arg_615_1.text_.text = var_618_2

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_4 = 13 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_2) / 13)

				if (13 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_2) / 13)) > 0 and var_618_0 < var_618_4 then
					arg_615_1.talkMaxDuration = var_618_4

					if var_618_4 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_4 + 0
					end
				end

				arg_615_1.text_.text = var_618_2
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb") ~= 0 then
					local var_618_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb") / 1000

					if var_618_5 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_5 + 0
					end

					if var_618_1.prefab_name ~= "" and arg_615_1.actors_[var_618_1.prefab_name] ~= nil then
						local var_618_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_1.prefab_name].transform, "story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb")

						arg_615_1:RecordAudio("1109511151", var_618_6)
						arg_615_1:RecordAudio("1109511151", var_618_6)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511151", "story_v_side_new_1109511.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_7 = math.max(var_618_0, arg_615_1.talkMaxDuration)

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_7 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - 0) / var_618_7

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= 0 + var_618_7 and arg_615_1.time_ < 0 + var_618_7 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1109511152 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1109511152
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1109511153(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos10058ui_story = arg_619_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_622_0 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 then
				arg_619_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_619_1.time_ - 0) / var_622_0)
				arg_619_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).z)
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles = arg_619_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 then
				arg_619_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_619_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["10058ui_story"].transform.position).z)
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["10058ui_story"].transform.localEulerAngles = arg_619_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_622_1 = 0
			local var_622_2 = 0.775

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_3 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(1109511152).content)

				arg_619_1.text_.text = var_622_3

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_5 = 31 <= 0 and var_622_2 or var_622_2 * (utf8.len(var_622_3) / 31)

				if (31 <= 0 and var_622_2 or var_622_2 * (utf8.len(var_622_3) / 31)) > 0 and var_622_2 < var_622_5 then
					arg_619_1.talkMaxDuration = var_622_5

					if var_622_5 + var_622_1 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_5 + var_622_1
					end
				end

				arg_619_1.text_.text = var_622_3
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_6 = math.max(var_622_2, arg_619_1.talkMaxDuration)

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_6 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_1) / var_622_6

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_1 + var_622_6 and arg_619_1.time_ < var_622_1 + var_622_6 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
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

		arg_619_1:InitPlayNodeList()
	end,
	Play1109511153 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1109511153
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1109511154(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = 0.875

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, true)
				arg_623_1.iconController_:SetSelectedState("hero")

				arg_623_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_623_1.callingController_:SetSelectedState("normal")

				arg_623_1.keyicon_.color = Color.New(1, 1, 1)
				arg_623_1.icon_.color = Color.New(1, 1, 1)

				local var_626_1 = arg_623_1:FormatText(arg_623_1:GetWordFromCfg(1109511153).content)

				arg_623_1.text_.text = var_626_1

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_3 = 35 <= 0 and var_626_0 or var_626_0 * (utf8.len(var_626_1) / 35)

				if (35 <= 0 and var_626_0 or var_626_0 * (utf8.len(var_626_1) / 35)) > 0 and var_626_0 < var_626_3 then
					arg_623_1.talkMaxDuration = var_626_3

					if var_626_3 + 0 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_3 + 0
					end
				end

				arg_623_1.text_.text = var_626_1
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_4 = math.max(var_626_0, arg_623_1.talkMaxDuration)

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_4 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - 0) / var_626_4

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= 0 + var_626_4 and arg_623_1.time_ < 0 + var_626_4 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1109511154 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1109511154
		arg_627_1.duration_ = 4.63

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1109511155(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0.45

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_1 = arg_627_1:GetWordFromCfg(1109511154)
				local var_630_2 = arg_627_1:FormatText(var_630_1.content)

				arg_627_1.text_.text = var_630_2

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_4 = 18 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_2) / 18)

				if (18 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_2) / 18)) > 0 and var_630_0 < var_630_4 then
					arg_627_1.talkMaxDuration = var_630_4

					if var_630_4 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_4 + 0
					end
				end

				arg_627_1.text_.text = var_630_2
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb") ~= 0 then
					local var_630_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb") / 1000

					if var_630_5 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_5 + 0
					end

					if var_630_1.prefab_name ~= "" and arg_627_1.actors_[var_630_1.prefab_name] ~= nil then
						local var_630_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_1.prefab_name].transform, "story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb")

						arg_627_1:RecordAudio("1109511154", var_630_6)
						arg_627_1:RecordAudio("1109511154", var_630_6)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511154", "story_v_side_new_1109511.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_7 = math.max(var_630_0, arg_627_1.talkMaxDuration)

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_7 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - 0) / var_630_7

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= 0 + var_630_7 and arg_627_1.time_ < 0 + var_630_7 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1109511155 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1109511155
		arg_631_1.duration_ = 6.03

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1109511156(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.var_.moveOldPos10058ui_story = arg_631_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_634_0 = 0.001

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 then
				arg_631_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_631_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_631_1.time_ - 0) / var_634_0)
				arg_631_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_631_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_631_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_631_1.actors_["10058ui_story"].transform.position).z)
				arg_631_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_631_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_631_1.actors_["10058ui_story"].transform.localEulerAngles = arg_631_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 then
				arg_631_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_631_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_631_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_631_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_631_1.actors_["10058ui_story"].transform.position).z)
				arg_631_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_631_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_631_1.actors_["10058ui_story"].transform.localEulerAngles = arg_631_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_634_1 = arg_631_1.actors_["10058ui_story"]

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(var_634_1) and arg_631_1.var_.characterEffect10058ui_story == nil then
				arg_631_1.var_.characterEffect10058ui_story = var_634_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.200000002980232

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_2 and not isNil(var_634_1) then
				if arg_631_1.var_.characterEffect10058ui_story and not isNil(var_634_1) then
					arg_631_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= 0 + var_634_2 and arg_631_1.time_ < 0 + var_634_2 + arg_634_0 and not isNil(var_634_1) and arg_631_1.var_.characterEffect10058ui_story then
				arg_631_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_634_4 = 0
			local var_634_5 = 0.6

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_4 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_6 = arg_631_1:GetWordFromCfg(1109511155)
				local var_634_7 = arg_631_1:FormatText(var_634_6.content)

				arg_631_1.text_.text = var_634_7

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_9 = 24 <= 0 and var_634_5 or var_634_5 * (utf8.len(var_634_7) / 24)

				if (24 <= 0 and var_634_5 or var_634_5 * (utf8.len(var_634_7) / 24)) > 0 and var_634_5 < var_634_9 then
					arg_631_1.talkMaxDuration = var_634_9

					if var_634_9 + var_634_4 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_9 + var_634_4
					end
				end

				arg_631_1.text_.text = var_634_7
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb") ~= 0 then
					local var_634_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb") / 1000

					if var_634_10 + var_634_4 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_10 + var_634_4
					end

					if var_634_6.prefab_name ~= "" and arg_631_1.actors_[var_634_6.prefab_name] ~= nil then
						local var_634_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_6.prefab_name].transform, "story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb")

						arg_631_1:RecordAudio("1109511155", var_634_11)
						arg_631_1:RecordAudio("1109511155", var_634_11)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511155", "story_v_side_new_1109511.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_12 = math.max(var_634_5, arg_631_1.talkMaxDuration)

			if var_634_4 <= arg_631_1.time_ and arg_631_1.time_ < var_634_4 + var_634_12 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_4) / var_634_12

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_4 + var_634_12 and arg_631_1.time_ < var_634_4 + var_634_12 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {
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

		arg_631_1:InitPlayNodeList()
	end,
	Play1109511156 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1109511156
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1109511157(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(arg_635_1.actors_["10058ui_story"]) and arg_635_1.var_.characterEffect10058ui_story == nil then
				arg_635_1.var_.characterEffect10058ui_story = arg_635_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_0 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 and not isNil(arg_635_1.actors_["10058ui_story"]) then
				if arg_635_1.var_.characterEffect10058ui_story and not isNil(arg_635_1.actors_["10058ui_story"]) then
					arg_635_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_635_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_635_1.time_ - 0) / var_638_0)
				end
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 and not isNil(arg_635_1.actors_["10058ui_story"]) and arg_635_1.var_.characterEffect10058ui_story then
				arg_635_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_635_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_638_1 = 0
			local var_638_2 = 0.825

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_3 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(1109511156).content)

				arg_635_1.text_.text = var_638_3

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_5 = 33 <= 0 and var_638_2 or var_638_2 * (utf8.len(var_638_3) / 33)

				if (33 <= 0 and var_638_2 or var_638_2 * (utf8.len(var_638_3) / 33)) > 0 and var_638_2 < var_638_5 then
					arg_635_1.talkMaxDuration = var_638_5

					if var_638_5 + var_638_1 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_5 + var_638_1
					end
				end

				arg_635_1.text_.text = var_638_3
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_6 = math.max(var_638_2, arg_635_1.talkMaxDuration)

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_6 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_1) / var_638_6

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_1 + var_638_6 and arg_635_1.time_ < var_638_1 + var_638_6 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1109511157 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1109511157
		arg_639_1.duration_ = 6.63

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1109511158(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(arg_639_1.actors_["10058ui_story"]) and arg_639_1.var_.characterEffect10058ui_story == nil then
				arg_639_1.var_.characterEffect10058ui_story = arg_639_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_0 = 0.200000002980232

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 and not isNil(arg_639_1.actors_["10058ui_story"]) then
				if arg_639_1.var_.characterEffect10058ui_story and not isNil(arg_639_1.actors_["10058ui_story"]) then
					arg_639_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 and not isNil(arg_639_1.actors_["10058ui_story"]) and arg_639_1.var_.characterEffect10058ui_story then
				arg_639_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_642_2 = 0
			local var_642_3 = 0.775

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_2 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_4 = arg_639_1:GetWordFromCfg(1109511157)
				local var_642_5 = arg_639_1:FormatText(var_642_4.content)

				arg_639_1.text_.text = var_642_5

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_7 = 31 <= 0 and var_642_3 or var_642_3 * (utf8.len(var_642_5) / 31)

				if (31 <= 0 and var_642_3 or var_642_3 * (utf8.len(var_642_5) / 31)) > 0 and var_642_3 < var_642_7 then
					arg_639_1.talkMaxDuration = var_642_7

					if var_642_7 + var_642_2 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_7 + var_642_2
					end
				end

				arg_639_1.text_.text = var_642_5
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb") ~= 0 then
					local var_642_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb") / 1000

					if var_642_8 + var_642_2 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_8 + var_642_2
					end

					if var_642_4.prefab_name ~= "" and arg_639_1.actors_[var_642_4.prefab_name] ~= nil then
						local var_642_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_4.prefab_name].transform, "story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb")

						arg_639_1:RecordAudio("1109511157", var_642_9)
						arg_639_1:RecordAudio("1109511157", var_642_9)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511157", "story_v_side_new_1109511.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_10 = math.max(var_642_3, arg_639_1.talkMaxDuration)

			if var_642_2 <= arg_639_1.time_ and arg_639_1.time_ < var_642_2 + var_642_10 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_2) / var_642_10

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_2 + var_642_10 and arg_639_1.time_ < var_642_2 + var_642_10 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1109511158 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1109511158
		arg_643_1.duration_ = 8.8

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1109511159(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 1

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_1 = arg_643_1:GetWordFromCfg(1109511158)
				local var_646_2 = arg_643_1:FormatText(var_646_1.content)

				arg_643_1.text_.text = var_646_2

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_4 = 40 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_2) / 40)

				if (40 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_2) / 40)) > 0 and var_646_0 < var_646_4 then
					arg_643_1.talkMaxDuration = var_646_4

					if var_646_4 + 0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_4 + 0
					end
				end

				arg_643_1.text_.text = var_646_2
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb") ~= 0 then
					local var_646_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb") / 1000

					if var_646_5 + 0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_5 + 0
					end

					if var_646_1.prefab_name ~= "" and arg_643_1.actors_[var_646_1.prefab_name] ~= nil then
						local var_646_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_1.prefab_name].transform, "story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb")

						arg_643_1:RecordAudio("1109511158", var_646_6)
						arg_643_1:RecordAudio("1109511158", var_646_6)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511158", "story_v_side_new_1109511.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_7 = math.max(var_646_0, arg_643_1.talkMaxDuration)

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_7 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - 0) / var_646_7

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= 0 + var_646_7 and arg_643_1.time_ < 0 + var_646_7 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play1109511159 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1109511159
		arg_647_1.duration_ = 6.43

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1109511160(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0.6

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_1 = arg_647_1:GetWordFromCfg(1109511159)
				local var_650_2 = arg_647_1:FormatText(var_650_1.content)

				arg_647_1.text_.text = var_650_2

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_4 = 24 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 24)

				if (24 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 24)) > 0 and var_650_0 < var_650_4 then
					arg_647_1.talkMaxDuration = var_650_4

					if var_650_4 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_4 + 0
					end
				end

				arg_647_1.text_.text = var_650_2
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb") ~= 0 then
					local var_650_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb") / 1000

					if var_650_5 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_5 + 0
					end

					if var_650_1.prefab_name ~= "" and arg_647_1.actors_[var_650_1.prefab_name] ~= nil then
						local var_650_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_1.prefab_name].transform, "story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb")

						arg_647_1:RecordAudio("1109511159", var_650_6)
						arg_647_1:RecordAudio("1109511159", var_650_6)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511159", "story_v_side_new_1109511.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_7 = math.max(var_650_0, arg_647_1.talkMaxDuration)

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_7 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - 0) / var_650_7

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= 0 + var_650_7 and arg_647_1.time_ < 0 + var_650_7 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play1109511160 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1109511160
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1109511161(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 and not isNil(arg_651_1.actors_["10058ui_story"]) and arg_651_1.var_.characterEffect10058ui_story == nil then
				arg_651_1.var_.characterEffect10058ui_story = arg_651_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_0 = 0.200000002980232

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_0 and not isNil(arg_651_1.actors_["10058ui_story"]) then
				if arg_651_1.var_.characterEffect10058ui_story and not isNil(arg_651_1.actors_["10058ui_story"]) then
					arg_651_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_651_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_651_1.time_ - 0) / var_654_0)
				end
			end

			if arg_651_1.time_ >= 0 + var_654_0 and arg_651_1.time_ < 0 + var_654_0 + arg_654_0 and not isNil(arg_651_1.actors_["10058ui_story"]) and arg_651_1.var_.characterEffect10058ui_story then
				arg_651_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_651_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_654_1 = 0
			local var_654_2 = 0.975

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_1 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, true)
				arg_651_1.iconController_:SetSelectedState("hero")

				arg_651_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_651_1.callingController_:SetSelectedState("normal")

				arg_651_1.keyicon_.color = Color.New(1, 1, 1)
				arg_651_1.icon_.color = Color.New(1, 1, 1)

				local var_654_3 = arg_651_1:FormatText(arg_651_1:GetWordFromCfg(1109511160).content)

				arg_651_1.text_.text = var_654_3

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 39 <= 0 and var_654_2 or var_654_2 * (utf8.len(var_654_3) / 39)

				if (39 <= 0 and var_654_2 or var_654_2 * (utf8.len(var_654_3) / 39)) > 0 and var_654_2 < var_654_5 then
					arg_651_1.talkMaxDuration = var_654_5

					if var_654_5 + var_654_1 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_5 + var_654_1
					end
				end

				arg_651_1.text_.text = var_654_3
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_6 = math.max(var_654_2, arg_651_1.talkMaxDuration)

			if var_654_1 <= arg_651_1.time_ and arg_651_1.time_ < var_654_1 + var_654_6 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_1) / var_654_6

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_1 + var_654_6 and arg_651_1.time_ < var_654_1 + var_654_6 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play1109511161 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1109511161
		arg_655_1.duration_ = 8.13

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1109511162(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = 0.975

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_1 = arg_655_1:GetWordFromCfg(1109511161)
				local var_658_2 = arg_655_1:FormatText(var_658_1.content)

				arg_655_1.text_.text = var_658_2

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_4 = 39 <= 0 and var_658_0 or var_658_0 * (utf8.len(var_658_2) / 39)

				if (39 <= 0 and var_658_0 or var_658_0 * (utf8.len(var_658_2) / 39)) > 0 and var_658_0 < var_658_4 then
					arg_655_1.talkMaxDuration = var_658_4

					if var_658_4 + 0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_4 + 0
					end
				end

				arg_655_1.text_.text = var_658_2
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb") ~= 0 then
					local var_658_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb") / 1000

					if var_658_5 + 0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_5 + 0
					end

					if var_658_1.prefab_name ~= "" and arg_655_1.actors_[var_658_1.prefab_name] ~= nil then
						local var_658_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_1.prefab_name].transform, "story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb")

						arg_655_1:RecordAudio("1109511161", var_658_6)
						arg_655_1:RecordAudio("1109511161", var_658_6)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511161", "story_v_side_new_1109511.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_7 = math.max(var_658_0, arg_655_1.talkMaxDuration)

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_7 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - 0) / var_658_7

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= 0 + var_658_7 and arg_655_1.time_ < 0 + var_658_7 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play1109511162 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1109511162
		arg_659_1.duration_ = 9.23

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1109511163(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 and not isNil(arg_659_1.actors_["10058ui_story"]) and arg_659_1.var_.characterEffect10058ui_story == nil then
				arg_659_1.var_.characterEffect10058ui_story = arg_659_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_0 = 0.200000002980232

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_0 and not isNil(arg_659_1.actors_["10058ui_story"]) then
				if arg_659_1.var_.characterEffect10058ui_story and not isNil(arg_659_1.actors_["10058ui_story"]) then
					arg_659_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_659_1.time_ >= 0 + var_662_0 and arg_659_1.time_ < 0 + var_662_0 + arg_662_0 and not isNil(arg_659_1.actors_["10058ui_story"]) and arg_659_1.var_.characterEffect10058ui_story then
				arg_659_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_662_2 = 0
			local var_662_3 = 1

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_2 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_4 = arg_659_1:GetWordFromCfg(1109511162)
				local var_662_5 = arg_659_1:FormatText(var_662_4.content)

				arg_659_1.text_.text = var_662_5

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_7 = 40 <= 0 and var_662_3 or var_662_3 * (utf8.len(var_662_5) / 40)

				if (40 <= 0 and var_662_3 or var_662_3 * (utf8.len(var_662_5) / 40)) > 0 and var_662_3 < var_662_7 then
					arg_659_1.talkMaxDuration = var_662_7

					if var_662_7 + var_662_2 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_7 + var_662_2
					end
				end

				arg_659_1.text_.text = var_662_5
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb") ~= 0 then
					local var_662_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb") / 1000

					if var_662_8 + var_662_2 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_8 + var_662_2
					end

					if var_662_4.prefab_name ~= "" and arg_659_1.actors_[var_662_4.prefab_name] ~= nil then
						local var_662_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_4.prefab_name].transform, "story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb")

						arg_659_1:RecordAudio("1109511162", var_662_9)
						arg_659_1:RecordAudio("1109511162", var_662_9)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511162", "story_v_side_new_1109511.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_10 = math.max(var_662_3, arg_659_1.talkMaxDuration)

			if var_662_2 <= arg_659_1.time_ and arg_659_1.time_ < var_662_2 + var_662_10 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_2) / var_662_10

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_2 + var_662_10 and arg_659_1.time_ < var_662_2 + var_662_10 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play1109511163 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1109511163
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1109511164(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.var_.moveOldPos10058ui_story = arg_663_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_666_0 = 0.001

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_0 then
				arg_663_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_663_1.time_ - 0) / var_666_0)
				arg_663_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_663_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["10058ui_story"].transform.position).z)
				arg_663_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_663_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_663_1.actors_["10058ui_story"].transform.localEulerAngles = arg_663_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_663_1.time_ >= 0 + var_666_0 and arg_663_1.time_ < 0 + var_666_0 + arg_666_0 then
				arg_663_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_663_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_663_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["10058ui_story"].transform.position).z)
				arg_663_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_663_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_663_1.actors_["10058ui_story"].transform.localEulerAngles = arg_663_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_666_1 = arg_663_1.actors_["10058ui_story"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_1) and arg_663_1.var_.characterEffect10058ui_story == nil then
				arg_663_1.var_.characterEffect10058ui_story = var_666_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_2 = 0.200000002980232

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_2 and not isNil(var_666_1) then
				if arg_663_1.var_.characterEffect10058ui_story and not isNil(var_666_1) then
					arg_663_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_663_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_663_1.time_ - 0) / var_666_2)
				end
			end

			if arg_663_1.time_ >= 0 + var_666_2 and arg_663_1.time_ < 0 + var_666_2 + arg_666_0 and not isNil(var_666_1) and arg_663_1.var_.characterEffect10058ui_story then
				arg_663_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_663_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_666_3 = 0
			local var_666_4 = 0.85

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_3 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_5 = arg_663_1:FormatText(arg_663_1:GetWordFromCfg(1109511163).content)

				arg_663_1.text_.text = var_666_5

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_7 = 34 <= 0 and var_666_4 or var_666_4 * (utf8.len(var_666_5) / 34)

				if (34 <= 0 and var_666_4 or var_666_4 * (utf8.len(var_666_5) / 34)) > 0 and var_666_4 < var_666_7 then
					arg_663_1.talkMaxDuration = var_666_7

					if var_666_7 + var_666_3 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_7 + var_666_3
					end
				end

				arg_663_1.text_.text = var_666_5
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_8 = math.max(var_666_4, arg_663_1.talkMaxDuration)

			if var_666_3 <= arg_663_1.time_ and arg_663_1.time_ < var_666_3 + var_666_8 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_3) / var_666_8

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_3 + var_666_8 and arg_663_1.time_ < var_666_3 + var_666_8 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {
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

		arg_663_1:InitPlayNodeList()
	end,
	Play1109511164 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1109511164
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1109511165(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0.525

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, false)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_1 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(1109511164).content)

				arg_667_1.text_.text = var_670_1

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_3 = 21 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_1) / 21)

				if (21 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_1) / 21)) > 0 and var_670_0 < var_670_3 then
					arg_667_1.talkMaxDuration = var_670_3

					if var_670_3 + 0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_3 + 0
					end
				end

				arg_667_1.text_.text = var_670_1
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_4 = math.max(var_670_0, arg_667_1.talkMaxDuration)

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_4 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - 0) / var_670_4

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= 0 + var_670_4 and arg_667_1.time_ < 0 + var_670_4 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play1109511165 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1109511165
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play1109511166(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0.9

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_1 = arg_671_1:FormatText(arg_671_1:GetWordFromCfg(1109511165).content)

				arg_671_1.text_.text = var_674_1

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_3 = 36 <= 0 and var_674_0 or var_674_0 * (utf8.len(var_674_1) / 36)

				if (36 <= 0 and var_674_0 or var_674_0 * (utf8.len(var_674_1) / 36)) > 0 and var_674_0 < var_674_3 then
					arg_671_1.talkMaxDuration = var_674_3

					if var_674_3 + 0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_3 + 0
					end
				end

				arg_671_1.text_.text = var_674_1
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_4 = math.max(var_674_0, arg_671_1.talkMaxDuration)

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_4 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - 0) / var_674_4

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= 0 + var_674_4 and arg_671_1.time_ < 0 + var_674_4 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play1109511166 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1109511166
		arg_675_1.duration_ = 6.47

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1109511167(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0.725

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, true)
				arg_675_1.iconController_:SetSelectedState("hero")

				arg_675_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_675_1.callingController_:SetSelectedState("normal")

				arg_675_1.keyicon_.color = Color.New(1, 1, 1)
				arg_675_1.icon_.color = Color.New(1, 1, 1)

				local var_678_1 = arg_675_1:GetWordFromCfg(1109511166)
				local var_678_2 = arg_675_1:FormatText(var_678_1.content)

				arg_675_1.text_.text = var_678_2

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_4 = 29 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_2) / 29)

				if (29 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_2) / 29)) > 0 and var_678_0 < var_678_4 then
					arg_675_1.talkMaxDuration = var_678_4

					if var_678_4 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_4 + 0
					end
				end

				arg_675_1.text_.text = var_678_2
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb") ~= 0 then
					local var_678_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb") / 1000

					if var_678_5 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_5 + 0
					end

					if var_678_1.prefab_name ~= "" and arg_675_1.actors_[var_678_1.prefab_name] ~= nil then
						local var_678_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_1.prefab_name].transform, "story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb")

						arg_675_1:RecordAudio("1109511166", var_678_6)
						arg_675_1:RecordAudio("1109511166", var_678_6)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511166", "story_v_side_new_1109511.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_7 = math.max(var_678_0, arg_675_1.talkMaxDuration)

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_7 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - 0) / var_678_7

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= 0 + var_678_7 and arg_675_1.time_ < 0 + var_678_7 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play1109511167 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1109511167
		arg_679_1.duration_ = 2.47

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1109511168(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.var_.moveOldPos10058ui_story = arg_679_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_682_0 = 0.001

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 then
				arg_679_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_679_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_679_1.time_ - 0) / var_682_0)
				arg_679_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_679_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["10058ui_story"].transform.position).z)
				arg_679_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_679_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_679_1.actors_["10058ui_story"].transform.localEulerAngles = arg_679_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 then
				arg_679_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_679_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_679_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_679_1.actors_["10058ui_story"].transform.position).z)
				arg_679_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_679_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_679_1.actors_["10058ui_story"].transform.localEulerAngles = arg_679_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_682_1 = arg_679_1.actors_["10058ui_story"]

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(var_682_1) and arg_679_1.var_.characterEffect10058ui_story == nil then
				arg_679_1.var_.characterEffect10058ui_story = var_682_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_2 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_2 and not isNil(var_682_1) then
				if arg_679_1.var_.characterEffect10058ui_story and not isNil(var_682_1) then
					arg_679_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_679_1.time_ >= 0 + var_682_2 and arg_679_1.time_ < 0 + var_682_2 + arg_682_0 and not isNil(var_682_1) and arg_679_1.var_.characterEffect10058ui_story then
				arg_679_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_682_4 = 0
			local var_682_5 = 0.325

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_4 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_6 = arg_679_1:GetWordFromCfg(1109511167)
				local var_682_7 = arg_679_1:FormatText(var_682_6.content)

				arg_679_1.text_.text = var_682_7

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_9 = 13 <= 0 and var_682_5 or var_682_5 * (utf8.len(var_682_7) / 13)

				if (13 <= 0 and var_682_5 or var_682_5 * (utf8.len(var_682_7) / 13)) > 0 and var_682_5 < var_682_9 then
					arg_679_1.talkMaxDuration = var_682_9

					if var_682_9 + var_682_4 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_9 + var_682_4
					end
				end

				arg_679_1.text_.text = var_682_7
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb") ~= 0 then
					local var_682_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb") / 1000

					if var_682_10 + var_682_4 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_10 + var_682_4
					end

					if var_682_6.prefab_name ~= "" and arg_679_1.actors_[var_682_6.prefab_name] ~= nil then
						local var_682_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_6.prefab_name].transform, "story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb")

						arg_679_1:RecordAudio("1109511167", var_682_11)
						arg_679_1:RecordAudio("1109511167", var_682_11)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511167", "story_v_side_new_1109511.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_12 = math.max(var_682_5, arg_679_1.talkMaxDuration)

			if var_682_4 <= arg_679_1.time_ and arg_679_1.time_ < var_682_4 + var_682_12 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_4) / var_682_12

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_4 + var_682_12 and arg_679_1.time_ < var_682_4 + var_682_12 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {
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

		arg_679_1:InitPlayNodeList()
	end,
	Play1109511168 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1109511168
		arg_683_1.duration_ = 5.97

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1109511169(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(arg_683_1.actors_["10058ui_story"]) and arg_683_1.var_.characterEffect10058ui_story == nil then
				arg_683_1.var_.characterEffect10058ui_story = arg_683_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_0 = 0.200000002980232

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 and not isNil(arg_683_1.actors_["10058ui_story"]) then
				if arg_683_1.var_.characterEffect10058ui_story and not isNil(arg_683_1.actors_["10058ui_story"]) then
					arg_683_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_683_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_683_1.time_ - 0) / var_686_0)
				end
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 and not isNil(arg_683_1.actors_["10058ui_story"]) and arg_683_1.var_.characterEffect10058ui_story then
				arg_683_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_683_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_686_1 = 0
			local var_686_2 = 0.7

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_683_1.callingController_:SetSelectedState("normal")

				arg_683_1.keyicon_.color = Color.New(1, 1, 1)
				arg_683_1.icon_.color = Color.New(1, 1, 1)

				local var_686_3 = arg_683_1:GetWordFromCfg(1109511168)
				local var_686_4 = arg_683_1:FormatText(var_686_3.content)

				arg_683_1.text_.text = var_686_4

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_6 = 28 <= 0 and var_686_2 or var_686_2 * (utf8.len(var_686_4) / 28)

				if (28 <= 0 and var_686_2 or var_686_2 * (utf8.len(var_686_4) / 28)) > 0 and var_686_2 < var_686_6 then
					arg_683_1.talkMaxDuration = var_686_6

					if var_686_6 + var_686_1 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_6 + var_686_1
					end
				end

				arg_683_1.text_.text = var_686_4
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb") ~= 0 then
					local var_686_7 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb") / 1000

					if var_686_7 + var_686_1 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_7 + var_686_1
					end

					if var_686_3.prefab_name ~= "" and arg_683_1.actors_[var_686_3.prefab_name] ~= nil then
						local var_686_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_3.prefab_name].transform, "story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb")

						arg_683_1:RecordAudio("1109511168", var_686_8)
						arg_683_1:RecordAudio("1109511168", var_686_8)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511168", "story_v_side_new_1109511.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_9 = math.max(var_686_2, arg_683_1.talkMaxDuration)

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_9 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_1) / var_686_9

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_1 + var_686_9 and arg_683_1.time_ < var_686_1 + var_686_9 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1109511169 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1109511169
		arg_687_1.duration_ = 2

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1109511170(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(arg_687_1.actors_["10058ui_story"]) and arg_687_1.var_.characterEffect10058ui_story == nil then
				arg_687_1.var_.characterEffect10058ui_story = arg_687_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_0 = 0.200000002980232

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_0 and not isNil(arg_687_1.actors_["10058ui_story"]) then
				if arg_687_1.var_.characterEffect10058ui_story and not isNil(arg_687_1.actors_["10058ui_story"]) then
					arg_687_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_687_1.time_ >= 0 + var_690_0 and arg_687_1.time_ < 0 + var_690_0 + arg_690_0 and not isNil(arg_687_1.actors_["10058ui_story"]) and arg_687_1.var_.characterEffect10058ui_story then
				arg_687_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action446")
			end

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_690_2 = 0
			local var_690_3 = 0.1

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_2 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_4 = arg_687_1:GetWordFromCfg(1109511169)
				local var_690_5 = arg_687_1:FormatText(var_690_4.content)

				arg_687_1.text_.text = var_690_5

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_7 = 4 <= 0 and var_690_3 or var_690_3 * (utf8.len(var_690_5) / 4)

				if (4 <= 0 and var_690_3 or var_690_3 * (utf8.len(var_690_5) / 4)) > 0 and var_690_3 < var_690_7 then
					arg_687_1.talkMaxDuration = var_690_7

					if var_690_7 + var_690_2 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_7 + var_690_2
					end
				end

				arg_687_1.text_.text = var_690_5
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb") ~= 0 then
					local var_690_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb") / 1000

					if var_690_8 + var_690_2 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_8 + var_690_2
					end

					if var_690_4.prefab_name ~= "" and arg_687_1.actors_[var_690_4.prefab_name] ~= nil then
						local var_690_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_4.prefab_name].transform, "story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb")

						arg_687_1:RecordAudio("1109511169", var_690_9)
						arg_687_1:RecordAudio("1109511169", var_690_9)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511169", "story_v_side_new_1109511.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_10 = math.max(var_690_3, arg_687_1.talkMaxDuration)

			if var_690_2 <= arg_687_1.time_ and arg_687_1.time_ < var_690_2 + var_690_10 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_2) / var_690_10

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_2 + var_690_10 and arg_687_1.time_ < var_690_2 + var_690_10 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1109511170 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1109511170
		arg_691_1.duration_ = 2.9

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1109511171(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(arg_691_1.actors_["10058ui_story"]) and arg_691_1.var_.characterEffect10058ui_story == nil then
				arg_691_1.var_.characterEffect10058ui_story = arg_691_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_0 = 0.200000002980232

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 and not isNil(arg_691_1.actors_["10058ui_story"]) then
				if arg_691_1.var_.characterEffect10058ui_story and not isNil(arg_691_1.actors_["10058ui_story"]) then
					arg_691_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_691_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_691_1.time_ - 0) / var_694_0)
				end
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 and not isNil(arg_691_1.actors_["10058ui_story"]) and arg_691_1.var_.characterEffect10058ui_story then
				arg_691_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_691_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_694_1 = 0
			local var_694_2 = 0.2

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[1556].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, true)
				arg_691_1.iconController_:SetSelectedState("hero")

				arg_691_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_691_1.callingController_:SetSelectedState("normal")

				arg_691_1.keyicon_.color = Color.New(1, 1, 1)
				arg_691_1.icon_.color = Color.New(1, 1, 1)

				local var_694_3 = arg_691_1:GetWordFromCfg(1109511170)
				local var_694_4 = arg_691_1:FormatText(var_694_3.content)

				arg_691_1.text_.text = var_694_4

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_6 = 8 <= 0 and var_694_2 or var_694_2 * (utf8.len(var_694_4) / 8)

				if (8 <= 0 and var_694_2 or var_694_2 * (utf8.len(var_694_4) / 8)) > 0 and var_694_2 < var_694_6 then
					arg_691_1.talkMaxDuration = var_694_6

					if var_694_6 + var_694_1 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_6 + var_694_1
					end
				end

				arg_691_1.text_.text = var_694_4
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb") ~= 0 then
					local var_694_7 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb") / 1000

					if var_694_7 + var_694_1 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_7 + var_694_1
					end

					if var_694_3.prefab_name ~= "" and arg_691_1.actors_[var_694_3.prefab_name] ~= nil then
						local var_694_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_3.prefab_name].transform, "story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb")

						arg_691_1:RecordAudio("1109511170", var_694_8)
						arg_691_1:RecordAudio("1109511170", var_694_8)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511170", "story_v_side_new_1109511.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_9 = math.max(var_694_2, arg_691_1.talkMaxDuration)

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_9 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_1) / var_694_9

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_1 + var_694_9 and arg_691_1.time_ < var_694_1 + var_694_9 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1109511171 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1109511171
		arg_695_1.duration_ = 1

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"

			SetActive(arg_695_1.choicesGo_, true)

			for iter_696_0, iter_696_1 in ipairs(arg_695_1.choices_) do
				SetActive(iter_696_1.go, iter_696_0 <= 2)
			end

			arg_695_1.choices_[1].txt.text = arg_695_1:FormatText(StoryChoiceCfg[1748].name)
			arg_695_1.choices_[2].txt.text = arg_695_1:FormatText(StoryChoiceCfg[1749].name)
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1109511172(arg_695_1)
			end

			if arg_697_0 == 2 then
				arg_695_0:Play1109511173(arg_695_1)
			end

			arg_695_1:RecordChoiceLog(1109511171, 1748, 1749)
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			return
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1109511172 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1109511172
		arg_699_1.duration_ = 2

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1109511174(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.var_.moveOldPos10058ui_story = arg_699_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_702_0 = 0.001

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 then
				arg_699_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_699_1.time_ - 0) / var_702_0)
				arg_699_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["10058ui_story"].transform.position).z)
				arg_699_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["10058ui_story"].transform.localEulerAngles = arg_699_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 then
				arg_699_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_699_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["10058ui_story"].transform.position).z)
				arg_699_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["10058ui_story"].transform.localEulerAngles = arg_699_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_702_1 = arg_699_1.actors_["10058ui_story"]

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(var_702_1) and arg_699_1.var_.characterEffect10058ui_story == nil then
				arg_699_1.var_.characterEffect10058ui_story = var_702_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_2 = 0.200000002980232

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_2 and not isNil(var_702_1) then
				if arg_699_1.var_.characterEffect10058ui_story and not isNil(var_702_1) then
					arg_699_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= 0 + var_702_2 and arg_699_1.time_ < 0 + var_702_2 + arg_702_0 and not isNil(var_702_1) and arg_699_1.var_.characterEffect10058ui_story then
				arg_699_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_702_4 = 0
			local var_702_5 = 0.05

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_4 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_6 = arg_699_1:GetWordFromCfg(1109511172)
				local var_702_7 = arg_699_1:FormatText(var_702_6.content)

				arg_699_1.text_.text = var_702_7

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_9 = 2 <= 0 and var_702_5 or var_702_5 * (utf8.len(var_702_7) / 2)

				if (2 <= 0 and var_702_5 or var_702_5 * (utf8.len(var_702_7) / 2)) > 0 and var_702_5 < var_702_9 then
					arg_699_1.talkMaxDuration = var_702_9

					if var_702_9 + var_702_4 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_9 + var_702_4
					end
				end

				arg_699_1.text_.text = var_702_7
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb") ~= 0 then
					local var_702_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb") / 1000

					if var_702_10 + var_702_4 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_10 + var_702_4
					end

					if var_702_6.prefab_name ~= "" and arg_699_1.actors_[var_702_6.prefab_name] ~= nil then
						local var_702_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_6.prefab_name].transform, "story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb")

						arg_699_1:RecordAudio("1109511172", var_702_11)
						arg_699_1:RecordAudio("1109511172", var_702_11)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511172", "story_v_side_new_1109511.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_12 = math.max(var_702_5, arg_699_1.talkMaxDuration)

			if var_702_4 <= arg_699_1.time_ and arg_699_1.time_ < var_702_4 + var_702_12 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_4) / var_702_12

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_4 + var_702_12 and arg_699_1.time_ < var_702_4 + var_702_12 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
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

		arg_699_1:InitPlayNodeList()
	end,
	Play1109511174 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1109511174
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1109511175(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1.var_.moveOldPos10058ui_story = arg_703_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_706_0 = 0.001

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 then
				arg_703_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_703_1.time_ - 0) / var_706_0)
				arg_703_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["10058ui_story"].transform.position).z)
				arg_703_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["10058ui_story"].transform.localEulerAngles = arg_703_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 then
				arg_703_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_703_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["10058ui_story"].transform.position).z)
				arg_703_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["10058ui_story"].transform.localEulerAngles = arg_703_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_706_1 = arg_703_1.actors_["10058ui_story"]

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect10058ui_story == nil then
				arg_703_1.var_.characterEffect10058ui_story = var_706_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_2 and not isNil(var_706_1) then
				if arg_703_1.var_.characterEffect10058ui_story and not isNil(var_706_1) then
					arg_703_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_703_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_703_1.time_ - 0) / var_706_2)
				end
			end

			if arg_703_1.time_ >= 0 + var_706_2 and arg_703_1.time_ < 0 + var_706_2 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect10058ui_story then
				arg_703_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_703_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_706_3 = 0
			local var_706_4 = 0.725

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_3 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_5 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(1109511174).content)

				arg_703_1.text_.text = var_706_5

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_7 = 29 <= 0 and var_706_4 or var_706_4 * (utf8.len(var_706_5) / 29)

				if (29 <= 0 and var_706_4 or var_706_4 * (utf8.len(var_706_5) / 29)) > 0 and var_706_4 < var_706_7 then
					arg_703_1.talkMaxDuration = var_706_7

					if var_706_7 + var_706_3 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_7 + var_706_3
					end
				end

				arg_703_1.text_.text = var_706_5
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_8 = math.max(var_706_4, arg_703_1.talkMaxDuration)

			if var_706_3 <= arg_703_1.time_ and arg_703_1.time_ < var_706_3 + var_706_8 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_3) / var_706_8

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_3 + var_706_8 and arg_703_1.time_ < var_706_3 + var_706_8 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
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

		arg_703_1:InitPlayNodeList()
	end,
	Play1109511175 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1109511175
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1109511176(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_710_1 = 0
			local var_710_2 = 1.15

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, false)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_3 = arg_707_1:FormatText(arg_707_1:GetWordFromCfg(1109511175).content)

				arg_707_1.text_.text = var_710_3

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_5 = 46 <= 0 and var_710_2 or var_710_2 * (utf8.len(var_710_3) / 46)

				if (46 <= 0 and var_710_2 or var_710_2 * (utf8.len(var_710_3) / 46)) > 0 and var_710_2 < var_710_5 then
					arg_707_1.talkMaxDuration = var_710_5

					if var_710_5 + var_710_1 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_5 + var_710_1
					end
				end

				arg_707_1.text_.text = var_710_3
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_6 = math.max(var_710_2, arg_707_1.talkMaxDuration)

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_6 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_1) / var_710_6

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_1 + var_710_6 and arg_707_1.time_ < var_710_1 + var_710_6 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play1109511176 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1109511176
		arg_711_1.duration_ = 7.65

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1109511177(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if arg_711_1.bgs_.ST77 == nil then
				local var_714_0 = Object.Instantiate(arg_711_1.paintGo_)

				var_714_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST77")
				var_714_0.name = "ST77"
				var_714_0.transform.parent = arg_711_1.stage_.transform
				var_714_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_711_1.bgs_.ST77 = var_714_0
			end

			if 1.35 < arg_711_1.time_ and arg_711_1.time_ <= 1.35 + arg_714_0 then
				local var_714_1 = arg_711_1.bgs_.ST77

				arg_711_1.bgs_.ST77.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_714_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_714_2 = var_714_1:GetComponent("SpriteRenderer")

				if var_714_2 and var_714_2.sprite then
					local var_714_3 = 2 * (var_714_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_714_1.transform.localScale = Vector3.New(var_714_3 / var_714_2.sprite.bounds.size.y < var_714_3 * manager.ui.mainCameraCom_.aspect / var_714_2.sprite.bounds.size.x and var_714_3 * manager.ui.mainCameraCom_.aspect / var_714_2.sprite.bounds.size.x or var_714_3 / var_714_2.sprite.bounds.size.y, var_714_3 / var_714_2.sprite.bounds.size.y < var_714_3 * manager.ui.mainCameraCom_.aspect / var_714_2.sprite.bounds.size.x and var_714_3 * manager.ui.mainCameraCom_.aspect / var_714_2.sprite.bounds.size.x or var_714_3 / var_714_2.sprite.bounds.size.y, 0)
				end

				for iter_714_0, iter_714_1 in pairs(arg_711_1.bgs_) do
					if iter_714_0 ~= "ST77" then
						iter_714_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_714_4 = 0

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_4 + arg_714_0 then
				arg_711_1.allBtn_.enabled = false
			end

			if arg_711_1.time_ >= var_714_4 + 0.3 and arg_711_1.time_ < var_714_4 + 0.3 + arg_714_0 then
				arg_711_1.allBtn_.enabled = true
			end

			local var_714_5 = 0

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_5 + arg_714_0 then
				arg_711_1.mask_.enabled = true
				arg_711_1.mask_.raycastTarget = true

				arg_711_1:SetGaussion(false)
			end

			local var_714_6 = 1.35

			if var_714_5 <= arg_711_1.time_ and arg_711_1.time_ < var_714_5 + var_714_6 then
				local var_714_7 = Color.New(0, 0, 0)

				var_714_7.a = Mathf.Lerp(0, 1, (arg_711_1.time_ - var_714_5) / var_714_6)
				arg_711_1.mask_.color = var_714_7
			end

			if arg_711_1.time_ >= var_714_5 + var_714_6 and arg_711_1.time_ < var_714_5 + var_714_6 + arg_714_0 then
				local var_714_8 = Color.New(0, 0, 0)

				var_714_8.a = 1
				arg_711_1.mask_.color = var_714_8
			end

			local var_714_9 = 1.35

			if 1.35 < arg_711_1.time_ and arg_711_1.time_ <= var_714_9 + arg_714_0 then
				arg_711_1.mask_.enabled = true
				arg_711_1.mask_.raycastTarget = true

				arg_711_1:SetGaussion(false)
			end

			local var_714_10 = 1.35

			if var_714_9 <= arg_711_1.time_ and arg_711_1.time_ < var_714_9 + var_714_10 then
				local var_714_11 = Color.New(0, 0, 0)

				var_714_11.a = Mathf.Lerp(1, 0, (arg_711_1.time_ - var_714_9) / var_714_10)
				arg_711_1.mask_.color = var_714_11
			end

			if arg_711_1.time_ >= var_714_9 + var_714_10 and arg_711_1.time_ < var_714_9 + var_714_10 + arg_714_0 then
				local var_714_12 = Color.New(0, 0, 0)

				arg_711_1.mask_.enabled = false
				var_714_12.a = 0
				arg_711_1.mask_.color = var_714_12
			end

			if 1 < arg_711_1.time_ and arg_711_1.time_ <= 1 + arg_714_0 then
				arg_711_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 0.2 < arg_711_1.time_ and arg_711_1.time_ <= 0.2 + arg_714_0 then
				arg_711_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_fountain", "")
			end

			if 1 < arg_711_1.time_ and arg_711_1.time_ <= 1 + arg_714_0 then
				arg_711_1:AudioAction("play", "music", "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day.awb")

				local var_714_17 = manager.audio:GetAudioName("bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day")

				if "" ~= "" then
					if arg_711_1.bgmTxt_.text ~= var_714_17 and arg_711_1.bgmTxt_.text ~= "" then
						if arg_711_1.bgmTxt2_.text ~= "" then
							arg_711_1.bgmTxt_.text = arg_711_1.bgmTxt2_.text
						end

						arg_711_1.bgmTxt2_.text = var_714_17

						arg_711_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_711_1.bgmTxt_.text = var_714_17
						arg_711_1.bgmTxt2_.text = var_714_17
					end

					if arg_711_1.bgmTimer then
						arg_711_1.bgmTimer:Stop()

						arg_711_1.bgmTimer = nil
					end

					if arg_711_1.settingData.show_music_name == 1 then
						arg_711_1.musicController:SetSelectedState("show")
						arg_711_1.musicAnimator_:Play("open", 0, 0)

						if arg_711_1.settingData.music_time ~= 0 then
							arg_711_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_711_1.settingData.music_time), function()
								if arg_711_1 == nil or isNil(arg_711_1.bgmTxt_) then
									return
								end

								arg_711_1.musicController:SetSelectedState("hide")
								arg_711_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_711_1.frameCnt_ <= 1 then
				arg_711_1.dialog_:SetActive(false)
			end

			local var_714_18 = 2.65
			local var_714_19 = 0.7

			if 2.65 < arg_711_1.time_ and arg_711_1.time_ <= var_714_18 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0

				arg_711_1.dialog_:SetActive(true)

				arg_711_1.dialogCg_.alpha = 0

				local var_714_20 = LeanTween.value(arg_711_1.dialog_, 0, 1, 0.3)

				var_714_20:setOnUpdate(LuaHelper.FloatAction(function(arg_716_0)
					arg_711_1.dialogCg_.alpha = arg_716_0
				end))
				var_714_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_711_1.dialog_)
					var_714_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_711_1.duration_ = arg_711_1.duration_ + 0.3

				SetActive(arg_711_1.leftNameGo_, false)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_21 = arg_711_1:FormatText(arg_711_1:GetWordFromCfg(1109511176).content)

				arg_711_1.text_.text = var_714_21

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_23 = 28 <= 0 and var_714_19 or var_714_19 * (utf8.len(var_714_21) / 28)

				if (28 <= 0 and var_714_19 or var_714_19 * (utf8.len(var_714_21) / 28)) > 0 and var_714_19 < var_714_23 then
					arg_711_1.talkMaxDuration = var_714_23
					var_714_18 = var_714_18 + 0.3

					if var_714_23 + var_714_18 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_23 + var_714_18
					end
				end

				arg_711_1.text_.text = var_714_21
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_24 = var_714_18 + 0.3
			local var_714_25 = math.max(var_714_19, arg_711_1.talkMaxDuration)

			if var_714_18 + 0.3 <= arg_711_1.time_ and arg_711_1.time_ < var_714_24 + var_714_25 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_24) / var_714_25

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_24 + var_714_25 and arg_711_1.time_ < var_714_24 + var_714_25 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play1109511177 = function(arg_718_0, arg_718_1)
		arg_718_1.time_ = 0
		arg_718_1.frameCnt_ = 0
		arg_718_1.state_ = "playing"
		arg_718_1.curTalkId_ = 1109511177
		arg_718_1.duration_ = 5

		SetActive(arg_718_1.tipsGo_, false)

		function arg_718_1.onSingleLineFinish_()
			arg_718_1.onSingleLineUpdate_ = nil
			arg_718_1.onSingleLineFinish_ = nil
			arg_718_1.state_ = "waiting"
		end

		function arg_718_1.playNext_(arg_720_0)
			if arg_720_0 == 1 then
				arg_718_0:Play1109511178(arg_718_1)
			end
		end

		function arg_718_1.onSingleLineUpdate_(arg_721_0)
			local var_721_0 = 0.35

			if 0 < arg_718_1.time_ and arg_718_1.time_ <= 0 + arg_721_0 then
				arg_718_1.talkMaxDuration = 0
				arg_718_1.dialogCg_.alpha = 1

				arg_718_1.dialog_:SetActive(true)
				SetActive(arg_718_1.leftNameGo_, true)

				arg_718_1.leftNameTxt_.text = arg_718_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_718_1.leftNameTxt_.transform)

				arg_718_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_718_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_718_1:RecordName(arg_718_1.leftNameTxt_.text)
				SetActive(arg_718_1.iconTrs_.gameObject, true)
				arg_718_1.iconController_:SetSelectedState("hero")

				arg_718_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_718_1.callingController_:SetSelectedState("normal")

				arg_718_1.keyicon_.color = Color.New(1, 1, 1)
				arg_718_1.icon_.color = Color.New(1, 1, 1)

				local var_721_1 = arg_718_1:FormatText(arg_718_1:GetWordFromCfg(1109511177).content)

				arg_718_1.text_.text = var_721_1

				LuaForUtil.ClearLinePrefixSymbol(arg_718_1.text_)

				local var_721_3 = 14 <= 0 and var_721_0 or var_721_0 * (utf8.len(var_721_1) / 14)

				if (14 <= 0 and var_721_0 or var_721_0 * (utf8.len(var_721_1) / 14)) > 0 and var_721_0 < var_721_3 then
					arg_718_1.talkMaxDuration = var_721_3

					if var_721_3 + 0 > arg_718_1.duration_ then
						arg_718_1.duration_ = var_721_3 + 0
					end
				end

				arg_718_1.text_.text = var_721_1
				arg_718_1.typewritter.percent = 0

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(false)
				arg_718_1:RecordContent(arg_718_1.text_.text)
			end

			local var_721_4 = math.max(var_721_0, arg_718_1.talkMaxDuration)

			if 0 <= arg_718_1.time_ and arg_718_1.time_ < 0 + var_721_4 then
				arg_718_1.typewritter.percent = (arg_718_1.time_ - 0) / var_721_4

				arg_718_1.typewritter:SetDirty()
			end

			if arg_718_1.time_ >= 0 + var_721_4 and arg_718_1.time_ < 0 + var_721_4 + arg_721_0 then
				arg_718_1.typewritter.percent = 1

				arg_718_1.typewritter:SetDirty()
				arg_718_1:ShowNextGo(true)
			end
		end

		arg_718_1.nodeConfigList_ = {}

		arg_718_1:InitPlayNodeList()
	end,
	Play1109511178 = function(arg_722_0, arg_722_1)
		arg_722_1.time_ = 0
		arg_722_1.frameCnt_ = 0
		arg_722_1.state_ = "playing"
		arg_722_1.curTalkId_ = 1109511178
		arg_722_1.duration_ = 7.17

		SetActive(arg_722_1.tipsGo_, false)

		function arg_722_1.onSingleLineFinish_()
			arg_722_1.onSingleLineUpdate_ = nil
			arg_722_1.onSingleLineFinish_ = nil
			arg_722_1.state_ = "waiting"
		end

		function arg_722_1.playNext_(arg_724_0)
			if arg_724_0 == 1 then
				arg_722_0:Play1109511179(arg_722_1)
			end
		end

		function arg_722_1.onSingleLineUpdate_(arg_725_0)
			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 then
				arg_722_1.var_.moveOldPos10058ui_story = arg_722_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_725_0 = 0.001

			if 0 <= arg_722_1.time_ and arg_722_1.time_ < 0 + var_725_0 then
				arg_722_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_722_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_722_1.time_ - 0) / var_725_0)
				arg_722_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_722_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_722_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_722_1.actors_["10058ui_story"].transform.position).z)
				arg_722_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_722_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_722_1.actors_["10058ui_story"].transform.localEulerAngles = arg_722_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_722_1.time_ >= 0 + var_725_0 and arg_722_1.time_ < 0 + var_725_0 + arg_725_0 then
				arg_722_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_722_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_722_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_722_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_722_1.actors_["10058ui_story"].transform.position).z)
				arg_722_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_722_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_722_1.actors_["10058ui_story"].transform.localEulerAngles = arg_722_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_725_1 = arg_722_1.actors_["10058ui_story"]

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 and not isNil(var_725_1) and arg_722_1.var_.characterEffect10058ui_story == nil then
				arg_722_1.var_.characterEffect10058ui_story = var_725_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_725_2 = 0.200000002980232

			if 0 <= arg_722_1.time_ and arg_722_1.time_ < 0 + var_725_2 and not isNil(var_725_1) then
				if arg_722_1.var_.characterEffect10058ui_story and not isNil(var_725_1) then
					arg_722_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_722_1.time_ >= 0 + var_725_2 and arg_722_1.time_ < 0 + var_725_2 + arg_725_0 and not isNil(var_725_1) and arg_722_1.var_.characterEffect10058ui_story then
				arg_722_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 then
				arg_722_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= 0 + arg_725_0 then
				arg_722_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_725_4 = 0
			local var_725_5 = 0.8

			if 0 < arg_722_1.time_ and arg_722_1.time_ <= var_725_4 + arg_725_0 then
				arg_722_1.talkMaxDuration = 0
				arg_722_1.dialogCg_.alpha = 1

				arg_722_1.dialog_:SetActive(true)
				SetActive(arg_722_1.leftNameGo_, true)

				arg_722_1.leftNameTxt_.text = arg_722_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_722_1.leftNameTxt_.transform)

				arg_722_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_722_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_722_1:RecordName(arg_722_1.leftNameTxt_.text)
				SetActive(arg_722_1.iconTrs_.gameObject, false)
				arg_722_1.callingController_:SetSelectedState("normal")

				local var_725_6 = arg_722_1:GetWordFromCfg(1109511178)
				local var_725_7 = arg_722_1:FormatText(var_725_6.content)

				arg_722_1.text_.text = var_725_7

				LuaForUtil.ClearLinePrefixSymbol(arg_722_1.text_)

				local var_725_9 = 32 <= 0 and var_725_5 or var_725_5 * (utf8.len(var_725_7) / 32)

				if (32 <= 0 and var_725_5 or var_725_5 * (utf8.len(var_725_7) / 32)) > 0 and var_725_5 < var_725_9 then
					arg_722_1.talkMaxDuration = var_725_9

					if var_725_9 + var_725_4 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_9 + var_725_4
					end
				end

				arg_722_1.text_.text = var_725_7
				arg_722_1.typewritter.percent = 0

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb") ~= 0 then
					local var_725_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb") / 1000

					if var_725_10 + var_725_4 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_10 + var_725_4
					end

					if var_725_6.prefab_name ~= "" and arg_722_1.actors_[var_725_6.prefab_name] ~= nil then
						local var_725_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_722_1.actors_[var_725_6.prefab_name].transform, "story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb")

						arg_722_1:RecordAudio("1109511178", var_725_11)
						arg_722_1:RecordAudio("1109511178", var_725_11)
					else
						arg_722_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb")
					end

					arg_722_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511178", "story_v_side_new_1109511.awb")
				end

				arg_722_1:RecordContent(arg_722_1.text_.text)
			end

			local var_725_12 = math.max(var_725_5, arg_722_1.talkMaxDuration)

			if var_725_4 <= arg_722_1.time_ and arg_722_1.time_ < var_725_4 + var_725_12 then
				arg_722_1.typewritter.percent = (arg_722_1.time_ - var_725_4) / var_725_12

				arg_722_1.typewritter:SetDirty()
			end

			if arg_722_1.time_ >= var_725_4 + var_725_12 and arg_722_1.time_ < var_725_4 + var_725_12 + arg_725_0 then
				arg_722_1.typewritter.percent = 1

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(true)
			end
		end

		arg_722_1.nodeConfigList_ = {
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

		arg_722_1:InitPlayNodeList()
	end,
	Play1109511179 = function(arg_726_0, arg_726_1)
		arg_726_1.time_ = 0
		arg_726_1.frameCnt_ = 0
		arg_726_1.state_ = "playing"
		arg_726_1.curTalkId_ = 1109511179
		arg_726_1.duration_ = 9.5

		SetActive(arg_726_1.tipsGo_, false)

		function arg_726_1.onSingleLineFinish_()
			arg_726_1.onSingleLineUpdate_ = nil
			arg_726_1.onSingleLineFinish_ = nil
			arg_726_1.state_ = "waiting"
		end

		function arg_726_1.playNext_(arg_728_0)
			if arg_728_0 == 1 then
				arg_726_0:Play1109511180(arg_726_1)
			end
		end

		function arg_726_1.onSingleLineUpdate_(arg_729_0)
			local var_729_0 = 0.95

			if 0 < arg_726_1.time_ and arg_726_1.time_ <= 0 + arg_729_0 then
				arg_726_1.talkMaxDuration = 0
				arg_726_1.dialogCg_.alpha = 1

				arg_726_1.dialog_:SetActive(true)
				SetActive(arg_726_1.leftNameGo_, true)

				arg_726_1.leftNameTxt_.text = arg_726_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_726_1.leftNameTxt_.transform)

				arg_726_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_726_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_726_1:RecordName(arg_726_1.leftNameTxt_.text)
				SetActive(arg_726_1.iconTrs_.gameObject, false)
				arg_726_1.callingController_:SetSelectedState("normal")

				local var_729_1 = arg_726_1:GetWordFromCfg(1109511179)
				local var_729_2 = arg_726_1:FormatText(var_729_1.content)

				arg_726_1.text_.text = var_729_2

				LuaForUtil.ClearLinePrefixSymbol(arg_726_1.text_)

				local var_729_4 = 38 <= 0 and var_729_0 or var_729_0 * (utf8.len(var_729_2) / 38)

				if (38 <= 0 and var_729_0 or var_729_0 * (utf8.len(var_729_2) / 38)) > 0 and var_729_0 < var_729_4 then
					arg_726_1.talkMaxDuration = var_729_4

					if var_729_4 + 0 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_4 + 0
					end
				end

				arg_726_1.text_.text = var_729_2
				arg_726_1.typewritter.percent = 0

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb") ~= 0 then
					local var_729_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb") / 1000

					if var_729_5 + 0 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_5 + 0
					end

					if var_729_1.prefab_name ~= "" and arg_726_1.actors_[var_729_1.prefab_name] ~= nil then
						local var_729_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_726_1.actors_[var_729_1.prefab_name].transform, "story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb")

						arg_726_1:RecordAudio("1109511179", var_729_6)
						arg_726_1:RecordAudio("1109511179", var_729_6)
					else
						arg_726_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb")
					end

					arg_726_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511179", "story_v_side_new_1109511.awb")
				end

				arg_726_1:RecordContent(arg_726_1.text_.text)
			end

			local var_729_7 = math.max(var_729_0, arg_726_1.talkMaxDuration)

			if 0 <= arg_726_1.time_ and arg_726_1.time_ < 0 + var_729_7 then
				arg_726_1.typewritter.percent = (arg_726_1.time_ - 0) / var_729_7

				arg_726_1.typewritter:SetDirty()
			end

			if arg_726_1.time_ >= 0 + var_729_7 and arg_726_1.time_ < 0 + var_729_7 + arg_729_0 then
				arg_726_1.typewritter.percent = 1

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(true)
			end
		end

		arg_726_1.nodeConfigList_ = {}

		arg_726_1:InitPlayNodeList()
	end,
	Play1109511180 = function(arg_730_0, arg_730_1)
		arg_730_1.time_ = 0
		arg_730_1.frameCnt_ = 0
		arg_730_1.state_ = "playing"
		arg_730_1.curTalkId_ = 1109511180
		arg_730_1.duration_ = 5

		SetActive(arg_730_1.tipsGo_, false)

		function arg_730_1.onSingleLineFinish_()
			arg_730_1.onSingleLineUpdate_ = nil
			arg_730_1.onSingleLineFinish_ = nil
			arg_730_1.state_ = "waiting"
		end

		function arg_730_1.playNext_(arg_732_0)
			if arg_732_0 == 1 then
				arg_730_0:Play1109511181(arg_730_1)
			end
		end

		function arg_730_1.onSingleLineUpdate_(arg_733_0)
			if 0 < arg_730_1.time_ and arg_730_1.time_ <= 0 + arg_733_0 and not isNil(arg_730_1.actors_["10058ui_story"]) and arg_730_1.var_.characterEffect10058ui_story == nil then
				arg_730_1.var_.characterEffect10058ui_story = arg_730_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_733_0 = 0.200000002980232

			if 0 <= arg_730_1.time_ and arg_730_1.time_ < 0 + var_733_0 and not isNil(arg_730_1.actors_["10058ui_story"]) then
				if arg_730_1.var_.characterEffect10058ui_story and not isNil(arg_730_1.actors_["10058ui_story"]) then
					arg_730_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_730_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_730_1.time_ - 0) / var_733_0)
				end
			end

			if arg_730_1.time_ >= 0 + var_733_0 and arg_730_1.time_ < 0 + var_733_0 + arg_733_0 and not isNil(arg_730_1.actors_["10058ui_story"]) and arg_730_1.var_.characterEffect10058ui_story then
				arg_730_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_730_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_733_1 = 0
			local var_733_2 = 0.65

			if 0 < arg_730_1.time_ and arg_730_1.time_ <= var_733_1 + arg_733_0 then
				arg_730_1.talkMaxDuration = 0
				arg_730_1.dialogCg_.alpha = 1

				arg_730_1.dialog_:SetActive(true)
				SetActive(arg_730_1.leftNameGo_, true)

				arg_730_1.leftNameTxt_.text = arg_730_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_730_1.leftNameTxt_.transform)

				arg_730_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_730_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_730_1:RecordName(arg_730_1.leftNameTxt_.text)
				SetActive(arg_730_1.iconTrs_.gameObject, true)
				arg_730_1.iconController_:SetSelectedState("hero")

				arg_730_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_730_1.callingController_:SetSelectedState("normal")

				arg_730_1.keyicon_.color = Color.New(1, 1, 1)
				arg_730_1.icon_.color = Color.New(1, 1, 1)

				local var_733_3 = arg_730_1:FormatText(arg_730_1:GetWordFromCfg(1109511180).content)

				arg_730_1.text_.text = var_733_3

				LuaForUtil.ClearLinePrefixSymbol(arg_730_1.text_)

				local var_733_5 = 26 <= 0 and var_733_2 or var_733_2 * (utf8.len(var_733_3) / 26)

				if (26 <= 0 and var_733_2 or var_733_2 * (utf8.len(var_733_3) / 26)) > 0 and var_733_2 < var_733_5 then
					arg_730_1.talkMaxDuration = var_733_5

					if var_733_5 + var_733_1 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_5 + var_733_1
					end
				end

				arg_730_1.text_.text = var_733_3
				arg_730_1.typewritter.percent = 0

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(false)
				arg_730_1:RecordContent(arg_730_1.text_.text)
			end

			local var_733_6 = math.max(var_733_2, arg_730_1.talkMaxDuration)

			if var_733_1 <= arg_730_1.time_ and arg_730_1.time_ < var_733_1 + var_733_6 then
				arg_730_1.typewritter.percent = (arg_730_1.time_ - var_733_1) / var_733_6

				arg_730_1.typewritter:SetDirty()
			end

			if arg_730_1.time_ >= var_733_1 + var_733_6 and arg_730_1.time_ < var_733_1 + var_733_6 + arg_733_0 then
				arg_730_1.typewritter.percent = 1

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(true)
			end
		end

		arg_730_1.nodeConfigList_ = {}

		arg_730_1:InitPlayNodeList()
	end,
	Play1109511181 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 1109511181
		arg_734_1.duration_ = 9.1

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play1109511182(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 and not isNil(arg_734_1.actors_["10058ui_story"]) and arg_734_1.var_.characterEffect10058ui_story == nil then
				arg_734_1.var_.characterEffect10058ui_story = arg_734_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_737_0 = 0.200000002980232

			if 0 <= arg_734_1.time_ and arg_734_1.time_ < 0 + var_737_0 and not isNil(arg_734_1.actors_["10058ui_story"]) then
				if arg_734_1.var_.characterEffect10058ui_story and not isNil(arg_734_1.actors_["10058ui_story"]) then
					arg_734_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_734_1.time_ >= 0 + var_737_0 and arg_734_1.time_ < 0 + var_737_0 + arg_737_0 and not isNil(arg_734_1.actors_["10058ui_story"]) and arg_734_1.var_.characterEffect10058ui_story then
				arg_734_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 then
				arg_734_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= 0 + arg_737_0 then
				arg_734_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_737_2 = 0
			local var_737_3 = 0.95

			if 0 < arg_734_1.time_ and arg_734_1.time_ <= var_737_2 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				arg_734_1.leftNameTxt_.text = arg_734_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, false)
				arg_734_1.callingController_:SetSelectedState("normal")

				local var_737_4 = arg_734_1:GetWordFromCfg(1109511181)
				local var_737_5 = arg_734_1:FormatText(var_737_4.content)

				arg_734_1.text_.text = var_737_5

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_7 = 38 <= 0 and var_737_3 or var_737_3 * (utf8.len(var_737_5) / 38)

				if (38 <= 0 and var_737_3 or var_737_3 * (utf8.len(var_737_5) / 38)) > 0 and var_737_3 < var_737_7 then
					arg_734_1.talkMaxDuration = var_737_7

					if var_737_7 + var_737_2 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_7 + var_737_2
					end
				end

				arg_734_1.text_.text = var_737_5
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb") ~= 0 then
					local var_737_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb") / 1000

					if var_737_8 + var_737_2 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_8 + var_737_2
					end

					if var_737_4.prefab_name ~= "" and arg_734_1.actors_[var_737_4.prefab_name] ~= nil then
						local var_737_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_734_1.actors_[var_737_4.prefab_name].transform, "story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb")

						arg_734_1:RecordAudio("1109511181", var_737_9)
						arg_734_1:RecordAudio("1109511181", var_737_9)
					else
						arg_734_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb")
					end

					arg_734_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511181", "story_v_side_new_1109511.awb")
				end

				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_10 = math.max(var_737_3, arg_734_1.talkMaxDuration)

			if var_737_2 <= arg_734_1.time_ and arg_734_1.time_ < var_737_2 + var_737_10 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - var_737_2) / var_737_10

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= var_737_2 + var_737_10 and arg_734_1.time_ < var_737_2 + var_737_10 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play1109511182 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1109511182
		arg_738_1.duration_ = 5

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1109511183(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			if 0 < arg_738_1.time_ and arg_738_1.time_ <= 0 + arg_741_0 and not isNil(arg_738_1.actors_["10058ui_story"]) and arg_738_1.var_.characterEffect10058ui_story == nil then
				arg_738_1.var_.characterEffect10058ui_story = arg_738_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_741_0 = 0.200000002980232

			if 0 <= arg_738_1.time_ and arg_738_1.time_ < 0 + var_741_0 and not isNil(arg_738_1.actors_["10058ui_story"]) then
				if arg_738_1.var_.characterEffect10058ui_story and not isNil(arg_738_1.actors_["10058ui_story"]) then
					arg_738_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_738_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_738_1.time_ - 0) / var_741_0)
				end
			end

			if arg_738_1.time_ >= 0 + var_741_0 and arg_738_1.time_ < 0 + var_741_0 + arg_741_0 and not isNil(arg_738_1.actors_["10058ui_story"]) and arg_738_1.var_.characterEffect10058ui_story then
				arg_738_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_738_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_741_1 = 0
			local var_741_2 = 0.85

			if 0 < arg_738_1.time_ and arg_738_1.time_ <= var_741_1 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, true)

				arg_738_1.leftNameTxt_.text = arg_738_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_738_1.leftNameTxt_.transform)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1.leftNameTxt_.text)
				SetActive(arg_738_1.iconTrs_.gameObject, true)
				arg_738_1.iconController_:SetSelectedState("hero")

				arg_738_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_738_1.callingController_:SetSelectedState("normal")

				arg_738_1.keyicon_.color = Color.New(1, 1, 1)
				arg_738_1.icon_.color = Color.New(1, 1, 1)

				local var_741_3 = arg_738_1:FormatText(arg_738_1:GetWordFromCfg(1109511182).content)

				arg_738_1.text_.text = var_741_3

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_5 = 34 <= 0 and var_741_2 or var_741_2 * (utf8.len(var_741_3) / 34)

				if (34 <= 0 and var_741_2 or var_741_2 * (utf8.len(var_741_3) / 34)) > 0 and var_741_2 < var_741_5 then
					arg_738_1.talkMaxDuration = var_741_5

					if var_741_5 + var_741_1 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_5 + var_741_1
					end
				end

				arg_738_1.text_.text = var_741_3
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)
				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_6 = math.max(var_741_2, arg_738_1.talkMaxDuration)

			if var_741_1 <= arg_738_1.time_ and arg_738_1.time_ < var_741_1 + var_741_6 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - var_741_1) / var_741_6

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= var_741_1 + var_741_6 and arg_738_1.time_ < var_741_1 + var_741_6 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {}

		arg_738_1:InitPlayNodeList()
	end,
	Play1109511183 = function(arg_742_0, arg_742_1)
		arg_742_1.time_ = 0
		arg_742_1.frameCnt_ = 0
		arg_742_1.state_ = "playing"
		arg_742_1.curTalkId_ = 1109511183
		arg_742_1.duration_ = 5

		SetActive(arg_742_1.tipsGo_, false)

		function arg_742_1.onSingleLineFinish_()
			arg_742_1.onSingleLineUpdate_ = nil
			arg_742_1.onSingleLineFinish_ = nil
			arg_742_1.state_ = "waiting"
		end

		function arg_742_1.playNext_(arg_744_0)
			if arg_744_0 == 1 then
				arg_742_0:Play1109511184(arg_742_1)
			end
		end

		function arg_742_1.onSingleLineUpdate_(arg_745_0)
			local var_745_0 = 0.575

			if 0 < arg_742_1.time_ and arg_742_1.time_ <= 0 + arg_745_0 then
				arg_742_1.talkMaxDuration = 0
				arg_742_1.dialogCg_.alpha = 1

				arg_742_1.dialog_:SetActive(true)
				SetActive(arg_742_1.leftNameGo_, true)

				arg_742_1.leftNameTxt_.text = arg_742_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_742_1.leftNameTxt_.transform)

				arg_742_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_742_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_742_1:RecordName(arg_742_1.leftNameTxt_.text)
				SetActive(arg_742_1.iconTrs_.gameObject, true)
				arg_742_1.iconController_:SetSelectedState("hero")

				arg_742_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_742_1.callingController_:SetSelectedState("normal")

				arg_742_1.keyicon_.color = Color.New(1, 1, 1)
				arg_742_1.icon_.color = Color.New(1, 1, 1)

				local var_745_1 = arg_742_1:FormatText(arg_742_1:GetWordFromCfg(1109511183).content)

				arg_742_1.text_.text = var_745_1

				LuaForUtil.ClearLinePrefixSymbol(arg_742_1.text_)

				local var_745_3 = 23 <= 0 and var_745_0 or var_745_0 * (utf8.len(var_745_1) / 23)

				if (23 <= 0 and var_745_0 or var_745_0 * (utf8.len(var_745_1) / 23)) > 0 and var_745_0 < var_745_3 then
					arg_742_1.talkMaxDuration = var_745_3

					if var_745_3 + 0 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_3 + 0
					end
				end

				arg_742_1.text_.text = var_745_1
				arg_742_1.typewritter.percent = 0

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(false)
				arg_742_1:RecordContent(arg_742_1.text_.text)
			end

			local var_745_4 = math.max(var_745_0, arg_742_1.talkMaxDuration)

			if 0 <= arg_742_1.time_ and arg_742_1.time_ < 0 + var_745_4 then
				arg_742_1.typewritter.percent = (arg_742_1.time_ - 0) / var_745_4

				arg_742_1.typewritter:SetDirty()
			end

			if arg_742_1.time_ >= 0 + var_745_4 and arg_742_1.time_ < 0 + var_745_4 + arg_745_0 then
				arg_742_1.typewritter.percent = 1

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(true)
			end
		end

		arg_742_1.nodeConfigList_ = {}

		arg_742_1:InitPlayNodeList()
	end,
	Play1109511184 = function(arg_746_0, arg_746_1)
		arg_746_1.time_ = 0
		arg_746_1.frameCnt_ = 0
		arg_746_1.state_ = "playing"
		arg_746_1.curTalkId_ = 1109511184
		arg_746_1.duration_ = 5

		SetActive(arg_746_1.tipsGo_, false)

		function arg_746_1.onSingleLineFinish_()
			arg_746_1.onSingleLineUpdate_ = nil
			arg_746_1.onSingleLineFinish_ = nil
			arg_746_1.state_ = "waiting"
		end

		function arg_746_1.playNext_(arg_748_0)
			if arg_748_0 == 1 then
				arg_746_0:Play1109511185(arg_746_1)
			end
		end

		function arg_746_1.onSingleLineUpdate_(arg_749_0)
			if 0 < arg_746_1.time_ and arg_746_1.time_ <= 0 + arg_749_0 then
				arg_746_1.var_.moveOldPos10058ui_story = arg_746_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_749_0 = 0.001

			if 0 <= arg_746_1.time_ and arg_746_1.time_ < 0 + var_749_0 then
				arg_746_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_746_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_746_1.time_ - 0) / var_749_0)
				arg_746_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_746_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_746_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_746_1.actors_["10058ui_story"].transform.position).z)
				arg_746_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_746_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_746_1.actors_["10058ui_story"].transform.localEulerAngles = arg_746_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_746_1.time_ >= 0 + var_749_0 and arg_746_1.time_ < 0 + var_749_0 + arg_749_0 then
				arg_746_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_746_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_746_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_746_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_746_1.actors_["10058ui_story"].transform.position).z)
				arg_746_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_746_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_746_1.actors_["10058ui_story"].transform.localEulerAngles = arg_746_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if 1 < arg_746_1.time_ and arg_746_1.time_ <= 1 + arg_749_0 then
				arg_746_1:AudioAction("play", "effect", "se_story_143", "se_story_143_foley_cloth02", "")
			end

			local var_749_2 = 0
			local var_749_3 = 0.75

			if 0 < arg_746_1.time_ and arg_746_1.time_ <= var_749_2 + arg_749_0 then
				arg_746_1.talkMaxDuration = 0
				arg_746_1.dialogCg_.alpha = 1

				arg_746_1.dialog_:SetActive(true)
				SetActive(arg_746_1.leftNameGo_, false)

				arg_746_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_746_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_746_1:RecordName(arg_746_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_746_1.iconTrs_.gameObject, false)
				arg_746_1.callingController_:SetSelectedState("normal")

				local var_749_4 = arg_746_1:FormatText(arg_746_1:GetWordFromCfg(1109511184).content)

				arg_746_1.text_.text = var_749_4

				LuaForUtil.ClearLinePrefixSymbol(arg_746_1.text_)

				local var_749_6 = 30 <= 0 and var_749_3 or var_749_3 * (utf8.len(var_749_4) / 30)

				if (30 <= 0 and var_749_3 or var_749_3 * (utf8.len(var_749_4) / 30)) > 0 and var_749_3 < var_749_6 then
					arg_746_1.talkMaxDuration = var_749_6

					if var_749_6 + var_749_2 > arg_746_1.duration_ then
						arg_746_1.duration_ = var_749_6 + var_749_2
					end
				end

				arg_746_1.text_.text = var_749_4
				arg_746_1.typewritter.percent = 0

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(false)
				arg_746_1:RecordContent(arg_746_1.text_.text)
			end

			local var_749_7 = math.max(var_749_3, arg_746_1.talkMaxDuration)

			if var_749_2 <= arg_746_1.time_ and arg_746_1.time_ < var_749_2 + var_749_7 then
				arg_746_1.typewritter.percent = (arg_746_1.time_ - var_749_2) / var_749_7

				arg_746_1.typewritter:SetDirty()
			end

			if arg_746_1.time_ >= var_749_2 + var_749_7 and arg_746_1.time_ < var_749_2 + var_749_7 + arg_749_0 then
				arg_746_1.typewritter.percent = 1

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(true)
			end
		end

		arg_746_1.nodeConfigList_ = {
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

		arg_746_1:InitPlayNodeList()
	end,
	Play1109511185 = function(arg_750_0, arg_750_1)
		arg_750_1.time_ = 0
		arg_750_1.frameCnt_ = 0
		arg_750_1.state_ = "playing"
		arg_750_1.curTalkId_ = 1109511185
		arg_750_1.duration_ = 6.13

		SetActive(arg_750_1.tipsGo_, false)

		function arg_750_1.onSingleLineFinish_()
			arg_750_1.onSingleLineUpdate_ = nil
			arg_750_1.onSingleLineFinish_ = nil
			arg_750_1.state_ = "waiting"
		end

		function arg_750_1.playNext_(arg_752_0)
			if arg_752_0 == 1 then
				arg_750_0:Play1109511186(arg_750_1)
			end
		end

		function arg_750_1.onSingleLineUpdate_(arg_753_0)
			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 and not isNil(arg_750_1.actors_["10058ui_story"]) and arg_750_1.var_.characterEffect10058ui_story == nil then
				arg_750_1.var_.characterEffect10058ui_story = arg_750_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_753_0 = 0.200000002980232

			if 0 <= arg_750_1.time_ and arg_750_1.time_ < 0 + var_753_0 and not isNil(arg_750_1.actors_["10058ui_story"]) then
				if arg_750_1.var_.characterEffect10058ui_story and not isNil(arg_750_1.actors_["10058ui_story"]) then
					arg_750_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_750_1.time_ >= 0 + var_753_0 and arg_750_1.time_ < 0 + var_753_0 + arg_753_0 and not isNil(arg_750_1.actors_["10058ui_story"]) and arg_750_1.var_.characterEffect10058ui_story then
				arg_750_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_753_2 = arg_750_1.actors_["10058ui_story"].transform

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1.var_.moveOldPos10058ui_story = var_753_2.localPosition
			end

			local var_753_3 = 0.001

			if 0 <= arg_750_1.time_ and arg_750_1.time_ < 0 + var_753_3 then
				var_753_2.localPosition = Vector3.Lerp(arg_750_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_750_1.time_ - 0) / var_753_3)
				var_753_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_753_2.position).x, (manager.ui.mainCamera.transform.position - var_753_2.position).y, (manager.ui.mainCamera.transform.position - var_753_2.position).z)
				var_753_2.localEulerAngles.z = 0
				var_753_2.localEulerAngles.x = 0
				var_753_2.localEulerAngles = var_753_2.localEulerAngles
			end

			if arg_750_1.time_ >= 0 + var_753_3 and arg_750_1.time_ < 0 + var_753_3 + arg_753_0 then
				var_753_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_753_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_753_2.position).x, (manager.ui.mainCamera.transform.position - var_753_2.position).y, (manager.ui.mainCamera.transform.position - var_753_2.position).z)
				var_753_2.localEulerAngles.z = 0
				var_753_2.localEulerAngles.x = 0
				var_753_2.localEulerAngles = var_753_2.localEulerAngles
			end

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= 0 + arg_753_0 then
				arg_750_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_753_4 = 0
			local var_753_5 = 0.6

			if 0 < arg_750_1.time_ and arg_750_1.time_ <= var_753_4 + arg_753_0 then
				arg_750_1.talkMaxDuration = 0
				arg_750_1.dialogCg_.alpha = 1

				arg_750_1.dialog_:SetActive(true)
				SetActive(arg_750_1.leftNameGo_, true)

				arg_750_1.leftNameTxt_.text = arg_750_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_750_1.leftNameTxt_.transform)

				arg_750_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_750_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_750_1:RecordName(arg_750_1.leftNameTxt_.text)
				SetActive(arg_750_1.iconTrs_.gameObject, false)
				arg_750_1.callingController_:SetSelectedState("normal")

				local var_753_6 = arg_750_1:GetWordFromCfg(1109511185)
				local var_753_7 = arg_750_1:FormatText(var_753_6.content)

				arg_750_1.text_.text = var_753_7

				LuaForUtil.ClearLinePrefixSymbol(arg_750_1.text_)

				local var_753_9 = 24 <= 0 and var_753_5 or var_753_5 * (utf8.len(var_753_7) / 24)

				if (24 <= 0 and var_753_5 or var_753_5 * (utf8.len(var_753_7) / 24)) > 0 and var_753_5 < var_753_9 then
					arg_750_1.talkMaxDuration = var_753_9

					if var_753_9 + var_753_4 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_9 + var_753_4
					end
				end

				arg_750_1.text_.text = var_753_7
				arg_750_1.typewritter.percent = 0

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb") ~= 0 then
					local var_753_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb") / 1000

					if var_753_10 + var_753_4 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_10 + var_753_4
					end

					if var_753_6.prefab_name ~= "" and arg_750_1.actors_[var_753_6.prefab_name] ~= nil then
						local var_753_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_750_1.actors_[var_753_6.prefab_name].transform, "story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb")

						arg_750_1:RecordAudio("1109511185", var_753_11)
						arg_750_1:RecordAudio("1109511185", var_753_11)
					else
						arg_750_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb")
					end

					arg_750_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511185", "story_v_side_new_1109511.awb")
				end

				arg_750_1:RecordContent(arg_750_1.text_.text)
			end

			local var_753_12 = math.max(var_753_5, arg_750_1.talkMaxDuration)

			if var_753_4 <= arg_750_1.time_ and arg_750_1.time_ < var_753_4 + var_753_12 then
				arg_750_1.typewritter.percent = (arg_750_1.time_ - var_753_4) / var_753_12

				arg_750_1.typewritter:SetDirty()
			end

			if arg_750_1.time_ >= var_753_4 + var_753_12 and arg_750_1.time_ < var_753_4 + var_753_12 + arg_753_0 then
				arg_750_1.typewritter.percent = 1

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(true)
			end
		end

		arg_750_1.nodeConfigList_ = {
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

		arg_750_1:InitPlayNodeList()
	end,
	Play1109511186 = function(arg_754_0, arg_754_1)
		arg_754_1.time_ = 0
		arg_754_1.frameCnt_ = 0
		arg_754_1.state_ = "playing"
		arg_754_1.curTalkId_ = 1109511186
		arg_754_1.duration_ = 5

		SetActive(arg_754_1.tipsGo_, false)

		function arg_754_1.onSingleLineFinish_()
			arg_754_1.onSingleLineUpdate_ = nil
			arg_754_1.onSingleLineFinish_ = nil
			arg_754_1.state_ = "waiting"
		end

		function arg_754_1.playNext_(arg_756_0)
			if arg_756_0 == 1 then
				arg_754_0:Play1109511187(arg_754_1)
			end
		end

		function arg_754_1.onSingleLineUpdate_(arg_757_0)
			if 0 < arg_754_1.time_ and arg_754_1.time_ <= 0 + arg_757_0 and not isNil(arg_754_1.actors_["10058ui_story"]) and arg_754_1.var_.characterEffect10058ui_story == nil then
				arg_754_1.var_.characterEffect10058ui_story = arg_754_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_757_0 = 0.200000002980232

			if 0 <= arg_754_1.time_ and arg_754_1.time_ < 0 + var_757_0 and not isNil(arg_754_1.actors_["10058ui_story"]) then
				if arg_754_1.var_.characterEffect10058ui_story and not isNil(arg_754_1.actors_["10058ui_story"]) then
					arg_754_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_754_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_754_1.time_ - 0) / var_757_0)
				end
			end

			if arg_754_1.time_ >= 0 + var_757_0 and arg_754_1.time_ < 0 + var_757_0 + arg_757_0 and not isNil(arg_754_1.actors_["10058ui_story"]) and arg_754_1.var_.characterEffect10058ui_story then
				arg_754_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_754_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_757_1 = 0
			local var_757_2 = 0.975

			if 0 < arg_754_1.time_ and arg_754_1.time_ <= var_757_1 + arg_757_0 then
				arg_754_1.talkMaxDuration = 0
				arg_754_1.dialogCg_.alpha = 1

				arg_754_1.dialog_:SetActive(true)
				SetActive(arg_754_1.leftNameGo_, true)

				arg_754_1.leftNameTxt_.text = arg_754_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_754_1.leftNameTxt_.transform)

				arg_754_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_754_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_754_1:RecordName(arg_754_1.leftNameTxt_.text)
				SetActive(arg_754_1.iconTrs_.gameObject, true)
				arg_754_1.iconController_:SetSelectedState("hero")

				arg_754_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_754_1.callingController_:SetSelectedState("normal")

				arg_754_1.keyicon_.color = Color.New(1, 1, 1)
				arg_754_1.icon_.color = Color.New(1, 1, 1)

				local var_757_3 = arg_754_1:FormatText(arg_754_1:GetWordFromCfg(1109511186).content)

				arg_754_1.text_.text = var_757_3

				LuaForUtil.ClearLinePrefixSymbol(arg_754_1.text_)

				local var_757_5 = 39 <= 0 and var_757_2 or var_757_2 * (utf8.len(var_757_3) / 39)

				if (39 <= 0 and var_757_2 or var_757_2 * (utf8.len(var_757_3) / 39)) > 0 and var_757_2 < var_757_5 then
					arg_754_1.talkMaxDuration = var_757_5

					if var_757_5 + var_757_1 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_5 + var_757_1
					end
				end

				arg_754_1.text_.text = var_757_3
				arg_754_1.typewritter.percent = 0

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(false)
				arg_754_1:RecordContent(arg_754_1.text_.text)
			end

			local var_757_6 = math.max(var_757_2, arg_754_1.talkMaxDuration)

			if var_757_1 <= arg_754_1.time_ and arg_754_1.time_ < var_757_1 + var_757_6 then
				arg_754_1.typewritter.percent = (arg_754_1.time_ - var_757_1) / var_757_6

				arg_754_1.typewritter:SetDirty()
			end

			if arg_754_1.time_ >= var_757_1 + var_757_6 and arg_754_1.time_ < var_757_1 + var_757_6 + arg_757_0 then
				arg_754_1.typewritter.percent = 1

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(true)
			end
		end

		arg_754_1.nodeConfigList_ = {}

		arg_754_1:InitPlayNodeList()
	end,
	Play1109511187 = function(arg_758_0, arg_758_1)
		arg_758_1.time_ = 0
		arg_758_1.frameCnt_ = 0
		arg_758_1.state_ = "playing"
		arg_758_1.curTalkId_ = 1109511187
		arg_758_1.duration_ = 2.33

		SetActive(arg_758_1.tipsGo_, false)

		function arg_758_1.onSingleLineFinish_()
			arg_758_1.onSingleLineUpdate_ = nil
			arg_758_1.onSingleLineFinish_ = nil
			arg_758_1.state_ = "waiting"
		end

		function arg_758_1.playNext_(arg_760_0)
			if arg_760_0 == 1 then
				arg_758_0:Play1109511188(arg_758_1)
			end
		end

		function arg_758_1.onSingleLineUpdate_(arg_761_0)
			if 0 < arg_758_1.time_ and arg_758_1.time_ <= 0 + arg_761_0 and not isNil(arg_758_1.actors_["10058ui_story"]) and arg_758_1.var_.characterEffect10058ui_story == nil then
				arg_758_1.var_.characterEffect10058ui_story = arg_758_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_761_0 = 0.200000002980232

			if 0 <= arg_758_1.time_ and arg_758_1.time_ < 0 + var_761_0 and not isNil(arg_758_1.actors_["10058ui_story"]) then
				if arg_758_1.var_.characterEffect10058ui_story and not isNil(arg_758_1.actors_["10058ui_story"]) then
					arg_758_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_758_1.time_ >= 0 + var_761_0 and arg_758_1.time_ < 0 + var_761_0 + arg_761_0 and not isNil(arg_758_1.actors_["10058ui_story"]) and arg_758_1.var_.characterEffect10058ui_story then
				arg_758_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_761_2 = 0
			local var_761_3 = 0.15

			if 0 < arg_758_1.time_ and arg_758_1.time_ <= var_761_2 + arg_761_0 then
				arg_758_1.talkMaxDuration = 0
				arg_758_1.dialogCg_.alpha = 1

				arg_758_1.dialog_:SetActive(true)
				SetActive(arg_758_1.leftNameGo_, true)

				arg_758_1.leftNameTxt_.text = arg_758_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_758_1.leftNameTxt_.transform)

				arg_758_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_758_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_758_1:RecordName(arg_758_1.leftNameTxt_.text)
				SetActive(arg_758_1.iconTrs_.gameObject, false)
				arg_758_1.callingController_:SetSelectedState("normal")

				local var_761_4 = arg_758_1:GetWordFromCfg(1109511187)
				local var_761_5 = arg_758_1:FormatText(var_761_4.content)

				arg_758_1.text_.text = var_761_5

				LuaForUtil.ClearLinePrefixSymbol(arg_758_1.text_)

				local var_761_7 = 6 <= 0 and var_761_3 or var_761_3 * (utf8.len(var_761_5) / 6)

				if (6 <= 0 and var_761_3 or var_761_3 * (utf8.len(var_761_5) / 6)) > 0 and var_761_3 < var_761_7 then
					arg_758_1.talkMaxDuration = var_761_7

					if var_761_7 + var_761_2 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_7 + var_761_2
					end
				end

				arg_758_1.text_.text = var_761_5
				arg_758_1.typewritter.percent = 0

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb") ~= 0 then
					local var_761_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb") / 1000

					if var_761_8 + var_761_2 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_8 + var_761_2
					end

					if var_761_4.prefab_name ~= "" and arg_758_1.actors_[var_761_4.prefab_name] ~= nil then
						local var_761_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_758_1.actors_[var_761_4.prefab_name].transform, "story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb")

						arg_758_1:RecordAudio("1109511187", var_761_9)
						arg_758_1:RecordAudio("1109511187", var_761_9)
					else
						arg_758_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb")
					end

					arg_758_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511187", "story_v_side_new_1109511.awb")
				end

				arg_758_1:RecordContent(arg_758_1.text_.text)
			end

			local var_761_10 = math.max(var_761_3, arg_758_1.talkMaxDuration)

			if var_761_2 <= arg_758_1.time_ and arg_758_1.time_ < var_761_2 + var_761_10 then
				arg_758_1.typewritter.percent = (arg_758_1.time_ - var_761_2) / var_761_10

				arg_758_1.typewritter:SetDirty()
			end

			if arg_758_1.time_ >= var_761_2 + var_761_10 and arg_758_1.time_ < var_761_2 + var_761_10 + arg_761_0 then
				arg_758_1.typewritter.percent = 1

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(true)
			end
		end

		arg_758_1.nodeConfigList_ = {}

		arg_758_1:InitPlayNodeList()
	end,
	Play1109511188 = function(arg_762_0, arg_762_1)
		arg_762_1.time_ = 0
		arg_762_1.frameCnt_ = 0
		arg_762_1.state_ = "playing"
		arg_762_1.curTalkId_ = 1109511188
		arg_762_1.duration_ = 5

		SetActive(arg_762_1.tipsGo_, false)

		function arg_762_1.onSingleLineFinish_()
			arg_762_1.onSingleLineUpdate_ = nil
			arg_762_1.onSingleLineFinish_ = nil
			arg_762_1.state_ = "waiting"
		end

		function arg_762_1.playNext_(arg_764_0)
			if arg_764_0 == 1 then
				arg_762_0:Play1109511189(arg_762_1)
			end
		end

		function arg_762_1.onSingleLineUpdate_(arg_765_0)
			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 and not isNil(arg_762_1.actors_["10058ui_story"]) and arg_762_1.var_.characterEffect10058ui_story == nil then
				arg_762_1.var_.characterEffect10058ui_story = arg_762_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_765_0 = 0.200000002980232

			if 0 <= arg_762_1.time_ and arg_762_1.time_ < 0 + var_765_0 and not isNil(arg_762_1.actors_["10058ui_story"]) then
				if arg_762_1.var_.characterEffect10058ui_story and not isNil(arg_762_1.actors_["10058ui_story"]) then
					arg_762_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_762_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_762_1.time_ - 0) / var_765_0)
				end
			end

			if arg_762_1.time_ >= 0 + var_765_0 and arg_762_1.time_ < 0 + var_765_0 + arg_765_0 and not isNil(arg_762_1.actors_["10058ui_story"]) and arg_762_1.var_.characterEffect10058ui_story then
				arg_762_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_762_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_765_1 = arg_762_1.actors_["10058ui_story"].transform

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= 0 + arg_765_0 then
				arg_762_1.var_.moveOldPos10058ui_story = var_765_1.localPosition
			end

			local var_765_2 = 0.001

			if 0 <= arg_762_1.time_ and arg_762_1.time_ < 0 + var_765_2 then
				var_765_1.localPosition = Vector3.Lerp(arg_762_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_762_1.time_ - 0) / var_765_2)
				var_765_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_765_1.position).x, (manager.ui.mainCamera.transform.position - var_765_1.position).y, (manager.ui.mainCamera.transform.position - var_765_1.position).z)
				var_765_1.localEulerAngles.z = 0
				var_765_1.localEulerAngles.x = 0
				var_765_1.localEulerAngles = var_765_1.localEulerAngles
			end

			if arg_762_1.time_ >= 0 + var_765_2 and arg_762_1.time_ < 0 + var_765_2 + arg_765_0 then
				var_765_1.localPosition = Vector3.New(0, 100, 0)
				var_765_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_765_1.position).x, (manager.ui.mainCamera.transform.position - var_765_1.position).y, (manager.ui.mainCamera.transform.position - var_765_1.position).z)
				var_765_1.localEulerAngles.z = 0
				var_765_1.localEulerAngles.x = 0
				var_765_1.localEulerAngles = var_765_1.localEulerAngles
			end

			if 0.5 < arg_762_1.time_ and arg_762_1.time_ <= 0.5 + arg_765_0 then
				arg_762_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clap01", "")
			end

			local var_765_4 = 0
			local var_765_5 = 1.025

			if 0 < arg_762_1.time_ and arg_762_1.time_ <= var_765_4 + arg_765_0 then
				arg_762_1.talkMaxDuration = 0
				arg_762_1.dialogCg_.alpha = 1

				arg_762_1.dialog_:SetActive(true)
				SetActive(arg_762_1.leftNameGo_, false)

				arg_762_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_762_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_762_1:RecordName(arg_762_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_762_1.iconTrs_.gameObject, false)
				arg_762_1.callingController_:SetSelectedState("normal")

				local var_765_6 = arg_762_1:FormatText(arg_762_1:GetWordFromCfg(1109511188).content)

				arg_762_1.text_.text = var_765_6

				LuaForUtil.ClearLinePrefixSymbol(arg_762_1.text_)

				local var_765_8 = 41 <= 0 and var_765_5 or var_765_5 * (utf8.len(var_765_6) / 41)

				if (41 <= 0 and var_765_5 or var_765_5 * (utf8.len(var_765_6) / 41)) > 0 and var_765_5 < var_765_8 then
					arg_762_1.talkMaxDuration = var_765_8

					if var_765_8 + var_765_4 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_8 + var_765_4
					end
				end

				arg_762_1.text_.text = var_765_6
				arg_762_1.typewritter.percent = 0

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(false)
				arg_762_1:RecordContent(arg_762_1.text_.text)
			end

			local var_765_9 = math.max(var_765_5, arg_762_1.talkMaxDuration)

			if var_765_4 <= arg_762_1.time_ and arg_762_1.time_ < var_765_4 + var_765_9 then
				arg_762_1.typewritter.percent = (arg_762_1.time_ - var_765_4) / var_765_9

				arg_762_1.typewritter:SetDirty()
			end

			if arg_762_1.time_ >= var_765_4 + var_765_9 and arg_762_1.time_ < var_765_4 + var_765_9 + arg_765_0 then
				arg_762_1.typewritter.percent = 1

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(true)
			end
		end

		arg_762_1.nodeConfigList_ = {
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

		arg_762_1:InitPlayNodeList()
	end,
	Play1109511189 = function(arg_766_0, arg_766_1)
		arg_766_1.time_ = 0
		arg_766_1.frameCnt_ = 0
		arg_766_1.state_ = "playing"
		arg_766_1.curTalkId_ = 1109511189
		arg_766_1.duration_ = 5

		SetActive(arg_766_1.tipsGo_, false)

		function arg_766_1.onSingleLineFinish_()
			arg_766_1.onSingleLineUpdate_ = nil
			arg_766_1.onSingleLineFinish_ = nil
			arg_766_1.state_ = "waiting"
		end

		function arg_766_1.playNext_(arg_768_0)
			if arg_768_0 == 1 then
				arg_766_0:Play1109511190(arg_766_1)
			end
		end

		function arg_766_1.onSingleLineUpdate_(arg_769_0)
			local var_769_0 = 0.05

			if 0 < arg_766_1.time_ and arg_766_1.time_ <= 0 + arg_769_0 then
				arg_766_1.talkMaxDuration = 0
				arg_766_1.dialogCg_.alpha = 1

				arg_766_1.dialog_:SetActive(true)
				SetActive(arg_766_1.leftNameGo_, true)

				arg_766_1.leftNameTxt_.text = arg_766_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_766_1.leftNameTxt_.transform)

				arg_766_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_766_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_766_1:RecordName(arg_766_1.leftNameTxt_.text)
				SetActive(arg_766_1.iconTrs_.gameObject, true)
				arg_766_1.iconController_:SetSelectedState("hero")

				arg_766_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_766_1.callingController_:SetSelectedState("normal")

				arg_766_1.keyicon_.color = Color.New(1, 1, 1)
				arg_766_1.icon_.color = Color.New(1, 1, 1)

				local var_769_1 = arg_766_1:FormatText(arg_766_1:GetWordFromCfg(1109511189).content)

				arg_766_1.text_.text = var_769_1

				LuaForUtil.ClearLinePrefixSymbol(arg_766_1.text_)

				local var_769_3 = 2 <= 0 and var_769_0 or var_769_0 * (utf8.len(var_769_1) / 2)

				if (2 <= 0 and var_769_0 or var_769_0 * (utf8.len(var_769_1) / 2)) > 0 and var_769_0 < var_769_3 then
					arg_766_1.talkMaxDuration = var_769_3

					if var_769_3 + 0 > arg_766_1.duration_ then
						arg_766_1.duration_ = var_769_3 + 0
					end
				end

				arg_766_1.text_.text = var_769_1
				arg_766_1.typewritter.percent = 0

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(false)
				arg_766_1:RecordContent(arg_766_1.text_.text)
			end

			local var_769_4 = math.max(var_769_0, arg_766_1.talkMaxDuration)

			if 0 <= arg_766_1.time_ and arg_766_1.time_ < 0 + var_769_4 then
				arg_766_1.typewritter.percent = (arg_766_1.time_ - 0) / var_769_4

				arg_766_1.typewritter:SetDirty()
			end

			if arg_766_1.time_ >= 0 + var_769_4 and arg_766_1.time_ < 0 + var_769_4 + arg_769_0 then
				arg_766_1.typewritter.percent = 1

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(true)
			end
		end

		arg_766_1.nodeConfigList_ = {}

		arg_766_1:InitPlayNodeList()
	end,
	Play1109511190 = function(arg_770_0, arg_770_1)
		arg_770_1.time_ = 0
		arg_770_1.frameCnt_ = 0
		arg_770_1.state_ = "playing"
		arg_770_1.curTalkId_ = 1109511190
		arg_770_1.duration_ = 8.32

		SetActive(arg_770_1.tipsGo_, false)

		function arg_770_1.onSingleLineFinish_()
			arg_770_1.onSingleLineUpdate_ = nil
			arg_770_1.onSingleLineFinish_ = nil
			arg_770_1.state_ = "waiting"
		end

		function arg_770_1.playNext_(arg_772_0)
			if arg_772_0 == 1 then
				arg_770_0:Play1109511191(arg_770_1)
			end
		end

		function arg_770_1.onSingleLineUpdate_(arg_773_0)
			if 1.58333333333333 < arg_770_1.time_ and arg_770_1.time_ <= 1.58333333333333 + arg_773_0 then
				local var_773_0 = arg_770_1.bgs_.ST0104

				arg_770_1.bgs_.ST0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_773_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_773_1 = var_773_0:GetComponent("SpriteRenderer")

				if var_773_1 and var_773_1.sprite then
					local var_773_2 = 2 * (var_773_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_773_0.transform.localScale = Vector3.New(var_773_2 / var_773_1.sprite.bounds.size.y < var_773_2 * manager.ui.mainCameraCom_.aspect / var_773_1.sprite.bounds.size.x and var_773_2 * manager.ui.mainCameraCom_.aspect / var_773_1.sprite.bounds.size.x or var_773_2 / var_773_1.sprite.bounds.size.y, var_773_2 / var_773_1.sprite.bounds.size.y < var_773_2 * manager.ui.mainCameraCom_.aspect / var_773_1.sprite.bounds.size.x and var_773_2 * manager.ui.mainCameraCom_.aspect / var_773_1.sprite.bounds.size.x or var_773_2 / var_773_1.sprite.bounds.size.y, 0)
				end

				for iter_773_0, iter_773_1 in pairs(arg_770_1.bgs_) do
					if iter_773_0 ~= "ST0104" then
						iter_773_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_773_3 = 1.58333333333333

			if 1.58333333333333 < arg_770_1.time_ and arg_770_1.time_ <= var_773_3 + arg_773_0 then
				arg_770_1.allBtn_.enabled = false
			end

			if arg_770_1.time_ >= var_773_3 + 0.3 and arg_770_1.time_ < var_773_3 + 0.3 + arg_773_0 then
				arg_770_1.allBtn_.enabled = true
			end

			local var_773_4 = 0

			if 0 < arg_770_1.time_ and arg_770_1.time_ <= var_773_4 + arg_773_0 then
				arg_770_1.mask_.enabled = true
				arg_770_1.mask_.raycastTarget = true

				arg_770_1:SetGaussion(false)
			end

			local var_773_5 = 1.583333333332

			if var_773_4 <= arg_770_1.time_ and arg_770_1.time_ < var_773_4 + var_773_5 then
				local var_773_6 = Color.New(0, 0, 0)

				var_773_6.a = Mathf.Lerp(0, 1, (arg_770_1.time_ - var_773_4) / var_773_5)
				arg_770_1.mask_.color = var_773_6
			end

			if arg_770_1.time_ >= var_773_4 + var_773_5 and arg_770_1.time_ < var_773_4 + var_773_5 + arg_773_0 then
				local var_773_7 = Color.New(0, 0, 0)

				var_773_7.a = 1
				arg_770_1.mask_.color = var_773_7
			end

			local var_773_8 = 1.583333333332

			if 1.583333333332 < arg_770_1.time_ and arg_770_1.time_ <= var_773_8 + arg_773_0 then
				arg_770_1.mask_.enabled = true
				arg_770_1.mask_.raycastTarget = true

				arg_770_1:SetGaussion(false)
			end

			local var_773_9 = 2

			if var_773_8 <= arg_770_1.time_ and arg_770_1.time_ < var_773_8 + var_773_9 then
				local var_773_10 = Color.New(0, 0, 0)

				var_773_10.a = Mathf.Lerp(1, 0, (arg_770_1.time_ - var_773_8) / var_773_9)
				arg_770_1.mask_.color = var_773_10
			end

			if arg_770_1.time_ >= var_773_8 + var_773_9 and arg_770_1.time_ < var_773_8 + var_773_9 + arg_773_0 then
				local var_773_11 = Color.New(0, 0, 0)

				arg_770_1.mask_.enabled = false
				var_773_11.a = 0
				arg_770_1.mask_.color = var_773_11
			end

			local var_773_12 = arg_770_1.actors_["10058ui_story"].transform

			if 1.58333333333333 < arg_770_1.time_ and arg_770_1.time_ <= 1.58333333333333 + arg_773_0 then
				arg_770_1.var_.moveOldPos10058ui_story = var_773_12.localPosition
			end

			local var_773_13 = 0.001

			if 1.58333333333333 <= arg_770_1.time_ and arg_770_1.time_ < 1.58333333333333 + var_773_13 then
				var_773_12.localPosition = Vector3.Lerp(arg_770_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_770_1.time_ - 1.58333333333333) / var_773_13)
				var_773_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_773_12.position).x, (manager.ui.mainCamera.transform.position - var_773_12.position).y, (manager.ui.mainCamera.transform.position - var_773_12.position).z)
				var_773_12.localEulerAngles.z = 0
				var_773_12.localEulerAngles.x = 0
				var_773_12.localEulerAngles = var_773_12.localEulerAngles
			end

			if arg_770_1.time_ >= 1.58333333333333 + var_773_13 and arg_770_1.time_ < 1.58333333333333 + var_773_13 + arg_773_0 then
				var_773_12.localPosition = Vector3.New(0, 100, 0)
				var_773_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_773_12.position).x, (manager.ui.mainCamera.transform.position - var_773_12.position).y, (manager.ui.mainCamera.transform.position - var_773_12.position).z)
				var_773_12.localEulerAngles.z = 0
				var_773_12.localEulerAngles.x = 0
				var_773_12.localEulerAngles = var_773_12.localEulerAngles
			end

			if 1 < arg_770_1.time_ and arg_770_1.time_ <= 1 + arg_773_0 then
				arg_770_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 0.2 < arg_770_1.time_ and arg_770_1.time_ <= 0.2 + arg_773_0 then
				arg_770_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_770_1.frameCnt_ <= 1 then
				arg_770_1.dialog_:SetActive(false)
			end

			local var_773_16 = 3.31666666666667
			local var_773_17 = 0.125

			if 3.31666666666667 < arg_770_1.time_ and arg_770_1.time_ <= var_773_16 + arg_773_0 then
				arg_770_1.talkMaxDuration = 0

				arg_770_1.dialog_:SetActive(true)

				arg_770_1.dialogCg_.alpha = 0

				local var_773_18 = LeanTween.value(arg_770_1.dialog_, 0, 1, 0.3)

				var_773_18:setOnUpdate(LuaHelper.FloatAction(function(arg_774_0)
					arg_770_1.dialogCg_.alpha = arg_774_0
				end))
				var_773_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_770_1.dialog_)
					var_773_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_770_1.duration_ = arg_770_1.duration_ + 0.3

				SetActive(arg_770_1.leftNameGo_, true)

				arg_770_1.leftNameTxt_.text = arg_770_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_770_1.leftNameTxt_.transform)

				arg_770_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_770_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_770_1:RecordName(arg_770_1.leftNameTxt_.text)
				SetActive(arg_770_1.iconTrs_.gameObject, true)
				arg_770_1.iconController_:SetSelectedState("hero")

				arg_770_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_770_1.callingController_:SetSelectedState("normal")

				arg_770_1.keyicon_.color = Color.New(1, 1, 1)
				arg_770_1.icon_.color = Color.New(1, 1, 1)

				local var_773_19 = arg_770_1:FormatText(arg_770_1:GetWordFromCfg(1109511190).content)

				arg_770_1.text_.text = var_773_19

				LuaForUtil.ClearLinePrefixSymbol(arg_770_1.text_)

				local var_773_21 = 5 <= 0 and var_773_17 or var_773_17 * (utf8.len(var_773_19) / 5)

				if (5 <= 0 and var_773_17 or var_773_17 * (utf8.len(var_773_19) / 5)) > 0 and var_773_17 < var_773_21 then
					arg_770_1.talkMaxDuration = var_773_21
					var_773_16 = var_773_16 + 0.3

					if var_773_21 + var_773_16 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_21 + var_773_16
					end
				end

				arg_770_1.text_.text = var_773_19
				arg_770_1.typewritter.percent = 0

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(false)
				arg_770_1:RecordContent(arg_770_1.text_.text)
			end

			local var_773_22 = var_773_16 + 0.3
			local var_773_23 = math.max(var_773_17, arg_770_1.talkMaxDuration)

			if var_773_16 + 0.3 <= arg_770_1.time_ and arg_770_1.time_ < var_773_22 + var_773_23 then
				arg_770_1.typewritter.percent = (arg_770_1.time_ - var_773_22) / var_773_23

				arg_770_1.typewritter:SetDirty()
			end

			if arg_770_1.time_ >= var_773_22 + var_773_23 and arg_770_1.time_ < var_773_22 + var_773_23 + arg_773_0 then
				arg_770_1.typewritter.percent = 1

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(true)
			end
		end

		arg_770_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.58333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_770_1:InitPlayNodeList()
	end,
	Play1109511191 = function(arg_776_0, arg_776_1)
		arg_776_1.time_ = 0
		arg_776_1.frameCnt_ = 0
		arg_776_1.state_ = "playing"
		arg_776_1.curTalkId_ = 1109511191
		arg_776_1.duration_ = 5

		SetActive(arg_776_1.tipsGo_, false)

		function arg_776_1.onSingleLineFinish_()
			arg_776_1.onSingleLineUpdate_ = nil
			arg_776_1.onSingleLineFinish_ = nil
			arg_776_1.state_ = "waiting"
		end

		function arg_776_1.playNext_(arg_778_0)
			if arg_778_0 == 1 then
				arg_776_0:Play1109511192(arg_776_1)
			end
		end

		function arg_776_1.onSingleLineUpdate_(arg_779_0)
			local var_779_0 = 0.55

			if 0 < arg_776_1.time_ and arg_776_1.time_ <= 0 + arg_779_0 then
				arg_776_1.talkMaxDuration = 0
				arg_776_1.dialogCg_.alpha = 1

				arg_776_1.dialog_:SetActive(true)
				SetActive(arg_776_1.leftNameGo_, false)

				arg_776_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_776_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_776_1:RecordName(arg_776_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_776_1.iconTrs_.gameObject, false)
				arg_776_1.callingController_:SetSelectedState("normal")

				local var_779_1 = arg_776_1:FormatText(arg_776_1:GetWordFromCfg(1109511191).content)

				arg_776_1.text_.text = var_779_1

				LuaForUtil.ClearLinePrefixSymbol(arg_776_1.text_)

				local var_779_3 = 22 <= 0 and var_779_0 or var_779_0 * (utf8.len(var_779_1) / 22)

				if (22 <= 0 and var_779_0 or var_779_0 * (utf8.len(var_779_1) / 22)) > 0 and var_779_0 < var_779_3 then
					arg_776_1.talkMaxDuration = var_779_3

					if var_779_3 + 0 > arg_776_1.duration_ then
						arg_776_1.duration_ = var_779_3 + 0
					end
				end

				arg_776_1.text_.text = var_779_1
				arg_776_1.typewritter.percent = 0

				arg_776_1.typewritter:SetDirty()
				arg_776_1:ShowNextGo(false)
				arg_776_1:RecordContent(arg_776_1.text_.text)
			end

			local var_779_4 = math.max(var_779_0, arg_776_1.talkMaxDuration)

			if 0 <= arg_776_1.time_ and arg_776_1.time_ < 0 + var_779_4 then
				arg_776_1.typewritter.percent = (arg_776_1.time_ - 0) / var_779_4

				arg_776_1.typewritter:SetDirty()
			end

			if arg_776_1.time_ >= 0 + var_779_4 and arg_776_1.time_ < 0 + var_779_4 + arg_779_0 then
				arg_776_1.typewritter.percent = 1

				arg_776_1.typewritter:SetDirty()
				arg_776_1:ShowNextGo(true)
			end
		end

		arg_776_1.nodeConfigList_ = {}

		arg_776_1:InitPlayNodeList()
	end,
	Play1109511192 = function(arg_780_0, arg_780_1)
		arg_780_1.time_ = 0
		arg_780_1.frameCnt_ = 0
		arg_780_1.state_ = "playing"
		arg_780_1.curTalkId_ = 1109511192
		arg_780_1.duration_ = 7.23

		SetActive(arg_780_1.tipsGo_, false)

		function arg_780_1.onSingleLineFinish_()
			arg_780_1.onSingleLineUpdate_ = nil
			arg_780_1.onSingleLineFinish_ = nil
			arg_780_1.state_ = "waiting"
		end

		function arg_780_1.playNext_(arg_782_0)
			if arg_782_0 == 1 then
				arg_780_0:Play1109511193(arg_780_1)
			end
		end

		function arg_780_1.onSingleLineUpdate_(arg_783_0)
			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 then
				arg_780_1.var_.moveOldPos10058ui_story = arg_780_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_783_0 = 0.001

			if 0 <= arg_780_1.time_ and arg_780_1.time_ < 0 + var_783_0 then
				arg_780_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_780_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_780_1.time_ - 0) / var_783_0)
				arg_780_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_780_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_780_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_780_1.actors_["10058ui_story"].transform.position).z)
				arg_780_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_780_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_780_1.actors_["10058ui_story"].transform.localEulerAngles = arg_780_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_780_1.time_ >= 0 + var_783_0 and arg_780_1.time_ < 0 + var_783_0 + arg_783_0 then
				arg_780_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_780_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_780_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_780_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_780_1.actors_["10058ui_story"].transform.position).z)
				arg_780_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_780_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_780_1.actors_["10058ui_story"].transform.localEulerAngles = arg_780_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_783_1 = arg_780_1.actors_["10058ui_story"]

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 and not isNil(var_783_1) and arg_780_1.var_.characterEffect10058ui_story == nil then
				arg_780_1.var_.characterEffect10058ui_story = var_783_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_783_2 = 0.200000002980232

			if 0 <= arg_780_1.time_ and arg_780_1.time_ < 0 + var_783_2 and not isNil(var_783_1) then
				if arg_780_1.var_.characterEffect10058ui_story and not isNil(var_783_1) then
					arg_780_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_780_1.time_ >= 0 + var_783_2 and arg_780_1.time_ < 0 + var_783_2 + arg_783_0 and not isNil(var_783_1) and arg_780_1.var_.characterEffect10058ui_story then
				arg_780_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 then
				arg_780_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 then
				arg_780_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_783_4 = 0
			local var_783_5 = 0.65

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= var_783_4 + arg_783_0 then
				arg_780_1.talkMaxDuration = 0
				arg_780_1.dialogCg_.alpha = 1

				arg_780_1.dialog_:SetActive(true)
				SetActive(arg_780_1.leftNameGo_, true)

				arg_780_1.leftNameTxt_.text = arg_780_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_780_1.leftNameTxt_.transform)

				arg_780_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_780_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_780_1:RecordName(arg_780_1.leftNameTxt_.text)
				SetActive(arg_780_1.iconTrs_.gameObject, false)
				arg_780_1.callingController_:SetSelectedState("normal")

				local var_783_6 = arg_780_1:GetWordFromCfg(1109511192)
				local var_783_7 = arg_780_1:FormatText(var_783_6.content)

				arg_780_1.text_.text = var_783_7

				LuaForUtil.ClearLinePrefixSymbol(arg_780_1.text_)

				local var_783_9 = 26 <= 0 and var_783_5 or var_783_5 * (utf8.len(var_783_7) / 26)

				if (26 <= 0 and var_783_5 or var_783_5 * (utf8.len(var_783_7) / 26)) > 0 and var_783_5 < var_783_9 then
					arg_780_1.talkMaxDuration = var_783_9

					if var_783_9 + var_783_4 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_9 + var_783_4
					end
				end

				arg_780_1.text_.text = var_783_7
				arg_780_1.typewritter.percent = 0

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb") ~= 0 then
					local var_783_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb") / 1000

					if var_783_10 + var_783_4 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_10 + var_783_4
					end

					if var_783_6.prefab_name ~= "" and arg_780_1.actors_[var_783_6.prefab_name] ~= nil then
						local var_783_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_780_1.actors_[var_783_6.prefab_name].transform, "story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb")

						arg_780_1:RecordAudio("1109511192", var_783_11)
						arg_780_1:RecordAudio("1109511192", var_783_11)
					else
						arg_780_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb")
					end

					arg_780_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511192", "story_v_side_new_1109511.awb")
				end

				arg_780_1:RecordContent(arg_780_1.text_.text)
			end

			local var_783_12 = math.max(var_783_5, arg_780_1.talkMaxDuration)

			if var_783_4 <= arg_780_1.time_ and arg_780_1.time_ < var_783_4 + var_783_12 then
				arg_780_1.typewritter.percent = (arg_780_1.time_ - var_783_4) / var_783_12

				arg_780_1.typewritter:SetDirty()
			end

			if arg_780_1.time_ >= var_783_4 + var_783_12 and arg_780_1.time_ < var_783_4 + var_783_12 + arg_783_0 then
				arg_780_1.typewritter.percent = 1

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(true)
			end
		end

		arg_780_1.nodeConfigList_ = {
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

		arg_780_1:InitPlayNodeList()
	end,
	Play1109511193 = function(arg_784_0, arg_784_1)
		arg_784_1.time_ = 0
		arg_784_1.frameCnt_ = 0
		arg_784_1.state_ = "playing"
		arg_784_1.curTalkId_ = 1109511193
		arg_784_1.duration_ = 5

		SetActive(arg_784_1.tipsGo_, false)

		function arg_784_1.onSingleLineFinish_()
			arg_784_1.onSingleLineUpdate_ = nil
			arg_784_1.onSingleLineFinish_ = nil
			arg_784_1.state_ = "waiting"
		end

		function arg_784_1.playNext_(arg_786_0)
			if arg_786_0 == 1 then
				arg_784_0:Play1109511194(arg_784_1)
			end
		end

		function arg_784_1.onSingleLineUpdate_(arg_787_0)
			if 0 < arg_784_1.time_ and arg_784_1.time_ <= 0 + arg_787_0 and not isNil(arg_784_1.actors_["10058ui_story"]) and arg_784_1.var_.characterEffect10058ui_story == nil then
				arg_784_1.var_.characterEffect10058ui_story = arg_784_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_787_0 = 0.200000002980232

			if 0 <= arg_784_1.time_ and arg_784_1.time_ < 0 + var_787_0 and not isNil(arg_784_1.actors_["10058ui_story"]) then
				if arg_784_1.var_.characterEffect10058ui_story and not isNil(arg_784_1.actors_["10058ui_story"]) then
					arg_784_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_784_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_784_1.time_ - 0) / var_787_0)
				end
			end

			if arg_784_1.time_ >= 0 + var_787_0 and arg_784_1.time_ < 0 + var_787_0 + arg_787_0 and not isNil(arg_784_1.actors_["10058ui_story"]) and arg_784_1.var_.characterEffect10058ui_story then
				arg_784_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_784_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_784_1.time_ and arg_784_1.time_ <= 0 + arg_787_0 then
				arg_784_1:AudioAction("play", "effect", "se_story_152", "se_story_152_keyboard", "")
			end

			local var_787_2 = 0
			local var_787_3 = 0.45

			if 0 < arg_784_1.time_ and arg_784_1.time_ <= var_787_2 + arg_787_0 then
				arg_784_1.talkMaxDuration = 0
				arg_784_1.dialogCg_.alpha = 1

				arg_784_1.dialog_:SetActive(true)
				SetActive(arg_784_1.leftNameGo_, false)

				arg_784_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_784_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_784_1:RecordName(arg_784_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_784_1.iconTrs_.gameObject, false)
				arg_784_1.callingController_:SetSelectedState("normal")

				local var_787_4 = arg_784_1:FormatText(arg_784_1:GetWordFromCfg(1109511193).content)

				arg_784_1.text_.text = var_787_4

				LuaForUtil.ClearLinePrefixSymbol(arg_784_1.text_)

				local var_787_6 = 18 <= 0 and var_787_3 or var_787_3 * (utf8.len(var_787_4) / 18)

				if (18 <= 0 and var_787_3 or var_787_3 * (utf8.len(var_787_4) / 18)) > 0 and var_787_3 < var_787_6 then
					arg_784_1.talkMaxDuration = var_787_6

					if var_787_6 + var_787_2 > arg_784_1.duration_ then
						arg_784_1.duration_ = var_787_6 + var_787_2
					end
				end

				arg_784_1.text_.text = var_787_4
				arg_784_1.typewritter.percent = 0

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(false)
				arg_784_1:RecordContent(arg_784_1.text_.text)
			end

			local var_787_7 = math.max(var_787_3, arg_784_1.talkMaxDuration)

			if var_787_2 <= arg_784_1.time_ and arg_784_1.time_ < var_787_2 + var_787_7 then
				arg_784_1.typewritter.percent = (arg_784_1.time_ - var_787_2) / var_787_7

				arg_784_1.typewritter:SetDirty()
			end

			if arg_784_1.time_ >= var_787_2 + var_787_7 and arg_784_1.time_ < var_787_2 + var_787_7 + arg_787_0 then
				arg_784_1.typewritter.percent = 1

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(true)
			end
		end

		arg_784_1.nodeConfigList_ = {}

		arg_784_1:InitPlayNodeList()
	end,
	Play1109511194 = function(arg_788_0, arg_788_1)
		arg_788_1.time_ = 0
		arg_788_1.frameCnt_ = 0
		arg_788_1.state_ = "playing"
		arg_788_1.curTalkId_ = 1109511194
		arg_788_1.duration_ = 5

		SetActive(arg_788_1.tipsGo_, false)

		function arg_788_1.onSingleLineFinish_()
			arg_788_1.onSingleLineUpdate_ = nil
			arg_788_1.onSingleLineFinish_ = nil
			arg_788_1.state_ = "waiting"
		end

		function arg_788_1.playNext_(arg_790_0)
			if arg_790_0 == 1 then
				arg_788_0:Play1109511195(arg_788_1)
			end
		end

		function arg_788_1.onSingleLineUpdate_(arg_791_0)
			local var_791_0 = 0.175

			if 0 < arg_788_1.time_ and arg_788_1.time_ <= 0 + arg_791_0 then
				arg_788_1.talkMaxDuration = 0
				arg_788_1.dialogCg_.alpha = 1

				arg_788_1.dialog_:SetActive(true)
				SetActive(arg_788_1.leftNameGo_, true)

				arg_788_1.leftNameTxt_.text = arg_788_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_788_1.leftNameTxt_.transform)

				arg_788_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_788_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_788_1:RecordName(arg_788_1.leftNameTxt_.text)
				SetActive(arg_788_1.iconTrs_.gameObject, true)
				arg_788_1.iconController_:SetSelectedState("hero")

				arg_788_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_788_1.callingController_:SetSelectedState("normal")

				arg_788_1.keyicon_.color = Color.New(1, 1, 1)
				arg_788_1.icon_.color = Color.New(1, 1, 1)

				local var_791_1 = arg_788_1:FormatText(arg_788_1:GetWordFromCfg(1109511194).content)

				arg_788_1.text_.text = var_791_1

				LuaForUtil.ClearLinePrefixSymbol(arg_788_1.text_)

				local var_791_3 = 7 <= 0 and var_791_0 or var_791_0 * (utf8.len(var_791_1) / 7)

				if (7 <= 0 and var_791_0 or var_791_0 * (utf8.len(var_791_1) / 7)) > 0 and var_791_0 < var_791_3 then
					arg_788_1.talkMaxDuration = var_791_3

					if var_791_3 + 0 > arg_788_1.duration_ then
						arg_788_1.duration_ = var_791_3 + 0
					end
				end

				arg_788_1.text_.text = var_791_1
				arg_788_1.typewritter.percent = 0

				arg_788_1.typewritter:SetDirty()
				arg_788_1:ShowNextGo(false)
				arg_788_1:RecordContent(arg_788_1.text_.text)
			end

			local var_791_4 = math.max(var_791_0, arg_788_1.talkMaxDuration)

			if 0 <= arg_788_1.time_ and arg_788_1.time_ < 0 + var_791_4 then
				arg_788_1.typewritter.percent = (arg_788_1.time_ - 0) / var_791_4

				arg_788_1.typewritter:SetDirty()
			end

			if arg_788_1.time_ >= 0 + var_791_4 and arg_788_1.time_ < 0 + var_791_4 + arg_791_0 then
				arg_788_1.typewritter.percent = 1

				arg_788_1.typewritter:SetDirty()
				arg_788_1:ShowNextGo(true)
			end
		end

		arg_788_1.nodeConfigList_ = {}

		arg_788_1:InitPlayNodeList()
	end,
	Play1109511195 = function(arg_792_0, arg_792_1)
		arg_792_1.time_ = 0
		arg_792_1.frameCnt_ = 0
		arg_792_1.state_ = "playing"
		arg_792_1.curTalkId_ = 1109511195
		arg_792_1.duration_ = 5.23

		SetActive(arg_792_1.tipsGo_, false)

		function arg_792_1.onSingleLineFinish_()
			arg_792_1.onSingleLineUpdate_ = nil
			arg_792_1.onSingleLineFinish_ = nil
			arg_792_1.state_ = "waiting"
		end

		function arg_792_1.playNext_(arg_794_0)
			if arg_794_0 == 1 then
				arg_792_0:Play1109511196(arg_792_1)
			end
		end

		function arg_792_1.onSingleLineUpdate_(arg_795_0)
			if 0 < arg_792_1.time_ and arg_792_1.time_ <= 0 + arg_795_0 and not isNil(arg_792_1.actors_["10058ui_story"]) and arg_792_1.var_.characterEffect10058ui_story == nil then
				arg_792_1.var_.characterEffect10058ui_story = arg_792_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_795_0 = 0.200000002980232

			if 0 <= arg_792_1.time_ and arg_792_1.time_ < 0 + var_795_0 and not isNil(arg_792_1.actors_["10058ui_story"]) then
				if arg_792_1.var_.characterEffect10058ui_story and not isNil(arg_792_1.actors_["10058ui_story"]) then
					arg_792_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_792_1.time_ >= 0 + var_795_0 and arg_792_1.time_ < 0 + var_795_0 + arg_795_0 and not isNil(arg_792_1.actors_["10058ui_story"]) and arg_792_1.var_.characterEffect10058ui_story then
				arg_792_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_792_1.time_ and arg_792_1.time_ <= 0 + arg_795_0 then
				arg_792_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			if 0 < arg_792_1.time_ and arg_792_1.time_ <= 0 + arg_795_0 then
				arg_792_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_795_2 = 0
			local var_795_3 = 0.525

			if 0 < arg_792_1.time_ and arg_792_1.time_ <= var_795_2 + arg_795_0 then
				arg_792_1.talkMaxDuration = 0
				arg_792_1.dialogCg_.alpha = 1

				arg_792_1.dialog_:SetActive(true)
				SetActive(arg_792_1.leftNameGo_, true)

				arg_792_1.leftNameTxt_.text = arg_792_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_792_1.leftNameTxt_.transform)

				arg_792_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_792_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_792_1:RecordName(arg_792_1.leftNameTxt_.text)
				SetActive(arg_792_1.iconTrs_.gameObject, false)
				arg_792_1.callingController_:SetSelectedState("normal")

				local var_795_4 = arg_792_1:GetWordFromCfg(1109511195)
				local var_795_5 = arg_792_1:FormatText(var_795_4.content)

				arg_792_1.text_.text = var_795_5

				LuaForUtil.ClearLinePrefixSymbol(arg_792_1.text_)

				local var_795_7 = 21 <= 0 and var_795_3 or var_795_3 * (utf8.len(var_795_5) / 21)

				if (21 <= 0 and var_795_3 or var_795_3 * (utf8.len(var_795_5) / 21)) > 0 and var_795_3 < var_795_7 then
					arg_792_1.talkMaxDuration = var_795_7

					if var_795_7 + var_795_2 > arg_792_1.duration_ then
						arg_792_1.duration_ = var_795_7 + var_795_2
					end
				end

				arg_792_1.text_.text = var_795_5
				arg_792_1.typewritter.percent = 0

				arg_792_1.typewritter:SetDirty()
				arg_792_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb") ~= 0 then
					local var_795_8 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb") / 1000

					if var_795_8 + var_795_2 > arg_792_1.duration_ then
						arg_792_1.duration_ = var_795_8 + var_795_2
					end

					if var_795_4.prefab_name ~= "" and arg_792_1.actors_[var_795_4.prefab_name] ~= nil then
						local var_795_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_792_1.actors_[var_795_4.prefab_name].transform, "story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb")

						arg_792_1:RecordAudio("1109511195", var_795_9)
						arg_792_1:RecordAudio("1109511195", var_795_9)
					else
						arg_792_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb")
					end

					arg_792_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511195", "story_v_side_new_1109511.awb")
				end

				arg_792_1:RecordContent(arg_792_1.text_.text)
			end

			local var_795_10 = math.max(var_795_3, arg_792_1.talkMaxDuration)

			if var_795_2 <= arg_792_1.time_ and arg_792_1.time_ < var_795_2 + var_795_10 then
				arg_792_1.typewritter.percent = (arg_792_1.time_ - var_795_2) / var_795_10

				arg_792_1.typewritter:SetDirty()
			end

			if arg_792_1.time_ >= var_795_2 + var_795_10 and arg_792_1.time_ < var_795_2 + var_795_10 + arg_795_0 then
				arg_792_1.typewritter.percent = 1

				arg_792_1.typewritter:SetDirty()
				arg_792_1:ShowNextGo(true)
			end
		end

		arg_792_1.nodeConfigList_ = {}

		arg_792_1:InitPlayNodeList()
	end,
	Play1109511196 = function(arg_796_0, arg_796_1)
		arg_796_1.time_ = 0
		arg_796_1.frameCnt_ = 0
		arg_796_1.state_ = "playing"
		arg_796_1.curTalkId_ = 1109511196
		arg_796_1.duration_ = 5.27

		SetActive(arg_796_1.tipsGo_, false)

		function arg_796_1.onSingleLineFinish_()
			arg_796_1.onSingleLineUpdate_ = nil
			arg_796_1.onSingleLineFinish_ = nil
			arg_796_1.state_ = "waiting"
		end

		function arg_796_1.playNext_(arg_798_0)
			if arg_798_0 == 1 then
				arg_796_0:Play1109511197(arg_796_1)
			end
		end

		function arg_796_1.onSingleLineUpdate_(arg_799_0)
			local var_799_0 = 0.6

			if 0 < arg_796_1.time_ and arg_796_1.time_ <= 0 + arg_799_0 then
				arg_796_1.talkMaxDuration = 0
				arg_796_1.dialogCg_.alpha = 1

				arg_796_1.dialog_:SetActive(true)
				SetActive(arg_796_1.leftNameGo_, true)

				arg_796_1.leftNameTxt_.text = arg_796_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_796_1.leftNameTxt_.transform)

				arg_796_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_796_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_796_1:RecordName(arg_796_1.leftNameTxt_.text)
				SetActive(arg_796_1.iconTrs_.gameObject, false)
				arg_796_1.callingController_:SetSelectedState("normal")

				local var_799_1 = arg_796_1:GetWordFromCfg(1109511196)
				local var_799_2 = arg_796_1:FormatText(var_799_1.content)

				arg_796_1.text_.text = var_799_2

				LuaForUtil.ClearLinePrefixSymbol(arg_796_1.text_)

				local var_799_4 = 24 <= 0 and var_799_0 or var_799_0 * (utf8.len(var_799_2) / 24)

				if (24 <= 0 and var_799_0 or var_799_0 * (utf8.len(var_799_2) / 24)) > 0 and var_799_0 < var_799_4 then
					arg_796_1.talkMaxDuration = var_799_4

					if var_799_4 + 0 > arg_796_1.duration_ then
						arg_796_1.duration_ = var_799_4 + 0
					end
				end

				arg_796_1.text_.text = var_799_2
				arg_796_1.typewritter.percent = 0

				arg_796_1.typewritter:SetDirty()
				arg_796_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb") ~= 0 then
					local var_799_5 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb") / 1000

					if var_799_5 + 0 > arg_796_1.duration_ then
						arg_796_1.duration_ = var_799_5 + 0
					end

					if var_799_1.prefab_name ~= "" and arg_796_1.actors_[var_799_1.prefab_name] ~= nil then
						local var_799_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_796_1.actors_[var_799_1.prefab_name].transform, "story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb")

						arg_796_1:RecordAudio("1109511196", var_799_6)
						arg_796_1:RecordAudio("1109511196", var_799_6)
					else
						arg_796_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb")
					end

					arg_796_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511196", "story_v_side_new_1109511.awb")
				end

				arg_796_1:RecordContent(arg_796_1.text_.text)
			end

			local var_799_7 = math.max(var_799_0, arg_796_1.talkMaxDuration)

			if 0 <= arg_796_1.time_ and arg_796_1.time_ < 0 + var_799_7 then
				arg_796_1.typewritter.percent = (arg_796_1.time_ - 0) / var_799_7

				arg_796_1.typewritter:SetDirty()
			end

			if arg_796_1.time_ >= 0 + var_799_7 and arg_796_1.time_ < 0 + var_799_7 + arg_799_0 then
				arg_796_1.typewritter.percent = 1

				arg_796_1.typewritter:SetDirty()
				arg_796_1:ShowNextGo(true)
			end
		end

		arg_796_1.nodeConfigList_ = {}

		arg_796_1:InitPlayNodeList()
	end,
	Play1109511197 = function(arg_800_0, arg_800_1)
		arg_800_1.time_ = 0
		arg_800_1.frameCnt_ = 0
		arg_800_1.state_ = "playing"
		arg_800_1.curTalkId_ = 1109511197
		arg_800_1.duration_ = 5

		SetActive(arg_800_1.tipsGo_, false)

		function arg_800_1.onSingleLineFinish_()
			arg_800_1.onSingleLineUpdate_ = nil
			arg_800_1.onSingleLineFinish_ = nil
			arg_800_1.state_ = "waiting"
		end

		function arg_800_1.playNext_(arg_802_0)
			if arg_802_0 == 1 then
				arg_800_0:Play1109511198(arg_800_1)
			end
		end

		function arg_800_1.onSingleLineUpdate_(arg_803_0)
			if 0 < arg_800_1.time_ and arg_800_1.time_ <= 0 + arg_803_0 and not isNil(arg_800_1.actors_["10058ui_story"]) and arg_800_1.var_.characterEffect10058ui_story == nil then
				arg_800_1.var_.characterEffect10058ui_story = arg_800_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_803_0 = 0.200000002980232

			if 0 <= arg_800_1.time_ and arg_800_1.time_ < 0 + var_803_0 and not isNil(arg_800_1.actors_["10058ui_story"]) then
				if arg_800_1.var_.characterEffect10058ui_story and not isNil(arg_800_1.actors_["10058ui_story"]) then
					arg_800_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_800_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_800_1.time_ - 0) / var_803_0)
				end
			end

			if arg_800_1.time_ >= 0 + var_803_0 and arg_800_1.time_ < 0 + var_803_0 + arg_803_0 and not isNil(arg_800_1.actors_["10058ui_story"]) and arg_800_1.var_.characterEffect10058ui_story then
				arg_800_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_800_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_803_1 = 0
			local var_803_2 = 0.7

			if 0 < arg_800_1.time_ and arg_800_1.time_ <= var_803_1 + arg_803_0 then
				arg_800_1.talkMaxDuration = 0
				arg_800_1.dialogCg_.alpha = 1

				arg_800_1.dialog_:SetActive(true)
				SetActive(arg_800_1.leftNameGo_, true)

				arg_800_1.leftNameTxt_.text = arg_800_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_800_1.leftNameTxt_.transform)

				arg_800_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_800_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_800_1:RecordName(arg_800_1.leftNameTxt_.text)
				SetActive(arg_800_1.iconTrs_.gameObject, true)
				arg_800_1.iconController_:SetSelectedState("hero")

				arg_800_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_800_1.callingController_:SetSelectedState("normal")

				arg_800_1.keyicon_.color = Color.New(1, 1, 1)
				arg_800_1.icon_.color = Color.New(1, 1, 1)

				local var_803_3 = arg_800_1:FormatText(arg_800_1:GetWordFromCfg(1109511197).content)

				arg_800_1.text_.text = var_803_3

				LuaForUtil.ClearLinePrefixSymbol(arg_800_1.text_)

				local var_803_5 = 28 <= 0 and var_803_2 or var_803_2 * (utf8.len(var_803_3) / 28)

				if (28 <= 0 and var_803_2 or var_803_2 * (utf8.len(var_803_3) / 28)) > 0 and var_803_2 < var_803_5 then
					arg_800_1.talkMaxDuration = var_803_5

					if var_803_5 + var_803_1 > arg_800_1.duration_ then
						arg_800_1.duration_ = var_803_5 + var_803_1
					end
				end

				arg_800_1.text_.text = var_803_3
				arg_800_1.typewritter.percent = 0

				arg_800_1.typewritter:SetDirty()
				arg_800_1:ShowNextGo(false)
				arg_800_1:RecordContent(arg_800_1.text_.text)
			end

			local var_803_6 = math.max(var_803_2, arg_800_1.talkMaxDuration)

			if var_803_1 <= arg_800_1.time_ and arg_800_1.time_ < var_803_1 + var_803_6 then
				arg_800_1.typewritter.percent = (arg_800_1.time_ - var_803_1) / var_803_6

				arg_800_1.typewritter:SetDirty()
			end

			if arg_800_1.time_ >= var_803_1 + var_803_6 and arg_800_1.time_ < var_803_1 + var_803_6 + arg_803_0 then
				arg_800_1.typewritter.percent = 1

				arg_800_1.typewritter:SetDirty()
				arg_800_1:ShowNextGo(true)
			end
		end

		arg_800_1.nodeConfigList_ = {}

		arg_800_1:InitPlayNodeList()
	end,
	Play1109511198 = function(arg_804_0, arg_804_1)
		arg_804_1.time_ = 0
		arg_804_1.frameCnt_ = 0
		arg_804_1.state_ = "playing"
		arg_804_1.curTalkId_ = 1109511198
		arg_804_1.duration_ = 5

		SetActive(arg_804_1.tipsGo_, false)

		function arg_804_1.onSingleLineFinish_()
			arg_804_1.onSingleLineUpdate_ = nil
			arg_804_1.onSingleLineFinish_ = nil
			arg_804_1.state_ = "waiting"
		end

		function arg_804_1.playNext_(arg_806_0)
			if arg_806_0 == 1 then
				arg_804_0:Play1109511199(arg_804_1)
			end
		end

		function arg_804_1.onSingleLineUpdate_(arg_807_0)
			if 0 < arg_804_1.time_ and arg_804_1.time_ <= 0 + arg_807_0 then
				arg_804_1.var_.moveOldPos10058ui_story = arg_804_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_807_0 = 0.001

			if 0 <= arg_804_1.time_ and arg_804_1.time_ < 0 + var_807_0 then
				arg_804_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_804_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_804_1.time_ - 0) / var_807_0)
				arg_804_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_804_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_804_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_804_1.actors_["10058ui_story"].transform.position).z)
				arg_804_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_804_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_804_1.actors_["10058ui_story"].transform.localEulerAngles = arg_804_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_804_1.time_ >= 0 + var_807_0 and arg_804_1.time_ < 0 + var_807_0 + arg_807_0 then
				arg_804_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_804_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_804_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_804_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_804_1.actors_["10058ui_story"].transform.position).z)
				arg_804_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_804_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_804_1.actors_["10058ui_story"].transform.localEulerAngles = arg_804_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_807_1 = 0
			local var_807_2 = 0.825

			if 0 < arg_804_1.time_ and arg_804_1.time_ <= var_807_1 + arg_807_0 then
				arg_804_1.talkMaxDuration = 0
				arg_804_1.dialogCg_.alpha = 1

				arg_804_1.dialog_:SetActive(true)
				SetActive(arg_804_1.leftNameGo_, false)

				arg_804_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_804_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_804_1:RecordName(arg_804_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_804_1.iconTrs_.gameObject, false)
				arg_804_1.callingController_:SetSelectedState("normal")

				local var_807_3 = arg_804_1:FormatText(arg_804_1:GetWordFromCfg(1109511198).content)

				arg_804_1.text_.text = var_807_3

				LuaForUtil.ClearLinePrefixSymbol(arg_804_1.text_)

				local var_807_5 = 33 <= 0 and var_807_2 or var_807_2 * (utf8.len(var_807_3) / 33)

				if (33 <= 0 and var_807_2 or var_807_2 * (utf8.len(var_807_3) / 33)) > 0 and var_807_2 < var_807_5 then
					arg_804_1.talkMaxDuration = var_807_5

					if var_807_5 + var_807_1 > arg_804_1.duration_ then
						arg_804_1.duration_ = var_807_5 + var_807_1
					end
				end

				arg_804_1.text_.text = var_807_3
				arg_804_1.typewritter.percent = 0

				arg_804_1.typewritter:SetDirty()
				arg_804_1:ShowNextGo(false)
				arg_804_1:RecordContent(arg_804_1.text_.text)
			end

			local var_807_6 = math.max(var_807_2, arg_804_1.talkMaxDuration)

			if var_807_1 <= arg_804_1.time_ and arg_804_1.time_ < var_807_1 + var_807_6 then
				arg_804_1.typewritter.percent = (arg_804_1.time_ - var_807_1) / var_807_6

				arg_804_1.typewritter:SetDirty()
			end

			if arg_804_1.time_ >= var_807_1 + var_807_6 and arg_804_1.time_ < var_807_1 + var_807_6 + arg_807_0 then
				arg_804_1.typewritter.percent = 1

				arg_804_1.typewritter:SetDirty()
				arg_804_1:ShowNextGo(true)
			end
		end

		arg_804_1.nodeConfigList_ = {
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

		arg_804_1:InitPlayNodeList()
	end,
	Play1109511199 = function(arg_808_0, arg_808_1)
		arg_808_1.time_ = 0
		arg_808_1.frameCnt_ = 0
		arg_808_1.state_ = "playing"
		arg_808_1.curTalkId_ = 1109511199
		arg_808_1.duration_ = 9.33

		SetActive(arg_808_1.tipsGo_, false)

		function arg_808_1.onSingleLineFinish_()
			arg_808_1.onSingleLineUpdate_ = nil
			arg_808_1.onSingleLineFinish_ = nil
			arg_808_1.state_ = "waiting"
		end

		function arg_808_1.playNext_(arg_810_0)
			if arg_810_0 == 1 then
				arg_808_0:Play1109511200(arg_808_1)
			end
		end

		function arg_808_1.onSingleLineUpdate_(arg_811_0)
			if 0 < arg_808_1.time_ and arg_808_1.time_ <= 0 + arg_811_0 and not isNil(arg_808_1.actors_["10058ui_story"]) and arg_808_1.var_.characterEffect10058ui_story == nil then
				arg_808_1.var_.characterEffect10058ui_story = arg_808_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_811_0 = 0.200000002980232

			if 0 <= arg_808_1.time_ and arg_808_1.time_ < 0 + var_811_0 and not isNil(arg_808_1.actors_["10058ui_story"]) then
				if arg_808_1.var_.characterEffect10058ui_story and not isNil(arg_808_1.actors_["10058ui_story"]) then
					arg_808_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_808_1.time_ >= 0 + var_811_0 and arg_808_1.time_ < 0 + var_811_0 + arg_811_0 and not isNil(arg_808_1.actors_["10058ui_story"]) and arg_808_1.var_.characterEffect10058ui_story then
				arg_808_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_811_2 = arg_808_1.actors_["10058ui_story"].transform

			if 0 < arg_808_1.time_ and arg_808_1.time_ <= 0 + arg_811_0 then
				arg_808_1.var_.moveOldPos10058ui_story = var_811_2.localPosition
			end

			local var_811_3 = 0.001

			if 0 <= arg_808_1.time_ and arg_808_1.time_ < 0 + var_811_3 then
				var_811_2.localPosition = Vector3.Lerp(arg_808_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_808_1.time_ - 0) / var_811_3)
				var_811_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_811_2.position).x, (manager.ui.mainCamera.transform.position - var_811_2.position).y, (manager.ui.mainCamera.transform.position - var_811_2.position).z)
				var_811_2.localEulerAngles.z = 0
				var_811_2.localEulerAngles.x = 0
				var_811_2.localEulerAngles = var_811_2.localEulerAngles
			end

			if arg_808_1.time_ >= 0 + var_811_3 and arg_808_1.time_ < 0 + var_811_3 + arg_811_0 then
				var_811_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_811_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_811_2.position).x, (manager.ui.mainCamera.transform.position - var_811_2.position).y, (manager.ui.mainCamera.transform.position - var_811_2.position).z)
				var_811_2.localEulerAngles.z = 0
				var_811_2.localEulerAngles.x = 0
				var_811_2.localEulerAngles = var_811_2.localEulerAngles
			end

			local var_811_4 = 0
			local var_811_5 = 0.725

			if 0 < arg_808_1.time_ and arg_808_1.time_ <= var_811_4 + arg_811_0 then
				arg_808_1.talkMaxDuration = 0
				arg_808_1.dialogCg_.alpha = 1

				arg_808_1.dialog_:SetActive(true)
				SetActive(arg_808_1.leftNameGo_, true)

				arg_808_1.leftNameTxt_.text = arg_808_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_808_1.leftNameTxt_.transform)

				arg_808_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_808_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_808_1:RecordName(arg_808_1.leftNameTxt_.text)
				SetActive(arg_808_1.iconTrs_.gameObject, false)
				arg_808_1.callingController_:SetSelectedState("normal")

				local var_811_6 = arg_808_1:GetWordFromCfg(1109511199)
				local var_811_7 = arg_808_1:FormatText(var_811_6.content)

				arg_808_1.text_.text = var_811_7

				LuaForUtil.ClearLinePrefixSymbol(arg_808_1.text_)

				local var_811_9 = 29 <= 0 and var_811_5 or var_811_5 * (utf8.len(var_811_7) / 29)

				if (29 <= 0 and var_811_5 or var_811_5 * (utf8.len(var_811_7) / 29)) > 0 and var_811_5 < var_811_9 then
					arg_808_1.talkMaxDuration = var_811_9

					if var_811_9 + var_811_4 > arg_808_1.duration_ then
						arg_808_1.duration_ = var_811_9 + var_811_4
					end
				end

				arg_808_1.text_.text = var_811_7
				arg_808_1.typewritter.percent = 0

				arg_808_1.typewritter:SetDirty()
				arg_808_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb") ~= 0 then
					local var_811_10 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb") / 1000

					if var_811_10 + var_811_4 > arg_808_1.duration_ then
						arg_808_1.duration_ = var_811_10 + var_811_4
					end

					if var_811_6.prefab_name ~= "" and arg_808_1.actors_[var_811_6.prefab_name] ~= nil then
						local var_811_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_808_1.actors_[var_811_6.prefab_name].transform, "story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb")

						arg_808_1:RecordAudio("1109511199", var_811_11)
						arg_808_1:RecordAudio("1109511199", var_811_11)
					else
						arg_808_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb")
					end

					arg_808_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511199", "story_v_side_new_1109511.awb")
				end

				arg_808_1:RecordContent(arg_808_1.text_.text)
			end

			local var_811_12 = math.max(var_811_5, arg_808_1.talkMaxDuration)

			if var_811_4 <= arg_808_1.time_ and arg_808_1.time_ < var_811_4 + var_811_12 then
				arg_808_1.typewritter.percent = (arg_808_1.time_ - var_811_4) / var_811_12

				arg_808_1.typewritter:SetDirty()
			end

			if arg_808_1.time_ >= var_811_4 + var_811_12 and arg_808_1.time_ < var_811_4 + var_811_12 + arg_811_0 then
				arg_808_1.typewritter.percent = 1

				arg_808_1.typewritter:SetDirty()
				arg_808_1:ShowNextGo(true)
			end
		end

		arg_808_1.nodeConfigList_ = {
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

		arg_808_1:InitPlayNodeList()
	end,
	Play1109511200 = function(arg_812_0, arg_812_1)
		arg_812_1.time_ = 0
		arg_812_1.frameCnt_ = 0
		arg_812_1.state_ = "playing"
		arg_812_1.curTalkId_ = 1109511200
		arg_812_1.duration_ = 5

		SetActive(arg_812_1.tipsGo_, false)

		function arg_812_1.onSingleLineFinish_()
			arg_812_1.onSingleLineUpdate_ = nil
			arg_812_1.onSingleLineFinish_ = nil
			arg_812_1.state_ = "waiting"
		end

		function arg_812_1.playNext_(arg_814_0)
			if arg_814_0 == 1 then
				arg_812_0:Play1109511201(arg_812_1)
			end
		end

		function arg_812_1.onSingleLineUpdate_(arg_815_0)
			if 0 < arg_812_1.time_ and arg_812_1.time_ <= 0 + arg_815_0 and not isNil(arg_812_1.actors_["10058ui_story"]) and arg_812_1.var_.characterEffect10058ui_story == nil then
				arg_812_1.var_.characterEffect10058ui_story = arg_812_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_815_0 = 0.200000002980232

			if 0 <= arg_812_1.time_ and arg_812_1.time_ < 0 + var_815_0 and not isNil(arg_812_1.actors_["10058ui_story"]) then
				if arg_812_1.var_.characterEffect10058ui_story and not isNil(arg_812_1.actors_["10058ui_story"]) then
					arg_812_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_812_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_812_1.time_ - 0) / var_815_0)
				end
			end

			if arg_812_1.time_ >= 0 + var_815_0 and arg_812_1.time_ < 0 + var_815_0 + arg_815_0 and not isNil(arg_812_1.actors_["10058ui_story"]) and arg_812_1.var_.characterEffect10058ui_story then
				arg_812_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_812_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_815_1 = 0
			local var_815_2 = 0.725

			if 0 < arg_812_1.time_ and arg_812_1.time_ <= var_815_1 + arg_815_0 then
				arg_812_1.talkMaxDuration = 0
				arg_812_1.dialogCg_.alpha = 1

				arg_812_1.dialog_:SetActive(true)
				SetActive(arg_812_1.leftNameGo_, true)

				arg_812_1.leftNameTxt_.text = arg_812_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_812_1.leftNameTxt_.transform)

				arg_812_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_812_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_812_1:RecordName(arg_812_1.leftNameTxt_.text)
				SetActive(arg_812_1.iconTrs_.gameObject, true)
				arg_812_1.iconController_:SetSelectedState("hero")

				arg_812_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_812_1.callingController_:SetSelectedState("normal")

				arg_812_1.keyicon_.color = Color.New(1, 1, 1)
				arg_812_1.icon_.color = Color.New(1, 1, 1)

				local var_815_3 = arg_812_1:FormatText(arg_812_1:GetWordFromCfg(1109511200).content)

				arg_812_1.text_.text = var_815_3

				LuaForUtil.ClearLinePrefixSymbol(arg_812_1.text_)

				local var_815_5 = 29 <= 0 and var_815_2 or var_815_2 * (utf8.len(var_815_3) / 29)

				if (29 <= 0 and var_815_2 or var_815_2 * (utf8.len(var_815_3) / 29)) > 0 and var_815_2 < var_815_5 then
					arg_812_1.talkMaxDuration = var_815_5

					if var_815_5 + var_815_1 > arg_812_1.duration_ then
						arg_812_1.duration_ = var_815_5 + var_815_1
					end
				end

				arg_812_1.text_.text = var_815_3
				arg_812_1.typewritter.percent = 0

				arg_812_1.typewritter:SetDirty()
				arg_812_1:ShowNextGo(false)
				arg_812_1:RecordContent(arg_812_1.text_.text)
			end

			local var_815_6 = math.max(var_815_2, arg_812_1.talkMaxDuration)

			if var_815_1 <= arg_812_1.time_ and arg_812_1.time_ < var_815_1 + var_815_6 then
				arg_812_1.typewritter.percent = (arg_812_1.time_ - var_815_1) / var_815_6

				arg_812_1.typewritter:SetDirty()
			end

			if arg_812_1.time_ >= var_815_1 + var_815_6 and arg_812_1.time_ < var_815_1 + var_815_6 + arg_815_0 then
				arg_812_1.typewritter.percent = 1

				arg_812_1.typewritter:SetDirty()
				arg_812_1:ShowNextGo(true)
			end
		end

		arg_812_1.nodeConfigList_ = {}

		arg_812_1:InitPlayNodeList()
	end,
	Play1109511201 = function(arg_816_0, arg_816_1)
		arg_816_1.time_ = 0
		arg_816_1.frameCnt_ = 0
		arg_816_1.state_ = "playing"
		arg_816_1.curTalkId_ = 1109511201
		arg_816_1.duration_ = 5

		SetActive(arg_816_1.tipsGo_, false)

		function arg_816_1.onSingleLineFinish_()
			arg_816_1.onSingleLineUpdate_ = nil
			arg_816_1.onSingleLineFinish_ = nil
			arg_816_1.state_ = "waiting"
			arg_816_1.auto_ = false
		end

		function arg_816_1.playNext_(arg_818_0)
			arg_816_1.onStoryFinished_()
		end

		function arg_816_1.onSingleLineUpdate_(arg_819_0)
			local var_819_0 = 1.15

			if 0 < arg_816_1.time_ and arg_816_1.time_ <= 0 + arg_819_0 then
				arg_816_1.talkMaxDuration = 0
				arg_816_1.dialogCg_.alpha = 1

				arg_816_1.dialog_:SetActive(true)
				SetActive(arg_816_1.leftNameGo_, false)

				arg_816_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_816_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_816_1:RecordName(arg_816_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_816_1.iconTrs_.gameObject, false)
				arg_816_1.callingController_:SetSelectedState("normal")

				local var_819_1 = arg_816_1:FormatText(arg_816_1:GetWordFromCfg(1109511201).content)

				arg_816_1.text_.text = var_819_1

				LuaForUtil.ClearLinePrefixSymbol(arg_816_1.text_)

				local var_819_3 = 46 <= 0 and var_819_0 or var_819_0 * (utf8.len(var_819_1) / 46)

				if (46 <= 0 and var_819_0 or var_819_0 * (utf8.len(var_819_1) / 46)) > 0 and var_819_0 < var_819_3 then
					arg_816_1.talkMaxDuration = var_819_3

					if var_819_3 + 0 > arg_816_1.duration_ then
						arg_816_1.duration_ = var_819_3 + 0
					end
				end

				arg_816_1.text_.text = var_819_1
				arg_816_1.typewritter.percent = 0

				arg_816_1.typewritter:SetDirty()
				arg_816_1:ShowNextGo(false)
				arg_816_1:RecordContent(arg_816_1.text_.text)
			end

			local var_819_4 = math.max(var_819_0, arg_816_1.talkMaxDuration)

			if 0 <= arg_816_1.time_ and arg_816_1.time_ < 0 + var_819_4 then
				arg_816_1.typewritter.percent = (arg_816_1.time_ - 0) / var_819_4

				arg_816_1.typewritter:SetDirty()
			end

			if arg_816_1.time_ >= 0 + var_819_4 and arg_816_1.time_ < 0 + var_819_4 + arg_819_0 then
				arg_816_1.typewritter.percent = 1

				arg_816_1.typewritter:SetDirty()
				arg_816_1:ShowNextGo(true)
			end
		end

		arg_816_1.nodeConfigList_ = {}

		arg_816_1:InitPlayNodeList()
	end,
	Play1109511173 = function(arg_820_0, arg_820_1)
		arg_820_1.time_ = 0
		arg_820_1.frameCnt_ = 0
		arg_820_1.state_ = "playing"
		arg_820_1.curTalkId_ = 1109511173
		arg_820_1.duration_ = 2

		SetActive(arg_820_1.tipsGo_, false)

		function arg_820_1.onSingleLineFinish_()
			arg_820_1.onSingleLineUpdate_ = nil
			arg_820_1.onSingleLineFinish_ = nil
			arg_820_1.state_ = "waiting"
		end

		function arg_820_1.playNext_(arg_822_0)
			if arg_822_0 == 1 then
				arg_820_0:Play1109511174(arg_820_1)
			end
		end

		function arg_820_1.onSingleLineUpdate_(arg_823_0)
			if arg_820_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_823_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_820_1.stage_.transform)

				var_823_0.name = "10058ui_story"
				var_823_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_820_1.actors_["10058ui_story"] = var_823_0

				local var_823_1 = var_823_0:GetComponentInChildren(typeof(CharacterEffect))

				var_823_1.enabled = true

				local var_823_2 = GameObjectTools.GetOrAddComponent(var_823_0, typeof(DynamicBoneHelper))

				if var_823_2 then
					var_823_2:EnableDynamicBone(false)
				end

				arg_820_1:ShowWeapon(var_823_1.transform, false)

				arg_820_1.var_["10058ui_story" .. "Animator"] = var_823_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_820_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_820_1.var_["10058ui_story" .. "LipSync"] = var_823_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_820_1.time_ and arg_820_1.time_ <= 0 + arg_823_0 then
				arg_820_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_823_3 = arg_820_1.actors_["10058ui_story"].transform

			if 0 < arg_820_1.time_ and arg_820_1.time_ <= 0 + arg_823_0 then
				arg_820_1.var_.moveOldPos10058ui_story = var_823_3.localPosition
			end

			local var_823_4 = 0.001

			if 0 <= arg_820_1.time_ and arg_820_1.time_ < 0 + var_823_4 then
				var_823_3.localPosition = Vector3.Lerp(arg_820_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_820_1.time_ - 0) / var_823_4)
				var_823_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_823_3.position).x, (manager.ui.mainCamera.transform.position - var_823_3.position).y, (manager.ui.mainCamera.transform.position - var_823_3.position).z)
				var_823_3.localEulerAngles.z = 0
				var_823_3.localEulerAngles.x = 0
				var_823_3.localEulerAngles = var_823_3.localEulerAngles
			end

			if arg_820_1.time_ >= 0 + var_823_4 and arg_820_1.time_ < 0 + var_823_4 + arg_823_0 then
				var_823_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_823_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_823_3.position).x, (manager.ui.mainCamera.transform.position - var_823_3.position).y, (manager.ui.mainCamera.transform.position - var_823_3.position).z)
				var_823_3.localEulerAngles.z = 0
				var_823_3.localEulerAngles.x = 0
				var_823_3.localEulerAngles = var_823_3.localEulerAngles
			end

			local var_823_5 = "10058ui_story"

			if arg_820_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_823_6 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_820_1.stage_.transform)

				var_823_6.name = var_823_5
				var_823_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_820_1.actors_[var_823_5] = var_823_6

				local var_823_7 = var_823_6:GetComponentInChildren(typeof(CharacterEffect))

				var_823_7.enabled = true

				local var_823_8 = GameObjectTools.GetOrAddComponent(var_823_6, typeof(DynamicBoneHelper))

				if var_823_8 then
					var_823_8:EnableDynamicBone(false)
				end

				arg_820_1:ShowWeapon(var_823_7.transform, false)

				arg_820_1.var_[var_823_5 .. "Animator"] = var_823_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_820_1.var_[var_823_5 .. "Animator"].applyRootMotion = true
				arg_820_1.var_[var_823_5 .. "LipSync"] = var_823_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_820_1.time_ and arg_820_1.time_ <= 0 + arg_823_0 then
				arg_820_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_823_9 = arg_820_1.actors_["10058ui_story"]

			if 0 < arg_820_1.time_ and arg_820_1.time_ <= 0 + arg_823_0 and not isNil(var_823_9) and arg_820_1.var_.characterEffect10058ui_story == nil then
				arg_820_1.var_.characterEffect10058ui_story = var_823_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_823_10 = 0.200000002980232

			if 0 <= arg_820_1.time_ and arg_820_1.time_ < 0 + var_823_10 and not isNil(var_823_9) then
				if arg_820_1.var_.characterEffect10058ui_story and not isNil(var_823_9) then
					arg_820_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_820_1.time_ >= 0 + var_823_10 and arg_820_1.time_ < 0 + var_823_10 + arg_823_0 and not isNil(var_823_9) and arg_820_1.var_.characterEffect10058ui_story then
				arg_820_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_823_12 = 0
			local var_823_13 = 0.05

			if 0 < arg_820_1.time_ and arg_820_1.time_ <= var_823_12 + arg_823_0 then
				arg_820_1.talkMaxDuration = 0
				arg_820_1.dialogCg_.alpha = 1

				arg_820_1.dialog_:SetActive(true)
				SetActive(arg_820_1.leftNameGo_, true)

				arg_820_1.leftNameTxt_.text = arg_820_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_820_1.leftNameTxt_.transform)

				arg_820_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_820_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_820_1:RecordName(arg_820_1.leftNameTxt_.text)
				SetActive(arg_820_1.iconTrs_.gameObject, false)
				arg_820_1.callingController_:SetSelectedState("normal")

				local var_823_14 = arg_820_1:GetWordFromCfg(1109511173)
				local var_823_15 = arg_820_1:FormatText(var_823_14.content)

				arg_820_1.text_.text = var_823_15

				LuaForUtil.ClearLinePrefixSymbol(arg_820_1.text_)

				local var_823_17 = 2 <= 0 and var_823_13 or var_823_13 * (utf8.len(var_823_15) / 2)

				if (2 <= 0 and var_823_13 or var_823_13 * (utf8.len(var_823_15) / 2)) > 0 and var_823_13 < var_823_17 then
					arg_820_1.talkMaxDuration = var_823_17

					if var_823_17 + var_823_12 > arg_820_1.duration_ then
						arg_820_1.duration_ = var_823_17 + var_823_12
					end
				end

				arg_820_1.text_.text = var_823_15
				arg_820_1.typewritter.percent = 0

				arg_820_1.typewritter:SetDirty()
				arg_820_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb") ~= 0 then
					local var_823_18 = manager.audio:GetVoiceLength("story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb") / 1000

					if var_823_18 + var_823_12 > arg_820_1.duration_ then
						arg_820_1.duration_ = var_823_18 + var_823_12
					end

					if var_823_14.prefab_name ~= "" and arg_820_1.actors_[var_823_14.prefab_name] ~= nil then
						local var_823_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_820_1.actors_[var_823_14.prefab_name].transform, "story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb")

						arg_820_1:RecordAudio("1109511173", var_823_19)
						arg_820_1:RecordAudio("1109511173", var_823_19)
					else
						arg_820_1:AudioAction("play", "voice", "story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb")
					end

					arg_820_1:RecordHistoryTalkVoice("story_v_side_new_1109511", "1109511173", "story_v_side_new_1109511.awb")
				end

				arg_820_1:RecordContent(arg_820_1.text_.text)
			end

			local var_823_20 = math.max(var_823_13, arg_820_1.talkMaxDuration)

			if var_823_12 <= arg_820_1.time_ and arg_820_1.time_ < var_823_12 + var_823_20 then
				arg_820_1.typewritter.percent = (arg_820_1.time_ - var_823_12) / var_823_20

				arg_820_1.typewritter:SetDirty()
			end

			if arg_820_1.time_ >= var_823_12 + var_823_20 and arg_820_1.time_ < var_823_12 + var_823_20 + arg_823_0 then
				arg_820_1.typewritter.percent = 1

				arg_820_1.typewritter:SetDirty()
				arg_820_1:ShowNextGo(true)
			end
		end

		arg_820_1.nodeConfigList_ = {
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

		arg_820_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0104",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/X203I",
		"TextureConfig/Background/X203K",
		"TextureConfig/Background/X203g",
		"TextureConfig/Background/ST70",
		"TextureConfig/Background/ST77"
	},
	voices = {
		"story_v_side_new_1109511.awb"
	}
}
