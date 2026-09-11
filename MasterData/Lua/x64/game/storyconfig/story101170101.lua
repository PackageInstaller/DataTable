return {
	Play117011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play117011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I08b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I08b")
				var_4_0.name = "I08b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I08b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I08b

				arg_1_1.bgs_.I08b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I08b" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_17", "se_story_17_fire_loop", "")
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

			local var_4_12 = 2
			local var_4_13 = 0.4

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(117011001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 16 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 16)

				if (16 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 16)) > 0 and var_4_13 < var_4_17 then
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
	Play117011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 117011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play117011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_11_0 = 2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 then
				local var_11_1, var_11_2 = math.modf((arg_8_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_11_2 * 0.13, var_11_2 * 0.13, var_11_2 * 0.13) + arg_8_1.var_.shakeOldPos
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 then
				manager.ui.mainCamera.transform.localPosition = arg_8_1.var_.shakeOldPos
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_hawk1", "")
			end

			local var_11_4 = 0
			local var_11_5 = 1.65

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(117011002).content)

				arg_8_1.text_.text = var_11_6

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 66 <= 0 and var_11_5 or var_11_5 * (utf8.len(var_11_6) / 66)

				if (66 <= 0 and var_11_5 or var_11_5 * (utf8.len(var_11_6) / 66)) > 0 and var_11_5 < var_11_8 then
					arg_8_1.talkMaxDuration = var_11_8

					if var_11_8 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_6
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_9 and arg_8_1.time_ < var_11_4 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play117011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 117011003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play117011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.825

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(117011003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 33 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 33)

				if (33 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 33)) > 0 and var_15_0 < var_15_3 then
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
	Play117011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 117011004
		arg_16_1.duration_ = 2.97

		local var_16_0 = {
			zh = 1.3,
			ja = 2.966
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
				arg_16_0:Play117011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_19_0 = 0.6

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				local var_19_1, var_19_2 = math.modf((arg_16_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_19_2 * 0.13, var_19_2 * 0.13, var_19_2 * 0.13) + arg_16_1.var_.shakeOldPos
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				manager.ui.mainCamera.transform.localPosition = arg_16_1.var_.shakeOldPos
			end

			local var_19_3 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_3 + 0.6 and arg_16_1.time_ < var_19_3 + 0.6 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_4 = 0
			local var_19_5 = 0.075

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10034_split_2")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_6 = arg_16_1:GetWordFromCfg(117011004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 3 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 3)

				if (3 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 3)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011004", "story_v_out_117011.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_117011", "117011004", "story_v_out_117011.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_out_117011", "117011004", "story_v_out_117011.awb")

						arg_16_1:RecordAudio("117011004", var_19_11)
						arg_16_1:RecordAudio("117011004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_117011", "117011004", "story_v_out_117011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_117011", "117011004", "story_v_out_117011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play117011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 117011005
		arg_20_1.duration_ = 5.6

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play117011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_23_0 = 1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				local var_23_1, var_23_2 = math.modf((arg_20_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_23_2 * 0.13, var_23_2 * 0.13, var_23_2 * 0.13) + arg_20_1.var_.shakeOldPos
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				manager.ui.mainCamera.transform.localPosition = arg_20_1.var_.shakeOldPos
			end

			local var_23_3 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_3 + 1 and arg_20_1.time_ < var_23_3 + 1 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks04", "")
			end

			if 0.6 < arg_20_1.time_ and arg_20_1.time_ <= 0.6 + arg_23_0 then
				arg_20_1:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_hawk3", "")
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_6 = 0.6
			local var_23_7 = 1.075

			if 0.6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_8 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_8:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(117011005).content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 43 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 43)

				if (43 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 43)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11
					var_23_6 = var_23_6 + 0.3

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = var_23_6 + 0.3
			local var_23_13 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_13

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play117011006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 117011006
		arg_26_1.duration_ = 11.6

		local var_26_0 = {
			zh = 11.6,
			ja = 9.266
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play117011007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if arg_26_1.bgs_.TI0101 == nil then
				local var_29_0 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "TI0101")
				var_29_0.name = "TI0101"
				var_29_0.transform.parent = arg_26_1.stage_.transform
				var_29_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_.TI0101 = var_29_0
			end

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= 2 + arg_29_0 then
				local var_29_1 = arg_26_1.bgs_.TI0101

				arg_26_1.bgs_.TI0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_2 = var_29_1:GetComponent("SpriteRenderer")

				if var_29_2 and var_29_2.sprite then
					local var_29_3 = 2 * (var_29_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_1.transform.localScale = Vector3.New(var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "TI0101" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_4 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_5 = 2

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_5 then
				local var_29_6 = Color.New(0, 0, 0)

				var_29_6.a = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_4) / var_29_5)
				arg_26_1.mask_.color = var_29_6
			end

			if arg_26_1.time_ >= var_29_4 + var_29_5 and arg_26_1.time_ < var_29_4 + var_29_5 + arg_29_0 then
				local var_29_7 = Color.New(0, 0, 0)

				var_29_7.a = 1
				arg_26_1.mask_.color = var_29_7
			end

			local var_29_8 = 2

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_9 = 2

			if var_29_8 <= arg_26_1.time_ and arg_26_1.time_ < var_29_8 + var_29_9 then
				local var_29_10 = Color.New(0, 0, 0)

				var_29_10.a = Mathf.Lerp(1, 0, (arg_26_1.time_ - var_29_8) / var_29_9)
				arg_26_1.mask_.color = var_29_10
			end

			if arg_26_1.time_ >= var_29_8 + var_29_9 and arg_26_1.time_ < var_29_8 + var_29_9 + arg_29_0 then
				local var_29_11 = Color.New(0, 0, 0)

				arg_26_1.mask_.enabled = false
				var_29_11.a = 0
				arg_26_1.mask_.color = var_29_11
			end

			local var_29_12 = arg_26_1.bgs_.TI0101.transform

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= 2 + arg_29_0 then
				arg_26_1.var_.moveOldPosTI0101 = var_29_12.localPosition
			end

			local var_29_13 = 0.001

			if 2 <= arg_26_1.time_ and arg_26_1.time_ < 2 + var_29_13 then
				var_29_12.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosTI0101, Vector3.New(0, 1, 9), (arg_26_1.time_ - 2) / var_29_13)
			end

			if arg_26_1.time_ >= 2 + var_29_13 and arg_26_1.time_ < 2 + var_29_13 + arg_29_0 then
				var_29_12.localPosition = Vector3.New(0, 1, 9)
			end

			local var_29_14 = arg_26_1.bgs_.TI0101.transform

			if 2.034 < arg_26_1.time_ and arg_26_1.time_ <= 2.034 + arg_29_0 then
				arg_26_1.var_.moveOldPosTI0101 = var_29_14.localPosition
			end

			local var_29_15 = 5.5

			if 2.034 <= arg_26_1.time_ and arg_26_1.time_ < 2.034 + var_29_15 then
				var_29_14.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosTI0101, Vector3.New(0, 1, 10), (arg_26_1.time_ - 2.034) / var_29_15)
			end

			if arg_26_1.time_ >= 2.034 + var_29_15 and arg_26_1.time_ < 2.034 + var_29_15 + arg_29_0 then
				var_29_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_29_16 = 4

			if 4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			if arg_26_1.time_ >= var_29_16 + 3.534 and arg_26_1.time_ < var_29_16 + 3.534 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:AudioAction("stop", "effect", "se_story_17", "se_story_17_fire_loop", "")
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_18 = 4
			local var_29_19 = 0.975

			if 4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_18 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_20 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_20:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_26_1.dialogCg_.alpha = arg_30_0
				end))
				var_29_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_21 = arg_26_1:GetWordFromCfg(117011006)
				local var_29_22 = arg_26_1:FormatText(var_29_21.content)

				arg_26_1.text_.text = var_29_22

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_24 = 39 <= 0 and var_29_19 or var_29_19 * (utf8.len(var_29_22) / 39)

				if (39 <= 0 and var_29_19 or var_29_19 * (utf8.len(var_29_22) / 39)) > 0 and var_29_19 < var_29_24 then
					arg_26_1.talkMaxDuration = var_29_24
					var_29_18 = var_29_18 + 0.3

					if var_29_24 + var_29_18 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_24 + var_29_18
					end
				end

				arg_26_1.text_.text = var_29_22
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011006", "story_v_out_117011.awb") ~= 0 then
					local var_29_25 = manager.audio:GetVoiceLength("story_v_out_117011", "117011006", "story_v_out_117011.awb") / 1000

					if var_29_25 + var_29_18 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_25 + var_29_18
					end

					if var_29_21.prefab_name ~= "" and arg_26_1.actors_[var_29_21.prefab_name] ~= nil then
						local var_29_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_21.prefab_name].transform, "story_v_out_117011", "117011006", "story_v_out_117011.awb")

						arg_26_1:RecordAudio("117011006", var_29_26)
						arg_26_1:RecordAudio("117011006", var_29_26)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_117011", "117011006", "story_v_out_117011.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_117011", "117011006", "story_v_out_117011.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_27 = var_29_18 + 0.3
			local var_29_28 = math.max(var_29_19, arg_26_1.talkMaxDuration)

			if var_29_18 + 0.3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_27 + var_29_28 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_27) / var_29_28

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_27 + var_29_28 and arg_26_1.time_ < var_29_27 + var_29_28 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "TI0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "TI0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play117011007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 117011007
		arg_32_1.duration_ = 8.03

		local var_32_0 = {
			zh = 8.033,
			ja = 6.2
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
				arg_32_0:Play117011008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 1.025

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(117011007)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 41 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 41)

				if (41 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 41)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011007", "story_v_out_117011.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011007", "story_v_out_117011.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_117011", "117011007", "story_v_out_117011.awb")

						arg_32_1:RecordAudio("117011007", var_35_6)
						arg_32_1:RecordAudio("117011007", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_117011", "117011007", "story_v_out_117011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_117011", "117011007", "story_v_out_117011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play117011008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 117011008
		arg_36_1.duration_ = 12.63

		local var_36_0 = {
			zh = 6.8,
			ja = 12.633
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
				arg_36_0:Play117011009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.85

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(117011008)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 34 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 34)

				if (34 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 34)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011008", "story_v_out_117011.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011008", "story_v_out_117011.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_117011", "117011008", "story_v_out_117011.awb")

						arg_36_1:RecordAudio("117011008", var_39_6)
						arg_36_1:RecordAudio("117011008", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_117011", "117011008", "story_v_out_117011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_117011", "117011008", "story_v_out_117011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play117011009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 117011009
		arg_40_1.duration_ = 7.23

		local var_40_0 = {
			zh = 7.233,
			ja = 4.366
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
				arg_40_0:Play117011010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.9

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(117011009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 36 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 36)

				if (36 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 36)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011009", "story_v_out_117011.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011009", "story_v_out_117011.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_117011", "117011009", "story_v_out_117011.awb")

						arg_40_1:RecordAudio("117011009", var_43_6)
						arg_40_1:RecordAudio("117011009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_117011", "117011009", "story_v_out_117011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_117011", "117011009", "story_v_out_117011.awb")
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
	Play117011010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 117011010
		arg_44_1.duration_ = 9.93

		local var_44_0 = {
			zh = 9.933,
			ja = 6.666
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play117011011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.15

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:GetWordFromCfg(117011010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 46 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 46)

				if (46 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 46)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011010", "story_v_out_117011.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011010", "story_v_out_117011.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_117011", "117011010", "story_v_out_117011.awb")

						arg_44_1:RecordAudio("117011010", var_47_6)
						arg_44_1:RecordAudio("117011010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_117011", "117011010", "story_v_out_117011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_117011", "117011010", "story_v_out_117011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play117011011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 117011011
		arg_48_1.duration_ = 6.53

		local var_48_0 = {
			zh = 3.8,
			ja = 6.533
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
				arg_48_0:Play117011012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.55

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[368].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:GetWordFromCfg(117011011)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 22 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 22)

				if (22 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 22)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011011", "story_v_out_117011.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011011", "story_v_out_117011.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_117011", "117011011", "story_v_out_117011.awb")

						arg_48_1:RecordAudio("117011011", var_51_6)
						arg_48_1:RecordAudio("117011011", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_117011", "117011011", "story_v_out_117011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_117011", "117011011", "story_v_out_117011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play117011012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 117011012
		arg_52_1.duration_ = 9

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play117011013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_0 = 2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				local var_55_1 = Color.New(0, 0, 0)

				var_55_1.a = Mathf.Lerp(0, 1, (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.mask_.color = var_55_1
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				local var_55_2 = Color.New(0, 0, 0)

				var_55_2.a = 1
				arg_52_1.mask_.color = var_55_2
			end

			local var_55_3 = 2

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_4 = 2

			if var_55_3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_3 + var_55_4 then
				local var_55_5 = Color.New(0, 0, 0)

				var_55_5.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_3) / var_55_4)
				arg_52_1.mask_.color = var_55_5
			end

			if arg_52_1.time_ >= var_55_3 + var_55_4 and arg_52_1.time_ < var_55_3 + var_55_4 + arg_55_0 then
				local var_55_6 = Color.New(0, 0, 0)

				arg_52_1.mask_.enabled = false
				var_55_6.a = 0
				arg_52_1.mask_.color = var_55_6
			end

			local var_55_7 = "ST12"

			if arg_52_1.bgs_.ST12 == nil then
				local var_55_8 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_7)
				var_55_8.name = var_55_7
				var_55_8.transform.parent = arg_52_1.stage_.transform
				var_55_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_7] = var_55_8
			end

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= 2 + arg_55_0 then
				local var_55_9 = arg_52_1.bgs_.ST12

				arg_52_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_10 = var_55_9:GetComponent("SpriteRenderer")

				if var_55_10 and var_55_10.sprite then
					local var_55_11 = 2 * (var_55_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_9.transform.localScale = Vector3.New(var_55_11 / var_55_10.sprite.bounds.size.y < var_55_11 * manager.ui.mainCameraCom_.aspect / var_55_10.sprite.bounds.size.x and var_55_11 * manager.ui.mainCameraCom_.aspect / var_55_10.sprite.bounds.size.x or var_55_11 / var_55_10.sprite.bounds.size.y, var_55_11 / var_55_10.sprite.bounds.size.y < var_55_11 * manager.ui.mainCameraCom_.aspect / var_55_10.sprite.bounds.size.x and var_55_11 * manager.ui.mainCameraCom_.aspect / var_55_10.sprite.bounds.size.x or var_55_11 / var_55_10.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "ST12" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_12 = 4
			local var_55_13 = 1.2

			if 4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_14 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_14:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(117011012).content)

				arg_52_1.text_.text = var_55_15

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 48 <= 0 and var_55_13 or var_55_13 * (utf8.len(var_55_15) / 48)

				if (48 <= 0 and var_55_13 or var_55_13 * (utf8.len(var_55_15) / 48)) > 0 and var_55_13 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17
					var_55_12 = var_55_12 + 0.3

					if var_55_17 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_15
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_18 = var_55_12 + 0.3
			local var_55_19 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_19 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_18) / var_55_19

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_18 + var_55_19 and arg_52_1.time_ < var_55_18 + var_55_19 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play117011013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 117011013
		arg_58_1.duration_ = 5.1

		local var_58_0 = {
			zh = 4.466,
			ja = 5.1
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
				arg_58_0:Play117011014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if arg_58_1.actors_["1029"] == nil then
				local var_61_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1029")

				if not isNil(var_61_0) then
					local var_61_1 = Object.Instantiate(var_61_0, arg_58_1.canvasGo_.transform)

					var_61_1.transform:SetSiblingIndex(1)

					var_61_1.name = "1029"
					var_61_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_58_1.actors_["1029"] = var_61_1

					if arg_58_1.isInRecall_ then
						for iter_61_0, iter_61_1 in ipairs((var_61_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_61_1.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_61_2 = arg_58_1.actors_["1029"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1029 = var_61_2.localPosition
				var_61_2.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("1029", 2)

				for iter_61_2 = 0, var_61_2.childCount - 1 do
					local var_61_3 = var_61_2:GetChild(iter_61_2)

					if var_61_3.name == "split_1" or not string.find(var_61_3.name, "split") then
						var_61_3.gameObject:SetActive(true)
					else
						var_61_3.gameObject:SetActive(false)
					end
				end
			end

			local var_61_4 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				var_61_2.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1029, Vector3.New(-390, -355, -140), (arg_58_1.time_ - 0) / var_61_4)
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				var_61_2.localPosition = Vector3.New(-390, -355, -140)
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				local var_61_5 = arg_58_1.actors_["1029"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_61_5 then
					arg_58_1.var_.alphaOldValue1029 = var_61_5.alpha
					arg_58_1.var_.characterEffect1029 = var_61_5
				end

				arg_58_1.var_.alphaOldValue1029 = 0
			end

			local var_61_6 = 0.333333333333333

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_6 then
				if arg_58_1.var_.characterEffect1029 then
					arg_58_1.var_.characterEffect1029.alpha = Mathf.Lerp(arg_58_1.var_.alphaOldValue1029, 1, (arg_58_1.time_ - 0) / var_61_6)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_6 and arg_58_1.time_ < 0 + var_61_6 + arg_61_0 and arg_58_1.var_.characterEffect1029 then
				arg_58_1.var_.characterEffect1029.alpha = 1
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_61_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_9 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_9

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_9
						arg_58_1.bgmTxt2_.text = var_61_9
					end

					if arg_58_1.bgmTimer then
						arg_58_1.bgmTimer:Stop()

						arg_58_1.bgmTimer = nil
					end

					if arg_58_1.settingData.show_music_name == 1 then
						arg_58_1.musicController:SetSelectedState("show")
						arg_58_1.musicAnimator_:Play("open", 0, 0)

						if arg_58_1.settingData.music_time ~= 0 then
							arg_58_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_58_1.settingData.music_time), function()
								if arg_58_1 == nil or isNil(arg_58_1.bgmTxt_) then
									return
								end

								arg_58_1.musicController:SetSelectedState("hide")
								arg_58_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_58_1.time_ and arg_58_1.time_ <= 0.2 + arg_61_0 then
				arg_58_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_61_12 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_12 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_12

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_12
						arg_58_1.bgmTxt2_.text = var_61_12
					end

					if arg_58_1.bgmTimer then
						arg_58_1.bgmTimer:Stop()

						arg_58_1.bgmTimer = nil
					end

					if arg_58_1.settingData.show_music_name == 1 then
						arg_58_1.musicController:SetSelectedState("show")
						arg_58_1.musicAnimator_:Play("open", 0, 0)

						if arg_58_1.settingData.music_time ~= 0 then
							arg_58_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_58_1.settingData.music_time), function()
								if arg_58_1 == nil or isNil(arg_58_1.bgmTxt_) then
									return
								end

								arg_58_1.musicController:SetSelectedState("hide")
								arg_58_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_61_13 = 0
			local var_61_14 = 0.5

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_13 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_15 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_15:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_58_1.dialogCg_.alpha = arg_64_0
				end))
				var_61_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_16 = arg_58_1:GetWordFromCfg(117011013)
				local var_61_17 = arg_58_1:FormatText(var_61_16.content)

				arg_58_1.text_.text = var_61_17

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_19 = 20 <= 0 and var_61_14 or var_61_14 * (utf8.len(var_61_17) / 20)

				if (20 <= 0 and var_61_14 or var_61_14 * (utf8.len(var_61_17) / 20)) > 0 and var_61_14 < var_61_19 then
					arg_58_1.talkMaxDuration = var_61_19
					var_61_13 = var_61_13 + 0.3

					if var_61_19 + var_61_13 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_19 + var_61_13
					end
				end

				arg_58_1.text_.text = var_61_17
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011013", "story_v_out_117011.awb") ~= 0 then
					local var_61_20 = manager.audio:GetVoiceLength("story_v_out_117011", "117011013", "story_v_out_117011.awb") / 1000

					if var_61_20 + var_61_13 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_20 + var_61_13
					end

					if var_61_16.prefab_name ~= "" and arg_58_1.actors_[var_61_16.prefab_name] ~= nil then
						local var_61_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_16.prefab_name].transform, "story_v_out_117011", "117011013", "story_v_out_117011.awb")

						arg_58_1:RecordAudio("117011013", var_61_21)
						arg_58_1:RecordAudio("117011013", var_61_21)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_117011", "117011013", "story_v_out_117011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_117011", "117011013", "story_v_out_117011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_22 = var_61_13 + 0.3
			local var_61_23 = math.max(var_61_14, arg_58_1.talkMaxDuration)

			if var_61_13 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_22 + var_61_23 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_22) / var_61_23

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_22 + var_61_23 and arg_58_1.time_ < var_61_22 + var_61_23 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play117011014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 117011014
		arg_66_1.duration_ = 5.6

		local var_66_0 = {
			zh = 5.6,
			ja = 4.966
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
				arg_66_0:Play117011015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.actors_["1033"] == nil then
				local var_69_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_69_0) then
					local var_69_1 = Object.Instantiate(var_69_0, arg_66_1.canvasGo_.transform)

					var_69_1.transform:SetSiblingIndex(1)

					var_69_1.name = "1033"
					var_69_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_66_1.actors_["1033"] = var_69_1

					if arg_66_1.isInRecall_ then
						for iter_69_0, iter_69_1 in ipairs((var_69_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_69_1.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_69_2 = arg_66_1.actors_["1033"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1033 = var_69_2.localPosition
				var_69_2.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1033", 4)

				for iter_69_2 = 0, var_69_2.childCount - 1 do
					local var_69_3 = var_69_2:GetChild(iter_69_2)

					if var_69_3.name == "split_6" or not string.find(var_69_3.name, "split") then
						var_69_3.gameObject:SetActive(true)
					else
						var_69_3.gameObject:SetActive(false)
					end
				end
			end

			local var_69_4 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				var_69_2.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_66_1.time_ - 0) / var_69_4)
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				var_69_2.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				local var_69_5 = arg_66_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_69_5 then
					arg_66_1.var_.alphaOldValue1033 = var_69_5.alpha
					arg_66_1.var_.characterEffect1033 = var_69_5
				end

				arg_66_1.var_.alphaOldValue1033 = 0
			end

			local var_69_6 = 0.333333333333333

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_6 then
				if arg_66_1.var_.characterEffect1033 then
					arg_66_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_66_1.var_.alphaOldValue1033, 1, (arg_66_1.time_ - 0) / var_69_6)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_6 and arg_66_1.time_ < 0 + var_69_6 + arg_69_0 and arg_66_1.var_.characterEffect1033 then
				arg_66_1.var_.characterEffect1033.alpha = 1
			end

			local var_69_7 = arg_66_1.actors_["1029"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_7) and arg_66_1.var_.actorSpriteComps1029 == nil then
				arg_66_1.var_.actorSpriteComps1029 = var_69_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_8 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_8 and not isNil(var_69_7) then
				if arg_66_1.var_.actorSpriteComps1029 then
					for iter_69_3, iter_69_4 in pairs(arg_66_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_69_4 then
							if arg_66_1.isInRecall_ then
								iter_69_4.color = Color.New(Mathf.Lerp(iter_69_4.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_8), Mathf.Lerp(iter_69_4.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_8), (Mathf.Lerp(iter_69_4.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_8)))
							else
								local var_69_9 = Mathf.Lerp(iter_69_4.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_8)

								iter_69_4.color = Color.New(var_69_9, var_69_9, var_69_9)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_8 and arg_66_1.time_ < 0 + var_69_8 + arg_69_0 and not isNil(var_69_7) and arg_66_1.var_.actorSpriteComps1029 then
				for iter_69_5, iter_69_6 in pairs(arg_66_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_69_6 then
						iter_69_6.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps1029 = nil
			end

			local var_69_10 = 0
			local var_69_11 = 0.3

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_12 = arg_66_1:GetWordFromCfg(117011014)
				local var_69_13 = arg_66_1:FormatText(var_69_12.content)

				arg_66_1.text_.text = var_69_13

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_15 = 12 <= 0 and var_69_11 or var_69_11 * (utf8.len(var_69_13) / 12)

				if (12 <= 0 and var_69_11 or var_69_11 * (utf8.len(var_69_13) / 12)) > 0 and var_69_11 < var_69_15 then
					arg_66_1.talkMaxDuration = var_69_15

					if var_69_15 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_15 + var_69_10
					end
				end

				arg_66_1.text_.text = var_69_13
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011014", "story_v_out_117011.awb") ~= 0 then
					local var_69_16 = manager.audio:GetVoiceLength("story_v_out_117011", "117011014", "story_v_out_117011.awb") / 1000

					if var_69_16 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_10
					end

					if var_69_12.prefab_name ~= "" and arg_66_1.actors_[var_69_12.prefab_name] ~= nil then
						local var_69_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_12.prefab_name].transform, "story_v_out_117011", "117011014", "story_v_out_117011.awb")

						arg_66_1:RecordAudio("117011014", var_69_17)
						arg_66_1:RecordAudio("117011014", var_69_17)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_117011", "117011014", "story_v_out_117011.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_117011", "117011014", "story_v_out_117011.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_18 = math.max(var_69_11, arg_66_1.talkMaxDuration)

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_18 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_10) / var_69_18

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_10 + var_69_18 and arg_66_1.time_ < var_69_10 + var_69_18 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play117011015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 117011015
		arg_70_1.duration_ = 8.63

		local var_70_0 = {
			zh = 8.633,
			ja = 6
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
				arg_70_0:Play117011016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.125

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:GetWordFromCfg(117011015)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 45 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 45)

				if (45 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 45)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011015", "story_v_out_117011.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011015", "story_v_out_117011.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_117011", "117011015", "story_v_out_117011.awb")

						arg_70_1:RecordAudio("117011015", var_73_6)
						arg_70_1:RecordAudio("117011015", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_117011", "117011015", "story_v_out_117011.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_117011", "117011015", "story_v_out_117011.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play117011016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 117011016
		arg_74_1.duration_ = 8.53

		local var_74_0 = {
			zh = 8.533,
			ja = 4.133
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
				arg_74_0:Play117011017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.95

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:GetWordFromCfg(117011016)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 38 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 38)

				if (38 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 38)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011016", "story_v_out_117011.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011016", "story_v_out_117011.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_117011", "117011016", "story_v_out_117011.awb")

						arg_74_1:RecordAudio("117011016", var_77_6)
						arg_74_1:RecordAudio("117011016", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_117011", "117011016", "story_v_out_117011.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_117011", "117011016", "story_v_out_117011.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play117011017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 117011017
		arg_78_1.duration_ = 12.83

		local var_78_0 = {
			zh = 3.6,
			ja = 12.833
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play117011018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.35

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:GetWordFromCfg(117011017)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 14 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 14)

				if (14 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 14)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011017", "story_v_out_117011.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011017", "story_v_out_117011.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_117011", "117011017", "story_v_out_117011.awb")

						arg_78_1:RecordAudio("117011017", var_81_6)
						arg_78_1:RecordAudio("117011017", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_117011", "117011017", "story_v_out_117011.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_117011", "117011017", "story_v_out_117011.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play117011018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 117011018
		arg_82_1.duration_ = 4.33

		local var_82_0 = {
			zh = 3.7,
			ja = 4.333
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play117011019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1033"]) and arg_82_1.var_.actorSpriteComps1033 == nil then
				arg_82_1.var_.actorSpriteComps1033 = arg_82_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1033"]) then
				if arg_82_1.var_.actorSpriteComps1033 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								iter_85_1.color = Color.New(Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor2.r, (arg_82_1.time_ - 0) / var_85_0), Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor2.g, (arg_82_1.time_ - 0) / var_85_0), (Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor2.b, (arg_82_1.time_ - 0) / var_85_0)))
							else
								local var_85_1 = Mathf.Lerp(iter_85_1.color.r, 0.5, (arg_82_1.time_ - 0) / var_85_0)

								iter_85_1.color = Color.New(var_85_1, var_85_1, var_85_1)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1033"]) and arg_82_1.var_.actorSpriteComps1033 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_82_1.var_.actorSpriteComps1033 = nil
			end

			local var_85_2 = arg_82_1.actors_["1029"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps1029 == nil then
				arg_82_1.var_.actorSpriteComps1029 = var_85_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_3 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.actorSpriteComps1029 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								iter_85_5.color = Color.New(Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor1.r, (arg_82_1.time_ - 0) / var_85_3), Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor1.g, (arg_82_1.time_ - 0) / var_85_3), (Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor1.b, (arg_82_1.time_ - 0) / var_85_3)))
							else
								local var_85_4 = Mathf.Lerp(iter_85_5.color.r, 1, (arg_82_1.time_ - 0) / var_85_3)

								iter_85_5.color = Color.New(var_85_4, var_85_4, var_85_4)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps1029 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_85_7 then
						iter_85_7.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_82_1.var_.actorSpriteComps1029 = nil
			end

			local var_85_5 = 0
			local var_85_6 = 0.325

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:GetWordFromCfg(117011018)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 13 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 13)

				if (13 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 13)) > 0 and var_85_6 < var_85_10 then
					arg_82_1.talkMaxDuration = var_85_10

					if var_85_10 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_8
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011018", "story_v_out_117011.awb") ~= 0 then
					local var_85_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011018", "story_v_out_117011.awb") / 1000

					if var_85_11 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_5
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_out_117011", "117011018", "story_v_out_117011.awb")

						arg_82_1:RecordAudio("117011018", var_85_12)
						arg_82_1:RecordAudio("117011018", var_85_12)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_117011", "117011018", "story_v_out_117011.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_117011", "117011018", "story_v_out_117011.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_13 = math.max(var_85_6, arg_82_1.talkMaxDuration)

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_13 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_5) / var_85_13

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_5 + var_85_13 and arg_82_1.time_ < var_85_5 + var_85_13 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play117011019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 117011019
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play117011020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1029"]) and arg_86_1.var_.actorSpriteComps1029 == nil then
				arg_86_1.var_.actorSpriteComps1029 = arg_86_1.actors_["1029"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1029"]) then
				if arg_86_1.var_.actorSpriteComps1029 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, (arg_86_1.time_ - 0) / var_89_0), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, (arg_86_1.time_ - 0) / var_89_0), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, (arg_86_1.time_ - 0) / var_89_0)))
							else
								local var_89_1 = Mathf.Lerp(iter_89_1.color.r, 0.5, (arg_86_1.time_ - 0) / var_89_0)

								iter_89_1.color = Color.New(var_89_1, var_89_1, var_89_1)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1029"]) and arg_86_1.var_.actorSpriteComps1029 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_86_1.var_.actorSpriteComps1029 = nil
			end

			local var_89_2 = 0
			local var_89_3 = 0.6

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_4 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(117011019).content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_6 = 24 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_4) / 24)

				if (24 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_4) / 24)) > 0 and var_89_3 < var_89_6 then
					arg_86_1.talkMaxDuration = var_89_6

					if var_89_6 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_6 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_3, arg_86_1.talkMaxDuration)

			if var_89_2 <= arg_86_1.time_ and arg_86_1.time_ < var_89_2 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_2) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_2 + var_89_7 and arg_86_1.time_ < var_89_2 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play117011020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 117011020
		arg_90_1.duration_ = 5.7

		local var_90_0 = {
			zh = 2.3,
			ja = 5.7
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play117011021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1033"]) and arg_90_1.var_.actorSpriteComps1033 == nil then
				arg_90_1.var_.actorSpriteComps1033 = arg_90_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1033"]) then
				if arg_90_1.var_.actorSpriteComps1033 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 1, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1033"]) and arg_90_1.var_.actorSpriteComps1033 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_90_1.var_.actorSpriteComps1033 = nil
			end

			local var_93_2 = 0
			local var_93_3 = 0.325

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:GetWordFromCfg(117011020)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 13 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 13)

				if (13 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 13)) > 0 and var_93_3 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011020", "story_v_out_117011.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011020", "story_v_out_117011.awb") / 1000

					if var_93_8 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_2
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_117011", "117011020", "story_v_out_117011.awb")

						arg_90_1:RecordAudio("117011020", var_93_9)
						arg_90_1:RecordAudio("117011020", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_117011", "117011020", "story_v_out_117011.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_117011", "117011020", "story_v_out_117011.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_10 and arg_90_1.time_ < var_93_2 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play117011021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 117011021
		arg_94_1.duration_ = 4.17

		local var_94_0 = {
			zh = 2.533,
			ja = 4.166
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play117011022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1033"]) and arg_94_1.var_.actorSpriteComps1033 == nil then
				arg_94_1.var_.actorSpriteComps1033 = arg_94_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1033"]) then
				if arg_94_1.var_.actorSpriteComps1033 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, (arg_94_1.time_ - 0) / var_97_0), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, (arg_94_1.time_ - 0) / var_97_0), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, (arg_94_1.time_ - 0) / var_97_0)))
							else
								local var_97_1 = Mathf.Lerp(iter_97_1.color.r, 0.5, (arg_94_1.time_ - 0) / var_97_0)

								iter_97_1.color = Color.New(var_97_1, var_97_1, var_97_1)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1033"]) and arg_94_1.var_.actorSpriteComps1033 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_94_1.var_.actorSpriteComps1033 = nil
			end

			local var_97_2 = arg_94_1.actors_["1029"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.actorSpriteComps1029 == nil then
				arg_94_1.var_.actorSpriteComps1029 = var_97_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_3 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.actorSpriteComps1029 then
					for iter_97_4, iter_97_5 in pairs(arg_94_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_97_5 then
							if arg_94_1.isInRecall_ then
								iter_97_5.color = Color.New(Mathf.Lerp(iter_97_5.color.r, arg_94_1.hightColor1.r, (arg_94_1.time_ - 0) / var_97_3), Mathf.Lerp(iter_97_5.color.g, arg_94_1.hightColor1.g, (arg_94_1.time_ - 0) / var_97_3), (Mathf.Lerp(iter_97_5.color.b, arg_94_1.hightColor1.b, (arg_94_1.time_ - 0) / var_97_3)))
							else
								local var_97_4 = Mathf.Lerp(iter_97_5.color.r, 1, (arg_94_1.time_ - 0) / var_97_3)

								iter_97_5.color = Color.New(var_97_4, var_97_4, var_97_4)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.actorSpriteComps1029 then
				for iter_97_6, iter_97_7 in pairs(arg_94_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_97_7 then
						iter_97_7.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps1029 = nil
			end

			local var_97_5 = 0
			local var_97_6 = 0.325

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:GetWordFromCfg(117011021)
				local var_97_8 = arg_94_1:FormatText(var_97_7.content)

				arg_94_1.text_.text = var_97_8

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 13 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 13)

				if (13 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 13)) > 0 and var_97_6 < var_97_10 then
					arg_94_1.talkMaxDuration = var_97_10

					if var_97_10 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_8
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011021", "story_v_out_117011.awb") ~= 0 then
					local var_97_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011021", "story_v_out_117011.awb") / 1000

					if var_97_11 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_5
					end

					if var_97_7.prefab_name ~= "" and arg_94_1.actors_[var_97_7.prefab_name] ~= nil then
						local var_97_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_7.prefab_name].transform, "story_v_out_117011", "117011021", "story_v_out_117011.awb")

						arg_94_1:RecordAudio("117011021", var_97_12)
						arg_94_1:RecordAudio("117011021", var_97_12)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_117011", "117011021", "story_v_out_117011.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_117011", "117011021", "story_v_out_117011.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_13 = math.max(var_97_6, arg_94_1.talkMaxDuration)

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_13 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_5) / var_97_13

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_5 + var_97_13 and arg_94_1.time_ < var_97_5 + var_97_13 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play117011022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 117011022
		arg_98_1.duration_ = 9.9

		local var_98_0 = {
			zh = 8.933,
			ja = 9.9
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play117011023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.975

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(117011022)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 39 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 39)

				if (39 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 39)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011022", "story_v_out_117011.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011022", "story_v_out_117011.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_117011", "117011022", "story_v_out_117011.awb")

						arg_98_1:RecordAudio("117011022", var_101_6)
						arg_98_1:RecordAudio("117011022", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_117011", "117011022", "story_v_out_117011.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_117011", "117011022", "story_v_out_117011.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play117011023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 117011023
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play117011024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1029"]) and arg_102_1.var_.actorSpriteComps1029 == nil then
				arg_102_1.var_.actorSpriteComps1029 = arg_102_1.actors_["1029"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1029"]) then
				if arg_102_1.var_.actorSpriteComps1029 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1029"]) and arg_102_1.var_.actorSpriteComps1029 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps1029 = nil
			end

			local var_105_2 = 0
			local var_105_3 = 0.575

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(117011023).content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_6 = 23 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_4) / 23)

				if (23 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_4) / 23)) > 0 and var_105_3 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_7 and arg_102_1.time_ < var_105_2 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play117011024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 117011024
		arg_106_1.duration_ = 7.7

		local var_106_0 = {
			zh = 6.8,
			ja = 7.7
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play117011025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1033"]) and arg_106_1.var_.actorSpriteComps1033 == nil then
				arg_106_1.var_.actorSpriteComps1033 = arg_106_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1033"]) then
				if arg_106_1.var_.actorSpriteComps1033 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								iter_109_1.color = Color.New(Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, (arg_106_1.time_ - 0) / var_109_0), Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, (arg_106_1.time_ - 0) / var_109_0), (Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, (arg_106_1.time_ - 0) / var_109_0)))
							else
								local var_109_1 = Mathf.Lerp(iter_109_1.color.r, 1, (arg_106_1.time_ - 0) / var_109_0)

								iter_109_1.color = Color.New(var_109_1, var_109_1, var_109_1)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1033"]) and arg_106_1.var_.actorSpriteComps1033 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_106_1.var_.actorSpriteComps1033 = nil
			end

			local var_109_2 = 0
			local var_109_3 = 0.825

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(117011024)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 33 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 33)

				if (33 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 33)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011024", "story_v_out_117011.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011024", "story_v_out_117011.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_117011", "117011024", "story_v_out_117011.awb")

						arg_106_1:RecordAudio("117011024", var_109_9)
						arg_106_1:RecordAudio("117011024", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_117011", "117011024", "story_v_out_117011.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_117011", "117011024", "story_v_out_117011.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_10 and arg_106_1.time_ < var_109_2 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play117011025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 117011025
		arg_110_1.duration_ = 8.27

		local var_110_0 = {
			zh = 6.8,
			ja = 8.266
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play117011026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.9

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:GetWordFromCfg(117011025)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 36 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 36)

				if (36 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 36)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011025", "story_v_out_117011.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011025", "story_v_out_117011.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_117011", "117011025", "story_v_out_117011.awb")

						arg_110_1:RecordAudio("117011025", var_113_6)
						arg_110_1:RecordAudio("117011025", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_117011", "117011025", "story_v_out_117011.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_117011", "117011025", "story_v_out_117011.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play117011026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 117011026
		arg_114_1.duration_ = 5.77

		local var_114_0 = {
			zh = 3.6,
			ja = 5.766
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play117011027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1033"]) and arg_114_1.var_.actorSpriteComps1033 == nil then
				arg_114_1.var_.actorSpriteComps1033 = arg_114_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1033"]) then
				if arg_114_1.var_.actorSpriteComps1033 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								iter_117_1.color = Color.New(Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, (arg_114_1.time_ - 0) / var_117_0), Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, (arg_114_1.time_ - 0) / var_117_0), (Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, (arg_114_1.time_ - 0) / var_117_0)))
							else
								local var_117_1 = Mathf.Lerp(iter_117_1.color.r, 0.5, (arg_114_1.time_ - 0) / var_117_0)

								iter_117_1.color = Color.New(var_117_1, var_117_1, var_117_1)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1033"]) and arg_114_1.var_.actorSpriteComps1033 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_117_3 then
						iter_117_3.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_114_1.var_.actorSpriteComps1033 = nil
			end

			local var_117_2 = arg_114_1.actors_["1029"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.actorSpriteComps1029 == nil then
				arg_114_1.var_.actorSpriteComps1029 = var_117_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_3 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.actorSpriteComps1029 then
					for iter_117_4, iter_117_5 in pairs(arg_114_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_117_5 then
							if arg_114_1.isInRecall_ then
								iter_117_5.color = Color.New(Mathf.Lerp(iter_117_5.color.r, arg_114_1.hightColor1.r, (arg_114_1.time_ - 0) / var_117_3), Mathf.Lerp(iter_117_5.color.g, arg_114_1.hightColor1.g, (arg_114_1.time_ - 0) / var_117_3), (Mathf.Lerp(iter_117_5.color.b, arg_114_1.hightColor1.b, (arg_114_1.time_ - 0) / var_117_3)))
							else
								local var_117_4 = Mathf.Lerp(iter_117_5.color.r, 1, (arg_114_1.time_ - 0) / var_117_3)

								iter_117_5.color = Color.New(var_117_4, var_117_4, var_117_4)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.actorSpriteComps1029 then
				for iter_117_6, iter_117_7 in pairs(arg_114_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_117_7 then
						iter_117_7.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_114_1.var_.actorSpriteComps1029 = nil
			end

			local var_117_5 = 0
			local var_117_6 = 0.425

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_7 = arg_114_1:GetWordFromCfg(117011026)
				local var_117_8 = arg_114_1:FormatText(var_117_7.content)

				arg_114_1.text_.text = var_117_8

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_10 = 17 <= 0 and var_117_6 or var_117_6 * (utf8.len(var_117_8) / 17)

				if (17 <= 0 and var_117_6 or var_117_6 * (utf8.len(var_117_8) / 17)) > 0 and var_117_6 < var_117_10 then
					arg_114_1.talkMaxDuration = var_117_10

					if var_117_10 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_5
					end
				end

				arg_114_1.text_.text = var_117_8
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011026", "story_v_out_117011.awb") ~= 0 then
					local var_117_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011026", "story_v_out_117011.awb") / 1000

					if var_117_11 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_5
					end

					if var_117_7.prefab_name ~= "" and arg_114_1.actors_[var_117_7.prefab_name] ~= nil then
						local var_117_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_7.prefab_name].transform, "story_v_out_117011", "117011026", "story_v_out_117011.awb")

						arg_114_1:RecordAudio("117011026", var_117_12)
						arg_114_1:RecordAudio("117011026", var_117_12)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_117011", "117011026", "story_v_out_117011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_117011", "117011026", "story_v_out_117011.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_13 = math.max(var_117_6, arg_114_1.talkMaxDuration)

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_13 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_5) / var_117_13

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_5 + var_117_13 and arg_114_1.time_ < var_117_5 + var_117_13 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play117011027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 117011027
		arg_118_1.duration_ = 1.53

		local var_118_0 = {
			zh = 1.533,
			ja = 0.999999999999
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play117011028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1033"]) and arg_118_1.var_.actorSpriteComps1033 == nil then
				arg_118_1.var_.actorSpriteComps1033 = arg_118_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1033"]) then
				if arg_118_1.var_.actorSpriteComps1033 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								iter_121_1.color = Color.New(Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, (arg_118_1.time_ - 0) / var_121_0), Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, (arg_118_1.time_ - 0) / var_121_0), (Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, (arg_118_1.time_ - 0) / var_121_0)))
							else
								local var_121_1 = Mathf.Lerp(iter_121_1.color.r, 1, (arg_118_1.time_ - 0) / var_121_0)

								iter_121_1.color = Color.New(var_121_1, var_121_1, var_121_1)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1033"]) and arg_118_1.var_.actorSpriteComps1033 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_121_3 then
						iter_121_3.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_118_1.var_.actorSpriteComps1033 = nil
			end

			local var_121_2 = arg_118_1.actors_["1029"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.actorSpriteComps1029 == nil then
				arg_118_1.var_.actorSpriteComps1029 = var_121_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_3 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.actorSpriteComps1029 then
					for iter_121_4, iter_121_5 in pairs(arg_118_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_121_5 then
							if arg_118_1.isInRecall_ then
								iter_121_5.color = Color.New(Mathf.Lerp(iter_121_5.color.r, arg_118_1.hightColor2.r, (arg_118_1.time_ - 0) / var_121_3), Mathf.Lerp(iter_121_5.color.g, arg_118_1.hightColor2.g, (arg_118_1.time_ - 0) / var_121_3), (Mathf.Lerp(iter_121_5.color.b, arg_118_1.hightColor2.b, (arg_118_1.time_ - 0) / var_121_3)))
							else
								local var_121_4 = Mathf.Lerp(iter_121_5.color.r, 0.5, (arg_118_1.time_ - 0) / var_121_3)

								iter_121_5.color = Color.New(var_121_4, var_121_4, var_121_4)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.actorSpriteComps1029 then
				for iter_121_6, iter_121_7 in pairs(arg_118_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_121_7 then
						iter_121_7.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_118_1.var_.actorSpriteComps1029 = nil
			end

			local var_121_5 = 0
			local var_121_6 = 0.2

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_7 = arg_118_1:GetWordFromCfg(117011027)
				local var_121_8 = arg_118_1:FormatText(var_121_7.content)

				arg_118_1.text_.text = var_121_8

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_10 = 8 <= 0 and var_121_6 or var_121_6 * (utf8.len(var_121_8) / 8)

				if (8 <= 0 and var_121_6 or var_121_6 * (utf8.len(var_121_8) / 8)) > 0 and var_121_6 < var_121_10 then
					arg_118_1.talkMaxDuration = var_121_10

					if var_121_10 + var_121_5 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_5
					end
				end

				arg_118_1.text_.text = var_121_8
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011027", "story_v_out_117011.awb") ~= 0 then
					local var_121_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011027", "story_v_out_117011.awb") / 1000

					if var_121_11 + var_121_5 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_11 + var_121_5
					end

					if var_121_7.prefab_name ~= "" and arg_118_1.actors_[var_121_7.prefab_name] ~= nil then
						local var_121_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_7.prefab_name].transform, "story_v_out_117011", "117011027", "story_v_out_117011.awb")

						arg_118_1:RecordAudio("117011027", var_121_12)
						arg_118_1:RecordAudio("117011027", var_121_12)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_117011", "117011027", "story_v_out_117011.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_117011", "117011027", "story_v_out_117011.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_13 = math.max(var_121_6, arg_118_1.talkMaxDuration)

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_13 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_5) / var_121_13

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_5 + var_121_13 and arg_118_1.time_ < var_121_5 + var_121_13 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play117011028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 117011028
		arg_122_1.duration_ = 6.57

		local var_122_0 = {
			zh = 6.566,
			ja = 5
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play117011029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1033"]) and arg_122_1.var_.actorSpriteComps1033 == nil then
				arg_122_1.var_.actorSpriteComps1033 = arg_122_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1033"]) then
				if arg_122_1.var_.actorSpriteComps1033 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								iter_125_1.color = Color.New(Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor2.r, (arg_122_1.time_ - 0) / var_125_0), Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor2.g, (arg_122_1.time_ - 0) / var_125_0), (Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor2.b, (arg_122_1.time_ - 0) / var_125_0)))
							else
								local var_125_1 = Mathf.Lerp(iter_125_1.color.r, 0.5, (arg_122_1.time_ - 0) / var_125_0)

								iter_125_1.color = Color.New(var_125_1, var_125_1, var_125_1)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1033"]) and arg_122_1.var_.actorSpriteComps1033 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_125_3 then
						iter_125_3.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_122_1.var_.actorSpriteComps1033 = nil
			end

			local var_125_2 = arg_122_1.actors_["1029"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.actorSpriteComps1029 == nil then
				arg_122_1.var_.actorSpriteComps1029 = var_125_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_3 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.actorSpriteComps1029 then
					for iter_125_4, iter_125_5 in pairs(arg_122_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_125_5 then
							if arg_122_1.isInRecall_ then
								iter_125_5.color = Color.New(Mathf.Lerp(iter_125_5.color.r, arg_122_1.hightColor1.r, (arg_122_1.time_ - 0) / var_125_3), Mathf.Lerp(iter_125_5.color.g, arg_122_1.hightColor1.g, (arg_122_1.time_ - 0) / var_125_3), (Mathf.Lerp(iter_125_5.color.b, arg_122_1.hightColor1.b, (arg_122_1.time_ - 0) / var_125_3)))
							else
								local var_125_4 = Mathf.Lerp(iter_125_5.color.r, 1, (arg_122_1.time_ - 0) / var_125_3)

								iter_125_5.color = Color.New(var_125_4, var_125_4, var_125_4)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.actorSpriteComps1029 then
				for iter_125_6, iter_125_7 in pairs(arg_122_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_125_7 then
						iter_125_7.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_122_1.var_.actorSpriteComps1029 = nil
			end

			local var_125_5 = 0
			local var_125_6 = 0.825

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_7 = arg_122_1:GetWordFromCfg(117011028)
				local var_125_8 = arg_122_1:FormatText(var_125_7.content)

				arg_122_1.text_.text = var_125_8

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_10 = 33 <= 0 and var_125_6 or var_125_6 * (utf8.len(var_125_8) / 33)

				if (33 <= 0 and var_125_6 or var_125_6 * (utf8.len(var_125_8) / 33)) > 0 and var_125_6 < var_125_10 then
					arg_122_1.talkMaxDuration = var_125_10

					if var_125_10 + var_125_5 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_5
					end
				end

				arg_122_1.text_.text = var_125_8
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011028", "story_v_out_117011.awb") ~= 0 then
					local var_125_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011028", "story_v_out_117011.awb") / 1000

					if var_125_11 + var_125_5 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_11 + var_125_5
					end

					if var_125_7.prefab_name ~= "" and arg_122_1.actors_[var_125_7.prefab_name] ~= nil then
						local var_125_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_7.prefab_name].transform, "story_v_out_117011", "117011028", "story_v_out_117011.awb")

						arg_122_1:RecordAudio("117011028", var_125_12)
						arg_122_1:RecordAudio("117011028", var_125_12)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_117011", "117011028", "story_v_out_117011.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_117011", "117011028", "story_v_out_117011.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_13 = math.max(var_125_6, arg_122_1.talkMaxDuration)

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_13 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_5) / var_125_13

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_5 + var_125_13 and arg_122_1.time_ < var_125_5 + var_125_13 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play117011029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 117011029
		arg_126_1.duration_ = 1.73

		local var_126_0 = {
			zh = 0.999999999999,
			ja = 1.733
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play117011030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1033 = arg_126_1.actors_["1033"].transform.localPosition
				arg_126_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("1033", 4)

				for iter_129_0 = 0, arg_126_1.actors_["1033"].transform.childCount - 1 do
					local var_129_0 = arg_126_1.actors_["1033"].transform:GetChild(iter_129_0)

					if var_129_0.name == "split_4" or not string.find(var_129_0.name, "split") then
						var_129_0.gameObject:SetActive(true)
					else
						var_129_0.gameObject:SetActive(false)
					end
				end
			end

			local var_129_1 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_1 then
				arg_126_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_126_1.time_ - 0) / var_129_1)
			end

			if arg_126_1.time_ >= 0 + var_129_1 and arg_126_1.time_ < 0 + var_129_1 + arg_129_0 then
				arg_126_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_129_2 = arg_126_1.actors_["1033"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps1033 == nil then
				arg_126_1.var_.actorSpriteComps1033 = var_129_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_3 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.actorSpriteComps1033 then
					for iter_129_1, iter_129_2 in pairs(arg_126_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_129_2 then
							if arg_126_1.isInRecall_ then
								iter_129_2.color = Color.New(Mathf.Lerp(iter_129_2.color.r, arg_126_1.hightColor1.r, (arg_126_1.time_ - 0) / var_129_3), Mathf.Lerp(iter_129_2.color.g, arg_126_1.hightColor1.g, (arg_126_1.time_ - 0) / var_129_3), (Mathf.Lerp(iter_129_2.color.b, arg_126_1.hightColor1.b, (arg_126_1.time_ - 0) / var_129_3)))
							else
								local var_129_4 = Mathf.Lerp(iter_129_2.color.r, 1, (arg_126_1.time_ - 0) / var_129_3)

								iter_129_2.color = Color.New(var_129_4, var_129_4, var_129_4)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps1033 then
				for iter_129_3, iter_129_4 in pairs(arg_126_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_129_4 then
						iter_129_4.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_126_1.var_.actorSpriteComps1033 = nil
			end

			local var_129_5 = arg_126_1.actors_["1029"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.actorSpriteComps1029 == nil then
				arg_126_1.var_.actorSpriteComps1029 = var_129_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_6 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 and not isNil(var_129_5) then
				if arg_126_1.var_.actorSpriteComps1029 then
					for iter_129_5, iter_129_6 in pairs(arg_126_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_129_6 then
							if arg_126_1.isInRecall_ then
								iter_129_6.color = Color.New(Mathf.Lerp(iter_129_6.color.r, arg_126_1.hightColor2.r, (arg_126_1.time_ - 0) / var_129_6), Mathf.Lerp(iter_129_6.color.g, arg_126_1.hightColor2.g, (arg_126_1.time_ - 0) / var_129_6), (Mathf.Lerp(iter_129_6.color.b, arg_126_1.hightColor2.b, (arg_126_1.time_ - 0) / var_129_6)))
							else
								local var_129_7 = Mathf.Lerp(iter_129_6.color.r, 0.5, (arg_126_1.time_ - 0) / var_129_6)

								iter_129_6.color = Color.New(var_129_7, var_129_7, var_129_7)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.actorSpriteComps1029 then
				for iter_129_7, iter_129_8 in pairs(arg_126_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_129_8 then
						iter_129_8.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_126_1.var_.actorSpriteComps1029 = nil
			end

			local var_129_8 = 0
			local var_129_9 = 0.05

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_10 = arg_126_1:GetWordFromCfg(117011029)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 2 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 2)

				if (2 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 2)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011029", "story_v_out_117011.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_117011", "117011029", "story_v_out_117011.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_117011", "117011029", "story_v_out_117011.awb")

						arg_126_1:RecordAudio("117011029", var_129_15)
						arg_126_1:RecordAudio("117011029", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_117011", "117011029", "story_v_out_117011.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_117011", "117011029", "story_v_out_117011.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play117011030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 117011030
		arg_130_1.duration_ = 8.03

		local var_130_0 = {
			zh = 5.7,
			ja = 8.033
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play117011031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1033"]) and arg_130_1.var_.actorSpriteComps1033 == nil then
				arg_130_1.var_.actorSpriteComps1033 = arg_130_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1033"]) then
				if arg_130_1.var_.actorSpriteComps1033 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								iter_133_1.color = Color.New(Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor2.r, (arg_130_1.time_ - 0) / var_133_0), Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor2.g, (arg_130_1.time_ - 0) / var_133_0), (Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor2.b, (arg_130_1.time_ - 0) / var_133_0)))
							else
								local var_133_1 = Mathf.Lerp(iter_133_1.color.r, 0.5, (arg_130_1.time_ - 0) / var_133_0)

								iter_133_1.color = Color.New(var_133_1, var_133_1, var_133_1)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1033"]) and arg_130_1.var_.actorSpriteComps1033 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_133_3 then
						iter_133_3.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_130_1.var_.actorSpriteComps1033 = nil
			end

			local var_133_2 = arg_130_1.actors_["1029"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.actorSpriteComps1029 == nil then
				arg_130_1.var_.actorSpriteComps1029 = var_133_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_3 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 and not isNil(var_133_2) then
				if arg_130_1.var_.actorSpriteComps1029 then
					for iter_133_4, iter_133_5 in pairs(arg_130_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_133_5 then
							if arg_130_1.isInRecall_ then
								iter_133_5.color = Color.New(Mathf.Lerp(iter_133_5.color.r, arg_130_1.hightColor1.r, (arg_130_1.time_ - 0) / var_133_3), Mathf.Lerp(iter_133_5.color.g, arg_130_1.hightColor1.g, (arg_130_1.time_ - 0) / var_133_3), (Mathf.Lerp(iter_133_5.color.b, arg_130_1.hightColor1.b, (arg_130_1.time_ - 0) / var_133_3)))
							else
								local var_133_4 = Mathf.Lerp(iter_133_5.color.r, 1, (arg_130_1.time_ - 0) / var_133_3)

								iter_133_5.color = Color.New(var_133_4, var_133_4, var_133_4)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.actorSpriteComps1029 then
				for iter_133_6, iter_133_7 in pairs(arg_130_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_133_7 then
						iter_133_7.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_130_1.var_.actorSpriteComps1029 = nil
			end

			local var_133_5 = 0
			local var_133_6 = 0.5

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:GetWordFromCfg(117011030)
				local var_133_8 = arg_130_1:FormatText(var_133_7.content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 20 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 20)

				if (20 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 20)) > 0 and var_133_6 < var_133_10 then
					arg_130_1.talkMaxDuration = var_133_10

					if var_133_10 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011030", "story_v_out_117011.awb") ~= 0 then
					local var_133_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011030", "story_v_out_117011.awb") / 1000

					if var_133_11 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_5
					end

					if var_133_7.prefab_name ~= "" and arg_130_1.actors_[var_133_7.prefab_name] ~= nil then
						local var_133_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_7.prefab_name].transform, "story_v_out_117011", "117011030", "story_v_out_117011.awb")

						arg_130_1:RecordAudio("117011030", var_133_12)
						arg_130_1:RecordAudio("117011030", var_133_12)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_117011", "117011030", "story_v_out_117011.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_117011", "117011030", "story_v_out_117011.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_13 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_13 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_13

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_13 and arg_130_1.time_ < var_133_5 + var_133_13 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play117011031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 117011031
		arg_134_1.duration_ = 7.47

		local var_134_0 = {
			zh = 7.466,
			ja = 6.266
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play117011032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1033 = arg_134_1.actors_["1033"].transform.localPosition
				arg_134_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("1033", 4)

				for iter_137_0 = 0, arg_134_1.actors_["1033"].transform.childCount - 1 do
					local var_137_0 = arg_134_1.actors_["1033"].transform:GetChild(iter_137_0)

					if var_137_0.name == "split_6" or not string.find(var_137_0.name, "split") then
						var_137_0.gameObject:SetActive(true)
					else
						var_137_0.gameObject:SetActive(false)
					end
				end
			end

			local var_137_1 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_1 then
				arg_134_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_134_1.time_ - 0) / var_137_1)
			end

			if arg_134_1.time_ >= 0 + var_137_1 and arg_134_1.time_ < 0 + var_137_1 + arg_137_0 then
				arg_134_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_137_2 = arg_134_1.actors_["1033"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.actorSpriteComps1033 == nil then
				arg_134_1.var_.actorSpriteComps1033 = var_137_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_3 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.actorSpriteComps1033 then
					for iter_137_1, iter_137_2 in pairs(arg_134_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_137_2 then
							if arg_134_1.isInRecall_ then
								iter_137_2.color = Color.New(Mathf.Lerp(iter_137_2.color.r, arg_134_1.hightColor1.r, (arg_134_1.time_ - 0) / var_137_3), Mathf.Lerp(iter_137_2.color.g, arg_134_1.hightColor1.g, (arg_134_1.time_ - 0) / var_137_3), (Mathf.Lerp(iter_137_2.color.b, arg_134_1.hightColor1.b, (arg_134_1.time_ - 0) / var_137_3)))
							else
								local var_137_4 = Mathf.Lerp(iter_137_2.color.r, 1, (arg_134_1.time_ - 0) / var_137_3)

								iter_137_2.color = Color.New(var_137_4, var_137_4, var_137_4)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.actorSpriteComps1033 then
				for iter_137_3, iter_137_4 in pairs(arg_134_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_137_4 then
						iter_137_4.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_134_1.var_.actorSpriteComps1033 = nil
			end

			local var_137_5 = arg_134_1.actors_["1029"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.actorSpriteComps1029 == nil then
				arg_134_1.var_.actorSpriteComps1029 = var_137_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_6 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_6 and not isNil(var_137_5) then
				if arg_134_1.var_.actorSpriteComps1029 then
					for iter_137_5, iter_137_6 in pairs(arg_134_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_137_6 then
							if arg_134_1.isInRecall_ then
								iter_137_6.color = Color.New(Mathf.Lerp(iter_137_6.color.r, arg_134_1.hightColor2.r, (arg_134_1.time_ - 0) / var_137_6), Mathf.Lerp(iter_137_6.color.g, arg_134_1.hightColor2.g, (arg_134_1.time_ - 0) / var_137_6), (Mathf.Lerp(iter_137_6.color.b, arg_134_1.hightColor2.b, (arg_134_1.time_ - 0) / var_137_6)))
							else
								local var_137_7 = Mathf.Lerp(iter_137_6.color.r, 0.5, (arg_134_1.time_ - 0) / var_137_6)

								iter_137_6.color = Color.New(var_137_7, var_137_7, var_137_7)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_6 and arg_134_1.time_ < 0 + var_137_6 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.actorSpriteComps1029 then
				for iter_137_7, iter_137_8 in pairs(arg_134_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_137_8 then
						iter_137_8.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_134_1.var_.actorSpriteComps1029 = nil
			end

			local var_137_8 = 0
			local var_137_9 = 0.925

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_10 = arg_134_1:GetWordFromCfg(117011031)
				local var_137_11 = arg_134_1:FormatText(var_137_10.content)

				arg_134_1.text_.text = var_137_11

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_13 = 37 <= 0 and var_137_9 or var_137_9 * (utf8.len(var_137_11) / 37)

				if (37 <= 0 and var_137_9 or var_137_9 * (utf8.len(var_137_11) / 37)) > 0 and var_137_9 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_8
					end
				end

				arg_134_1.text_.text = var_137_11
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011031", "story_v_out_117011.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_out_117011", "117011031", "story_v_out_117011.awb") / 1000

					if var_137_14 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_8
					end

					if var_137_10.prefab_name ~= "" and arg_134_1.actors_[var_137_10.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_10.prefab_name].transform, "story_v_out_117011", "117011031", "story_v_out_117011.awb")

						arg_134_1:RecordAudio("117011031", var_137_15)
						arg_134_1:RecordAudio("117011031", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_117011", "117011031", "story_v_out_117011.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_117011", "117011031", "story_v_out_117011.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_9, arg_134_1.talkMaxDuration)

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_8) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_8 + var_137_16 and arg_134_1.time_ < var_137_8 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play117011032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 117011032
		arg_138_1.duration_ = 9.9

		local var_138_0 = {
			zh = 9.9,
			ja = 7.766
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play117011033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1033"]) and arg_138_1.var_.actorSpriteComps1033 == nil then
				arg_138_1.var_.actorSpriteComps1033 = arg_138_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1033"]) then
				if arg_138_1.var_.actorSpriteComps1033 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								iter_141_1.color = Color.New(Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor2.r, (arg_138_1.time_ - 0) / var_141_0), Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor2.g, (arg_138_1.time_ - 0) / var_141_0), (Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor2.b, (arg_138_1.time_ - 0) / var_141_0)))
							else
								local var_141_1 = Mathf.Lerp(iter_141_1.color.r, 0.5, (arg_138_1.time_ - 0) / var_141_0)

								iter_141_1.color = Color.New(var_141_1, var_141_1, var_141_1)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1033"]) and arg_138_1.var_.actorSpriteComps1033 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_138_1.var_.actorSpriteComps1033 = nil
			end

			local var_141_2 = arg_138_1.actors_["1029"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1029 == nil then
				arg_138_1.var_.actorSpriteComps1029 = var_141_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_3 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.actorSpriteComps1029 then
					for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_141_5 then
							if arg_138_1.isInRecall_ then
								iter_141_5.color = Color.New(Mathf.Lerp(iter_141_5.color.r, arg_138_1.hightColor1.r, (arg_138_1.time_ - 0) / var_141_3), Mathf.Lerp(iter_141_5.color.g, arg_138_1.hightColor1.g, (arg_138_1.time_ - 0) / var_141_3), (Mathf.Lerp(iter_141_5.color.b, arg_138_1.hightColor1.b, (arg_138_1.time_ - 0) / var_141_3)))
							else
								local var_141_4 = Mathf.Lerp(iter_141_5.color.r, 1, (arg_138_1.time_ - 0) / var_141_3)

								iter_141_5.color = Color.New(var_141_4, var_141_4, var_141_4)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1029 then
				for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_141_7 then
						iter_141_7.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps1029 = nil
			end

			local var_141_5 = 0
			local var_141_6 = 1.325

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:GetWordFromCfg(117011032)
				local var_141_8 = arg_138_1:FormatText(var_141_7.content)

				arg_138_1.text_.text = var_141_8

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 53 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 53)

				if (53 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 53)) > 0 and var_141_6 < var_141_10 then
					arg_138_1.talkMaxDuration = var_141_10

					if var_141_10 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_8
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011032", "story_v_out_117011.awb") ~= 0 then
					local var_141_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011032", "story_v_out_117011.awb") / 1000

					if var_141_11 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_5
					end

					if var_141_7.prefab_name ~= "" and arg_138_1.actors_[var_141_7.prefab_name] ~= nil then
						local var_141_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_7.prefab_name].transform, "story_v_out_117011", "117011032", "story_v_out_117011.awb")

						arg_138_1:RecordAudio("117011032", var_141_12)
						arg_138_1:RecordAudio("117011032", var_141_12)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_117011", "117011032", "story_v_out_117011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_117011", "117011032", "story_v_out_117011.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_13 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_13 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_13

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_13 and arg_138_1.time_ < var_141_5 + var_141_13 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play117011033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 117011033
		arg_142_1.duration_ = 12.57

		local var_142_0 = {
			zh = 12.566,
			ja = 9.6
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play117011034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 1.45

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_1 = arg_142_1:GetWordFromCfg(117011033)
				local var_145_2 = arg_142_1:FormatText(var_145_1.content)

				arg_142_1.text_.text = var_145_2

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 58 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 58)

				if (58 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 58)) > 0 and var_145_0 < var_145_4 then
					arg_142_1.talkMaxDuration = var_145_4

					if var_145_4 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_4 + 0
					end
				end

				arg_142_1.text_.text = var_145_2
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011033", "story_v_out_117011.awb") ~= 0 then
					local var_145_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011033", "story_v_out_117011.awb") / 1000

					if var_145_5 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + 0
					end

					if var_145_1.prefab_name ~= "" and arg_142_1.actors_[var_145_1.prefab_name] ~= nil then
						local var_145_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_1.prefab_name].transform, "story_v_out_117011", "117011033", "story_v_out_117011.awb")

						arg_142_1:RecordAudio("117011033", var_145_6)
						arg_142_1:RecordAudio("117011033", var_145_6)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_117011", "117011033", "story_v_out_117011.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_117011", "117011033", "story_v_out_117011.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play117011034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 117011034
		arg_146_1.duration_ = 7.33

		local var_146_0 = {
			zh = 3.933,
			ja = 7.333
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play117011035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.425

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:GetWordFromCfg(117011034)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 17 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 17)

				if (17 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 17)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011034", "story_v_out_117011.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011034", "story_v_out_117011.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_117011", "117011034", "story_v_out_117011.awb")

						arg_146_1:RecordAudio("117011034", var_149_6)
						arg_146_1:RecordAudio("117011034", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_117011", "117011034", "story_v_out_117011.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_117011", "117011034", "story_v_out_117011.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play117011035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 117011035
		arg_150_1.duration_ = 5.13

		local var_150_0 = {
			zh = 2.366,
			ja = 5.133
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play117011036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1033"]) and arg_150_1.var_.actorSpriteComps1033 == nil then
				arg_150_1.var_.actorSpriteComps1033 = arg_150_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_0 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1033"]) then
				if arg_150_1.var_.actorSpriteComps1033 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								iter_153_1.color = Color.New(Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, (arg_150_1.time_ - 0) / var_153_0), Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, (arg_150_1.time_ - 0) / var_153_0), (Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, (arg_150_1.time_ - 0) / var_153_0)))
							else
								local var_153_1 = Mathf.Lerp(iter_153_1.color.r, 1, (arg_150_1.time_ - 0) / var_153_0)

								iter_153_1.color = Color.New(var_153_1, var_153_1, var_153_1)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1033"]) and arg_150_1.var_.actorSpriteComps1033 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_153_3 then
						iter_153_3.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_150_1.var_.actorSpriteComps1033 = nil
			end

			local var_153_2 = arg_150_1.actors_["1029"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps1029 == nil then
				arg_150_1.var_.actorSpriteComps1029 = var_153_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_3 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.actorSpriteComps1029 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								iter_153_5.color = Color.New(Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, (arg_150_1.time_ - 0) / var_153_3), Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, (arg_150_1.time_ - 0) / var_153_3), (Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, (arg_150_1.time_ - 0) / var_153_3)))
							else
								local var_153_4 = Mathf.Lerp(iter_153_5.color.r, 0.5, (arg_150_1.time_ - 0) / var_153_3)

								iter_153_5.color = Color.New(var_153_4, var_153_4, var_153_4)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps1029 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_153_7 then
						iter_153_7.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_150_1.var_.actorSpriteComps1029 = nil
			end

			local var_153_5 = 0
			local var_153_6 = 0.175

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_7 = arg_150_1:GetWordFromCfg(117011035)
				local var_153_8 = arg_150_1:FormatText(var_153_7.content)

				arg_150_1.text_.text = var_153_8

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_10 = 7 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_8) / 7)

				if (7 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_8) / 7)) > 0 and var_153_6 < var_153_10 then
					arg_150_1.talkMaxDuration = var_153_10

					if var_153_10 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_5
					end
				end

				arg_150_1.text_.text = var_153_8
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011035", "story_v_out_117011.awb") ~= 0 then
					local var_153_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011035", "story_v_out_117011.awb") / 1000

					if var_153_11 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_5
					end

					if var_153_7.prefab_name ~= "" and arg_150_1.actors_[var_153_7.prefab_name] ~= nil then
						local var_153_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_7.prefab_name].transform, "story_v_out_117011", "117011035", "story_v_out_117011.awb")

						arg_150_1:RecordAudio("117011035", var_153_12)
						arg_150_1:RecordAudio("117011035", var_153_12)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_117011", "117011035", "story_v_out_117011.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_117011", "117011035", "story_v_out_117011.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_13 = math.max(var_153_6, arg_150_1.talkMaxDuration)

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_13 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_5) / var_153_13

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_5 + var_153_13 and arg_150_1.time_ < var_153_5 + var_153_13 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play117011036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 117011036
		arg_154_1.duration_ = 3.97

		local var_154_0 = {
			zh = 2.233,
			ja = 3.966
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play117011037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1033"]) and arg_154_1.var_.actorSpriteComps1033 == nil then
				arg_154_1.var_.actorSpriteComps1033 = arg_154_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_0 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1033"]) then
				if arg_154_1.var_.actorSpriteComps1033 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								iter_157_1.color = Color.New(Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, (arg_154_1.time_ - 0) / var_157_0), Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, (arg_154_1.time_ - 0) / var_157_0), (Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, (arg_154_1.time_ - 0) / var_157_0)))
							else
								local var_157_1 = Mathf.Lerp(iter_157_1.color.r, 0.5, (arg_154_1.time_ - 0) / var_157_0)

								iter_157_1.color = Color.New(var_157_1, var_157_1, var_157_1)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1033"]) and arg_154_1.var_.actorSpriteComps1033 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_157_3 then
						iter_157_3.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_154_1.var_.actorSpriteComps1033 = nil
			end

			local var_157_2 = arg_154_1.actors_["1029"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps1029 == nil then
				arg_154_1.var_.actorSpriteComps1029 = var_157_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_3 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.actorSpriteComps1029 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								iter_157_5.color = Color.New(Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor1.r, (arg_154_1.time_ - 0) / var_157_3), Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor1.g, (arg_154_1.time_ - 0) / var_157_3), (Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor1.b, (arg_154_1.time_ - 0) / var_157_3)))
							else
								local var_157_4 = Mathf.Lerp(iter_157_5.color.r, 1, (arg_154_1.time_ - 0) / var_157_3)

								iter_157_5.color = Color.New(var_157_4, var_157_4, var_157_4)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps1029 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_157_7 then
						iter_157_7.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_154_1.var_.actorSpriteComps1029 = nil
			end

			local var_157_5 = 0
			local var_157_6 = 0.225

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_7 = arg_154_1:GetWordFromCfg(117011036)
				local var_157_8 = arg_154_1:FormatText(var_157_7.content)

				arg_154_1.text_.text = var_157_8

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_10 = 9 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_8) / 9)

				if (9 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_8) / 9)) > 0 and var_157_6 < var_157_10 then
					arg_154_1.talkMaxDuration = var_157_10

					if var_157_10 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_5
					end
				end

				arg_154_1.text_.text = var_157_8
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011036", "story_v_out_117011.awb") ~= 0 then
					local var_157_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011036", "story_v_out_117011.awb") / 1000

					if var_157_11 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_11 + var_157_5
					end

					if var_157_7.prefab_name ~= "" and arg_154_1.actors_[var_157_7.prefab_name] ~= nil then
						local var_157_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_7.prefab_name].transform, "story_v_out_117011", "117011036", "story_v_out_117011.awb")

						arg_154_1:RecordAudio("117011036", var_157_12)
						arg_154_1:RecordAudio("117011036", var_157_12)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_117011", "117011036", "story_v_out_117011.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_117011", "117011036", "story_v_out_117011.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_13 = math.max(var_157_6, arg_154_1.talkMaxDuration)

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_13 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_5) / var_157_13

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_5 + var_157_13 and arg_154_1.time_ < var_157_5 + var_157_13 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play117011037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 117011037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play117011038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1029"]) and arg_158_1.var_.actorSpriteComps1029 == nil then
				arg_158_1.var_.actorSpriteComps1029 = arg_158_1.actors_["1029"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1029"]) then
				if arg_158_1.var_.actorSpriteComps1029 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								iter_161_1.color = Color.New(Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor2.r, (arg_158_1.time_ - 0) / var_161_0), Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor2.g, (arg_158_1.time_ - 0) / var_161_0), (Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor2.b, (arg_158_1.time_ - 0) / var_161_0)))
							else
								local var_161_1 = Mathf.Lerp(iter_161_1.color.r, 0.5, (arg_158_1.time_ - 0) / var_161_0)

								iter_161_1.color = Color.New(var_161_1, var_161_1, var_161_1)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1029"]) and arg_158_1.var_.actorSpriteComps1029 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_161_3 then
						iter_161_3.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_158_1.var_.actorSpriteComps1029 = nil
			end

			local var_161_2 = 0
			local var_161_3 = 0.425

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(117011037).content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 17 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 17)

				if (17 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 17)) > 0 and var_161_3 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_7 and arg_158_1.time_ < var_161_2 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play117011038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 117011038
		arg_162_1.duration_ = 2.97

		local var_162_0 = {
			zh = 2.966,
			ja = 2.7
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play117011039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1029"]) and arg_162_1.var_.actorSpriteComps1029 == nil then
				arg_162_1.var_.actorSpriteComps1029 = arg_162_1.actors_["1029"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_0 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1029"]) then
				if arg_162_1.var_.actorSpriteComps1029 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								iter_165_1.color = Color.New(Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, (arg_162_1.time_ - 0) / var_165_0), Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, (arg_162_1.time_ - 0) / var_165_0), (Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, (arg_162_1.time_ - 0) / var_165_0)))
							else
								local var_165_1 = Mathf.Lerp(iter_165_1.color.r, 1, (arg_162_1.time_ - 0) / var_165_0)

								iter_165_1.color = Color.New(var_165_1, var_165_1, var_165_1)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1029"]) and arg_162_1.var_.actorSpriteComps1029 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_165_3 then
						iter_165_3.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_162_1.var_.actorSpriteComps1029 = nil
			end

			local var_165_2 = 0
			local var_165_3 = 0.4

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:GetWordFromCfg(117011038)
				local var_165_5 = arg_162_1:FormatText(var_165_4.content)

				arg_162_1.text_.text = var_165_5

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_7 = 16 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 16)

				if (16 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 16)) > 0 and var_165_3 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_2
					end
				end

				arg_162_1.text_.text = var_165_5
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011038", "story_v_out_117011.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_117011", "117011038", "story_v_out_117011.awb") / 1000

					if var_165_8 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_2
					end

					if var_165_4.prefab_name ~= "" and arg_162_1.actors_[var_165_4.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_4.prefab_name].transform, "story_v_out_117011", "117011038", "story_v_out_117011.awb")

						arg_162_1:RecordAudio("117011038", var_165_9)
						arg_162_1:RecordAudio("117011038", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_117011", "117011038", "story_v_out_117011.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_117011", "117011038", "story_v_out_117011.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_3, arg_162_1.talkMaxDuration)

			if var_165_2 <= arg_162_1.time_ and arg_162_1.time_ < var_165_2 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_2) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_2 + var_165_10 and arg_162_1.time_ < var_165_2 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play117011039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 117011039
		arg_166_1.duration_ = 3.47

		local var_166_0 = {
			zh = 2.4,
			ja = 3.466
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play117011040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1029"]) and arg_166_1.var_.actorSpriteComps1029 == nil then
				arg_166_1.var_.actorSpriteComps1029 = arg_166_1.actors_["1029"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1029"]) then
				if arg_166_1.var_.actorSpriteComps1029 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 0.5, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1029"]) and arg_166_1.var_.actorSpriteComps1029 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_166_1.var_.actorSpriteComps1029 = nil
			end

			local var_169_2 = arg_166_1.actors_["1033"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps1033 == nil then
				arg_166_1.var_.actorSpriteComps1033 = var_169_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_3 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 and not isNil(var_169_2) then
				if arg_166_1.var_.actorSpriteComps1033 then
					for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_169_5 then
							if arg_166_1.isInRecall_ then
								iter_169_5.color = Color.New(Mathf.Lerp(iter_169_5.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 0) / var_169_3), Mathf.Lerp(iter_169_5.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 0) / var_169_3), (Mathf.Lerp(iter_169_5.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 0) / var_169_3)))
							else
								local var_169_4 = Mathf.Lerp(iter_169_5.color.r, 1, (arg_166_1.time_ - 0) / var_169_3)

								iter_169_5.color = Color.New(var_169_4, var_169_4, var_169_4)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps1033 then
				for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_169_7 then
						iter_169_7.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps1033 = nil
			end

			local var_169_5 = 0
			local var_169_6 = 0.3

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_7 = arg_166_1:GetWordFromCfg(117011039)
				local var_169_8 = arg_166_1:FormatText(var_169_7.content)

				arg_166_1.text_.text = var_169_8

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_10 = 10 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_8) / 10)

				if (10 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_8) / 10)) > 0 and var_169_6 < var_169_10 then
					arg_166_1.talkMaxDuration = var_169_10

					if var_169_10 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_5
					end
				end

				arg_166_1.text_.text = var_169_8
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011039", "story_v_out_117011.awb") ~= 0 then
					local var_169_11 = manager.audio:GetVoiceLength("story_v_out_117011", "117011039", "story_v_out_117011.awb") / 1000

					if var_169_11 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_11 + var_169_5
					end

					if var_169_7.prefab_name ~= "" and arg_166_1.actors_[var_169_7.prefab_name] ~= nil then
						local var_169_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_7.prefab_name].transform, "story_v_out_117011", "117011039", "story_v_out_117011.awb")

						arg_166_1:RecordAudio("117011039", var_169_12)
						arg_166_1:RecordAudio("117011039", var_169_12)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_117011", "117011039", "story_v_out_117011.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_117011", "117011039", "story_v_out_117011.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_13 = math.max(var_169_6, arg_166_1.talkMaxDuration)

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_13 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_5) / var_169_13

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_5 + var_169_13 and arg_166_1.time_ < var_169_5 + var_169_13 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play117011040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 117011040
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play117011041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				local var_173_0 = arg_170_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_173_0 then
					arg_170_1.var_.alphaOldValue1033 = var_173_0.alpha
					arg_170_1.var_.characterEffect1033 = var_173_0
				end

				arg_170_1.var_.alphaOldValue1033 = 1
			end

			local var_173_1 = 0.333333333333333

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_1 then
				if arg_170_1.var_.characterEffect1033 then
					arg_170_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_170_1.var_.alphaOldValue1033, 0, (arg_170_1.time_ - 0) / var_173_1)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_1 and arg_170_1.time_ < 0 + var_173_1 + arg_173_0 and arg_170_1.var_.characterEffect1033 then
				arg_170_1.var_.characterEffect1033.alpha = 0
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				local var_173_2 = arg_170_1.actors_["1029"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_173_2 then
					arg_170_1.var_.alphaOldValue1029 = var_173_2.alpha
					arg_170_1.var_.characterEffect1029 = var_173_2
				end

				arg_170_1.var_.alphaOldValue1029 = 1
			end

			local var_173_3 = 0.333333333333333

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 then
				if arg_170_1.var_.characterEffect1029 then
					arg_170_1.var_.characterEffect1029.alpha = Mathf.Lerp(arg_170_1.var_.alphaOldValue1029, 0, (arg_170_1.time_ - 0) / var_173_3)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and arg_170_1.var_.characterEffect1029 then
				arg_170_1.var_.characterEffect1029.alpha = 0
			end

			local var_173_4 = 0
			local var_173_5 = 0.975

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(117011040).content)

				arg_170_1.text_.text = var_173_6

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_8 = 39 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_6) / 39)

				if (39 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_6) / 39)) > 0 and var_173_5 < var_173_8 then
					arg_170_1.talkMaxDuration = var_173_8

					if var_173_8 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_6
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_9 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_9 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_9

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_9 and arg_170_1.time_ < var_173_4 + var_173_9 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play117011041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 117011041
		arg_174_1.duration_ = 4.8

		local var_174_0 = {
			zh = 3.333,
			ja = 4.8
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play117011042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				local var_177_0 = arg_174_1.actors_["1029"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_177_0 then
					arg_174_1.var_.alphaOldValue1029 = var_177_0.alpha
					arg_174_1.var_.characterEffect1029 = var_177_0
				end

				arg_174_1.var_.alphaOldValue1029 = 0
			end

			local var_177_1 = 0.333333333333333

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				if arg_174_1.var_.characterEffect1029 then
					arg_174_1.var_.characterEffect1029.alpha = Mathf.Lerp(arg_174_1.var_.alphaOldValue1029, 1, (arg_174_1.time_ - 0) / var_177_1)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 and arg_174_1.var_.characterEffect1029 then
				arg_174_1.var_.characterEffect1029.alpha = 1
			end

			local var_177_2 = arg_174_1.actors_["1029"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1029 = var_177_2.localPosition
				var_177_2.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1029", 3)

				for iter_177_0 = 0, var_177_2.childCount - 1 do
					local var_177_3 = var_177_2:GetChild(iter_177_0)

					if var_177_3.name == "split_1" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				var_177_2.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1029, Vector3.New(0, -355, -140), (arg_174_1.time_ - 0) / var_177_4)
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				var_177_2.localPosition = Vector3.New(0, -355, -140)
			end

			local var_177_5 = arg_174_1.actors_["1029"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_5) and arg_174_1.var_.actorSpriteComps1029 == nil then
				arg_174_1.var_.actorSpriteComps1029 = var_177_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_6 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_6 and not isNil(var_177_5) then
				if arg_174_1.var_.actorSpriteComps1029 then
					for iter_177_1, iter_177_2 in pairs(arg_174_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_177_2 then
							if arg_174_1.isInRecall_ then
								iter_177_2.color = Color.New(Mathf.Lerp(iter_177_2.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_6), Mathf.Lerp(iter_177_2.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_6), (Mathf.Lerp(iter_177_2.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_6)))
							else
								local var_177_7 = Mathf.Lerp(iter_177_2.color.r, 1, (arg_174_1.time_ - 0) / var_177_6)

								iter_177_2.color = Color.New(var_177_7, var_177_7, var_177_7)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_6 and arg_174_1.time_ < 0 + var_177_6 + arg_177_0 and not isNil(var_177_5) and arg_174_1.var_.actorSpriteComps1029 then
				for iter_177_3, iter_177_4 in pairs(arg_174_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_177_4 then
						iter_177_4.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps1029 = nil
			end

			local var_177_8 = 0
			local var_177_9 = 0.375

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(117011041)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 15 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 15)

				if (15 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 15)) > 0 and var_177_9 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011041", "story_v_out_117011.awb") ~= 0 then
					local var_177_14 = manager.audio:GetVoiceLength("story_v_out_117011", "117011041", "story_v_out_117011.awb") / 1000

					if var_177_14 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_8
					end

					if var_177_10.prefab_name ~= "" and arg_174_1.actors_[var_177_10.prefab_name] ~= nil then
						local var_177_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_10.prefab_name].transform, "story_v_out_117011", "117011041", "story_v_out_117011.awb")

						arg_174_1:RecordAudio("117011041", var_177_15)
						arg_174_1:RecordAudio("117011041", var_177_15)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_117011", "117011041", "story_v_out_117011.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_117011", "117011041", "story_v_out_117011.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_16 and arg_174_1.time_ < var_177_8 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play117011042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 117011042
		arg_178_1.duration_ = 11.37

		local var_178_0 = {
			zh = 9.633,
			ja = 11.366
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play117011043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if arg_178_1.bgs_.ST03 == nil then
				local var_181_0 = Object.Instantiate(arg_178_1.paintGo_)

				var_181_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_181_0.name = "ST03"
				var_181_0.transform.parent = arg_178_1.stage_.transform
				var_181_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.bgs_.ST03 = var_181_0
			end

			if 2 < arg_178_1.time_ and arg_178_1.time_ <= 2 + arg_181_0 then
				local var_181_1 = arg_178_1.bgs_.ST03

				arg_178_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_181_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_2 = var_181_1:GetComponent("SpriteRenderer")

				if var_181_2 and var_181_2.sprite then
					local var_181_3 = 2 * (var_181_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_181_1.transform.localScale = Vector3.New(var_181_3 / var_181_2.sprite.bounds.size.y < var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x and var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x or var_181_3 / var_181_2.sprite.bounds.size.y, var_181_3 / var_181_2.sprite.bounds.size.y < var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x and var_181_3 * manager.ui.mainCameraCom_.aspect / var_181_2.sprite.bounds.size.x or var_181_3 / var_181_2.sprite.bounds.size.y, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "ST03" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_4 = 0

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_5 = 2

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_5 then
				local var_181_6 = Color.New(0, 0, 0)

				var_181_6.a = Mathf.Lerp(0, 1, (arg_178_1.time_ - var_181_4) / var_181_5)
				arg_178_1.mask_.color = var_181_6
			end

			if arg_178_1.time_ >= var_181_4 + var_181_5 and arg_178_1.time_ < var_181_4 + var_181_5 + arg_181_0 then
				local var_181_7 = Color.New(0, 0, 0)

				var_181_7.a = 1
				arg_178_1.mask_.color = var_181_7
			end

			local var_181_8 = 2

			if 2 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_9 = 2

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_9 then
				local var_181_10 = Color.New(0, 0, 0)

				var_181_10.a = Mathf.Lerp(1, 0, (arg_178_1.time_ - var_181_8) / var_181_9)
				arg_178_1.mask_.color = var_181_10
			end

			if arg_178_1.time_ >= var_181_8 + var_181_9 and arg_178_1.time_ < var_181_8 + var_181_9 + arg_181_0 then
				local var_181_11 = Color.New(0, 0, 0)

				arg_178_1.mask_.enabled = false
				var_181_11.a = 0
				arg_178_1.mask_.color = var_181_11
			end

			local var_181_12 = arg_178_1.actors_["1029"].transform

			if 1.966 < arg_178_1.time_ and arg_178_1.time_ <= 1.966 + arg_181_0 then
				arg_178_1.var_.moveOldPos1029 = var_181_12.localPosition
				var_181_12.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1029", 7)

				for iter_181_2 = 0, var_181_12.childCount - 1 do
					local var_181_13 = var_181_12:GetChild(iter_181_2)

					if var_181_13.name == "split_1" or not string.find(var_181_13.name, "split") then
						var_181_13.gameObject:SetActive(true)
					else
						var_181_13.gameObject:SetActive(false)
					end
				end
			end

			local var_181_14 = 0.001

			if 1.966 <= arg_178_1.time_ and arg_178_1.time_ < 1.966 + var_181_14 then
				var_181_12.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1029, Vector3.New(0, -2000, -140), (arg_178_1.time_ - 1.966) / var_181_14)
			end

			if arg_178_1.time_ >= 1.966 + var_181_14 and arg_178_1.time_ < 1.966 + var_181_14 + arg_181_0 then
				var_181_12.localPosition = Vector3.New(0, -2000, -140)
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_15 = 4
			local var_181_16 = 0.825

			if 4 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_17 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_17:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_18 = arg_178_1:GetWordFromCfg(117011042)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_21 = 33 <= 0 and var_181_16 or var_181_16 * (utf8.len(var_181_19) / 33)

				if (33 <= 0 and var_181_16 or var_181_16 * (utf8.len(var_181_19) / 33)) > 0 and var_181_16 < var_181_21 then
					arg_178_1.talkMaxDuration = var_181_21
					var_181_15 = var_181_15 + 0.3

					if var_181_21 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_21 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011042", "story_v_out_117011.awb") ~= 0 then
					local var_181_22 = manager.audio:GetVoiceLength("story_v_out_117011", "117011042", "story_v_out_117011.awb") / 1000

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end

					if var_181_18.prefab_name ~= "" and arg_178_1.actors_[var_181_18.prefab_name] ~= nil then
						local var_181_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_18.prefab_name].transform, "story_v_out_117011", "117011042", "story_v_out_117011.awb")

						arg_178_1:RecordAudio("117011042", var_181_23)
						arg_178_1:RecordAudio("117011042", var_181_23)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_117011", "117011042", "story_v_out_117011.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_117011", "117011042", "story_v_out_117011.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_24 = var_181_15 + 0.3
			local var_181_25 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 + 0.3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_24 + var_181_25 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_24) / var_181_25

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_24 + var_181_25 and arg_178_1.time_ < var_181_24 + var_181_25 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play117011043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 117011043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play117011044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:AudioAction("play", "effect", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd.awb")
			end

			local var_187_1 = 0
			local var_187_2 = 1.225

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_3 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(117011043).content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 49 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 49)

				if (49 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 49)) > 0 and var_187_2 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_6 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_6 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_6

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_6 and arg_184_1.time_ < var_187_1 + var_187_6 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play117011044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 117011044
		arg_188_1.duration_ = 1.9

		local var_188_0 = {
			zh = 1.9,
			ja = 1.333
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play117011045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.25

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_1 = arg_188_1:GetWordFromCfg(117011044)
				local var_191_2 = arg_188_1:FormatText(var_191_1.content)

				arg_188_1.text_.text = var_191_2

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 10 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 10)

				if (10 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 10)) > 0 and var_191_0 < var_191_4 then
					arg_188_1.talkMaxDuration = var_191_4

					if var_191_4 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_4 + 0
					end
				end

				arg_188_1.text_.text = var_191_2
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011044", "story_v_out_117011.awb") ~= 0 then
					local var_191_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011044", "story_v_out_117011.awb") / 1000

					if var_191_5 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + 0
					end

					if var_191_1.prefab_name ~= "" and arg_188_1.actors_[var_191_1.prefab_name] ~= nil then
						local var_191_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_1.prefab_name].transform, "story_v_out_117011", "117011044", "story_v_out_117011.awb")

						arg_188_1:RecordAudio("117011044", var_191_6)
						arg_188_1:RecordAudio("117011044", var_191_6)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_117011", "117011044", "story_v_out_117011.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_117011", "117011044", "story_v_out_117011.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play117011045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 117011045
		arg_192_1.duration_ = 10.77

		local var_192_0 = {
			zh = 5.9,
			ja = 10.766
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play117011046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if arg_192_1.actors_["1132"] == nil then
				local var_195_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1132")

				if not isNil(var_195_0) then
					local var_195_1 = Object.Instantiate(var_195_0, arg_192_1.canvasGo_.transform)

					var_195_1.transform:SetSiblingIndex(1)

					var_195_1.name = "1132"
					var_195_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_192_1.actors_["1132"] = var_195_1

					if arg_192_1.isInRecall_ then
						for iter_195_0, iter_195_1 in ipairs((var_195_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_195_1.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_195_2 = arg_192_1.actors_["1132"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1132 = var_195_2.localPosition
				var_195_2.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1132", 3)

				for iter_195_2 = 0, var_195_2.childCount - 1 do
					local var_195_3 = var_195_2:GetChild(iter_195_2)

					if var_195_3.name == "split_6" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_2.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1132, Vector3.New(0, -413, -185), (arg_192_1.time_ - 0) / var_195_4)
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_2.localPosition = Vector3.New(0, -413, -185)
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				local var_195_5 = arg_192_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_195_5 then
					arg_192_1.var_.alphaOldValue1132 = var_195_5.alpha
					arg_192_1.var_.characterEffect1132 = var_195_5
				end

				arg_192_1.var_.alphaOldValue1132 = 0
			end

			local var_195_6 = 0.333333333333333

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_6 then
				if arg_192_1.var_.characterEffect1132 then
					arg_192_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_192_1.var_.alphaOldValue1132, 1, (arg_192_1.time_ - 0) / var_195_6)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_6 and arg_192_1.time_ < 0 + var_195_6 + arg_195_0 and arg_192_1.var_.characterEffect1132 then
				arg_192_1.var_.characterEffect1132.alpha = 1
			end

			local var_195_7 = 0
			local var_195_8 = 0.875

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_9 = arg_192_1:GetWordFromCfg(117011045)
				local var_195_10 = arg_192_1:FormatText(var_195_9.content)

				arg_192_1.text_.text = var_195_10

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_12 = 35 <= 0 and var_195_8 or var_195_8 * (utf8.len(var_195_10) / 35)

				if (35 <= 0 and var_195_8 or var_195_8 * (utf8.len(var_195_10) / 35)) > 0 and var_195_8 < var_195_12 then
					arg_192_1.talkMaxDuration = var_195_12

					if var_195_12 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_12 + var_195_7
					end
				end

				arg_192_1.text_.text = var_195_10
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011045", "story_v_out_117011.awb") ~= 0 then
					local var_195_13 = manager.audio:GetVoiceLength("story_v_out_117011", "117011045", "story_v_out_117011.awb") / 1000

					if var_195_13 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_7
					end

					if var_195_9.prefab_name ~= "" and arg_192_1.actors_[var_195_9.prefab_name] ~= nil then
						local var_195_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_9.prefab_name].transform, "story_v_out_117011", "117011045", "story_v_out_117011.awb")

						arg_192_1:RecordAudio("117011045", var_195_14)
						arg_192_1:RecordAudio("117011045", var_195_14)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_117011", "117011045", "story_v_out_117011.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_117011", "117011045", "story_v_out_117011.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_15 = math.max(var_195_8, arg_192_1.talkMaxDuration)

			if var_195_7 <= arg_192_1.time_ and arg_192_1.time_ < var_195_7 + var_195_15 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_7) / var_195_15

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_7 + var_195_15 and arg_192_1.time_ < var_195_7 + var_195_15 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play117011046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 117011046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play117011047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				local var_199_0 = arg_196_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_199_0 then
					arg_196_1.var_.alphaOldValue1132 = var_199_0.alpha
					arg_196_1.var_.characterEffect1132 = var_199_0
				end

				arg_196_1.var_.alphaOldValue1132 = 1
			end

			local var_199_1 = 0.333333333333333

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				if arg_196_1.var_.characterEffect1132 then
					arg_196_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_196_1.var_.alphaOldValue1132, 0, (arg_196_1.time_ - 0) / var_199_1)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 and arg_196_1.var_.characterEffect1132 then
				arg_196_1.var_.characterEffect1132.alpha = 0
			end

			local var_199_2 = 0
			local var_199_3 = 0.525

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_4 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(117011046).content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_6 = 21 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_4) / 21)

				if (21 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_4) / 21)) > 0 and var_199_3 < var_199_6 then
					arg_196_1.talkMaxDuration = var_199_6

					if var_199_6 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_7 and arg_196_1.time_ < var_199_2 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play117011047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 117011047
		arg_200_1.duration_ = 7.8

		local var_200_0 = {
			zh = 6.9,
			ja = 7.8
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play117011048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.925

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_1 = arg_200_1:GetWordFromCfg(117011047)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 37 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 37)

				if (37 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 37)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117011", "117011047", "story_v_out_117011.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_117011", "117011047", "story_v_out_117011.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_117011", "117011047", "story_v_out_117011.awb")

						arg_200_1:RecordAudio("117011047", var_203_6)
						arg_200_1:RecordAudio("117011047", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_117011", "117011047", "story_v_out_117011.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_117011", "117011047", "story_v_out_117011.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play117011048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 117011048
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
			arg_204_1.auto_ = false
		end

		function arg_204_1.playNext_(arg_206_0)
			arg_204_1.onStoryFinished_()
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.925

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(117011048).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 37 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 37)

				if (37 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 37)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I08b",
		"TextureConfig/Background/TI0101",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST03"
	},
	voices = {
		"story_v_out_117011.awb"
	}
}
