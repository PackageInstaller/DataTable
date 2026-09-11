return {
	Play104011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104011002(arg_1_1)
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

			local var_4_4 = "S0103"

			if arg_1_1.bgs_.S0103 == nil then
				local var_4_5 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_4)
				var_4_5.name = var_4_4
				var_4_5.transform.parent = arg_1_1.stage_.transform
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_4] = var_4_5
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.bgs_.S0103:GetComponent("SpriteRenderer")

				if var_4_6 then
					arg_1_1.var_.alphaOldValueS0103 = var_4_6.color.a
					arg_1_1.var_.alphaMatValueS0103 = var_4_6
				end

				arg_1_1.var_.alphaOldValueS0103 = 0
			end

			local var_4_7 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				if arg_1_1.var_.alphaMatValueS0103 then
					arg_1_1.var_.alphaMatValueS0103.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0103, 1, (arg_1_1.time_ - 0) / var_4_7)
					arg_1_1.var_.alphaMatValueS0103.color = arg_1_1.var_.alphaMatValueS0103.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 and arg_1_1.var_.alphaMatValueS0103 then
				arg_1_1.var_.alphaMatValueS0103.color.a = 1
				arg_1_1.var_.alphaMatValueS0103.color = arg_1_1.var_.alphaMatValueS0103.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_8 = arg_1_1.bgs_.S0103

				arg_1_1.bgs_.S0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_9 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_9 and var_4_9.sprite then
					local var_4_10 = 2 * (var_4_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_8.transform.localScale = Vector3.New(var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0103" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_11 + 2 and arg_1_1.time_ < var_4_11 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 2
			local var_4_13 = 0.8

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

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(104011001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 32 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 32)

				if (32 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 32)) > 0 and var_4_13 < var_4_17 then
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
	Play104011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.4

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

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(104011002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 16 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 16)

				if (16 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 16)) > 0 and var_11_0 < var_11_3 then
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
	Play104011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104011003
		arg_12_1.duration_ = 5.67

		local var_12_0 = {
			ja = 3.9,
			ko = 5.566,
			zh = 5.666,
			en = 5.6
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.675

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(104011003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 26 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 26)

				if (26 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 26)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011003", "story_v_out_104011.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011003", "story_v_out_104011.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_104011", "104011003", "story_v_out_104011.awb")

						arg_12_1:RecordAudio("104011003", var_15_6)
						arg_12_1:RecordAudio("104011003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104011", "104011003", "story_v_out_104011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104011", "104011003", "story_v_out_104011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play104011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104011004
		arg_16_1.duration_ = 13.47

		local var_16_0 = {
			ja = 11.066,
			ko = 11.6,
			zh = 10.9,
			en = 13.466
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
				arg_16_0:Play104011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.425

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(104011004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 57 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 57)

				if (57 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 57)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011004", "story_v_out_104011.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011004", "story_v_out_104011.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_104011", "104011004", "story_v_out_104011.awb")

						arg_16_1:RecordAudio("104011004", var_19_6)
						arg_16_1:RecordAudio("104011004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104011", "104011004", "story_v_out_104011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104011", "104011004", "story_v_out_104011.awb")
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
	Play104011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104011005
		arg_20_1.duration_ = 1.43

		local var_20_0 = {
			ja = 1.366,
			ko = 1.033,
			zh = 1.433,
			en = 0.966
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
				arg_20_0:Play104011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.1

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(104011005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 4 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 4)

				if (4 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 4)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011005", "story_v_out_104011.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011005", "story_v_out_104011.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_104011", "104011005", "story_v_out_104011.awb")

						arg_20_1:RecordAudio("104011005", var_23_6)
						arg_20_1:RecordAudio("104011005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104011", "104011005", "story_v_out_104011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104011", "104011005", "story_v_out_104011.awb")
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
	Play104011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104011006
		arg_24_1.duration_ = 11.17

		local var_24_0 = {
			ja = 11.166,
			ko = 8.766,
			zh = 8.7,
			en = 10.566
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
				arg_24_0:Play104011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.2

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(104011006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 48 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 48)

				if (48 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 48)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011006", "story_v_out_104011.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011006", "story_v_out_104011.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_104011", "104011006", "story_v_out_104011.awb")

						arg_24_1:RecordAudio("104011006", var_27_6)
						arg_24_1:RecordAudio("104011006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104011", "104011006", "story_v_out_104011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104011", "104011006", "story_v_out_104011.awb")
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
	Play104011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104011007
		arg_28_1.duration_ = 6.97

		local var_28_0 = {
			ja = 6.8,
			ko = 3.9,
			zh = 4.3,
			en = 6.966
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
				arg_28_0:Play104011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.525

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(104011007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 21 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 21)

				if (21 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 21)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011007", "story_v_out_104011.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011007", "story_v_out_104011.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_104011", "104011007", "story_v_out_104011.awb")

						arg_28_1:RecordAudio("104011007", var_31_6)
						arg_28_1:RecordAudio("104011007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104011", "104011007", "story_v_out_104011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104011", "104011007", "story_v_out_104011.awb")
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
	Play104011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104011008
		arg_32_1.duration_ = 5.6

		local var_32_0 = {
			ja = 5,
			ko = 4,
			zh = 5.6,
			en = 4
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
				arg_32_0:Play104011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.4

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
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

				local var_35_1 = arg_32_1:GetWordFromCfg(104011008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 19 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 19)

				if (19 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 19)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011008", "story_v_out_104011.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011008", "story_v_out_104011.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_104011", "104011008", "story_v_out_104011.awb")

						arg_32_1:RecordAudio("104011008", var_35_6)
						arg_32_1:RecordAudio("104011008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104011", "104011008", "story_v_out_104011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104011", "104011008", "story_v_out_104011.awb")
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
	Play104011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104011009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play104011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.475

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(104011009).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 19 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 19)

				if (19 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 19)) > 0 and var_39_0 < var_39_3 then
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
	Play104011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104011010
		arg_40_1.duration_ = 9.6

		local var_40_0 = {
			ja = 9.6,
			ko = 6.833,
			zh = 9.4,
			en = 6.466
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
				arg_40_0:Play104011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.875

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(104011010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 33 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 33)

				if (33 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 33)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011010", "story_v_out_104011.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011010", "story_v_out_104011.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_104011", "104011010", "story_v_out_104011.awb")

						arg_40_1:RecordAudio("104011010", var_43_6)
						arg_40_1:RecordAudio("104011010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104011", "104011010", "story_v_out_104011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104011", "104011010", "story_v_out_104011.awb")
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
	Play104011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104011011
		arg_44_1.duration_ = 4.47

		local var_44_0 = {
			ja = 4.466,
			ko = 3.133,
			zh = 3.2,
			en = 3.7
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
				arg_44_0:Play104011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.375

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(104011011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 15 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 15)

				if (15 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 15)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011011", "story_v_out_104011.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011011", "story_v_out_104011.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_104011", "104011011", "story_v_out_104011.awb")

						arg_44_1:RecordAudio("104011011", var_47_6)
						arg_44_1:RecordAudio("104011011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104011", "104011011", "story_v_out_104011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104011", "104011011", "story_v_out_104011.awb")
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
	Play104011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104011012
		arg_48_1.duration_ = 3.67

		local var_48_0 = {
			ja = 3.666,
			ko = 1.7,
			zh = 1.466,
			en = 2.033
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
				arg_48_0:Play104011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.2

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:GetWordFromCfg(104011012)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 8 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 8)

				if (8 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 8)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011012", "story_v_out_104011.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011012", "story_v_out_104011.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_104011", "104011012", "story_v_out_104011.awb")

						arg_48_1:RecordAudio("104011012", var_51_6)
						arg_48_1:RecordAudio("104011012", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104011", "104011012", "story_v_out_104011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104011", "104011012", "story_v_out_104011.awb")
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
	Play104011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104011013
		arg_52_1.duration_ = 14.2

		local var_52_0 = {
			ja = 14.2,
			ko = 10.066,
			zh = 10.066,
			en = 12
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
				arg_52_0:Play104011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1.4

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:GetWordFromCfg(104011013)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 56 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 56)

				if (56 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 56)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011013", "story_v_out_104011.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_104011", "104011013", "story_v_out_104011.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_104011", "104011013", "story_v_out_104011.awb")

						arg_52_1:RecordAudio("104011013", var_55_6)
						arg_52_1:RecordAudio("104011013", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104011", "104011013", "story_v_out_104011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104011", "104011013", "story_v_out_104011.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104011014
		arg_56_1.duration_ = 7

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if arg_56_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_59_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_56_1.stage_.transform)

				var_59_0.name = "1019ui_story"
				var_59_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["1019ui_story"] = var_59_0

				local var_59_1 = var_59_0:GetComponentInChildren(typeof(CharacterEffect))

				var_59_1.enabled = true

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_1.transform, false)

				arg_56_1.var_["1019ui_story" .. "Animator"] = var_59_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_56_1.var_["1019ui_story" .. "LipSync"] = var_59_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_59_3 = arg_56_1.actors_["1019ui_story"]

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= 2 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_4 = 0.1

			if 2 <= arg_56_1.time_ and arg_56_1.time_ < 2 + var_59_4 and not isNil(var_59_3) then
				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_3) then
					arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 2 + var_59_4 and arg_56_1.time_ < 2 + var_59_4 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect1019ui_story then
				arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_59_6 = "1036ui_story"

			if arg_56_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_59_7 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_56_1.stage_.transform)

				var_59_7.name = var_59_6
				var_59_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_[var_59_6] = var_59_7

				local var_59_8 = var_59_7:GetComponentInChildren(typeof(CharacterEffect))

				var_59_8.enabled = true

				local var_59_9 = GameObjectTools.GetOrAddComponent(var_59_7, typeof(DynamicBoneHelper))

				if var_59_9 then
					var_59_9:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_8.transform, false)

				arg_56_1.var_[var_59_6 .. "Animator"] = var_59_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_[var_59_6 .. "Animator"].applyRootMotion = true
				arg_56_1.var_[var_59_6 .. "LipSync"] = var_59_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_59_10 = arg_56_1.actors_["1036ui_story"]

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= 2 + arg_59_0 and not isNil(var_59_10) and arg_56_1.var_.characterEffect1036ui_story == nil then
				arg_56_1.var_.characterEffect1036ui_story = var_59_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.1

			if 2 <= arg_56_1.time_ and arg_56_1.time_ < 2 + var_59_11 and not isNil(var_59_10) then
				if arg_56_1.var_.characterEffect1036ui_story and not isNil(var_59_10) then
					arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 2) / var_59_11)
				end
			end

			if arg_56_1.time_ >= 2 + var_59_11 and arg_56_1.time_ < 2 + var_59_11 + arg_59_0 and not isNil(var_59_10) and arg_56_1.var_.characterEffect1036ui_story then
				arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_12 = arg_56_1.bgs_.S0103:GetComponent("SpriteRenderer")

				if var_59_12 then
					arg_56_1.var_.alphaOldValueS0103 = var_59_12.color.a
					arg_56_1.var_.alphaMatValueS0103 = var_59_12
				end

				arg_56_1.var_.alphaOldValueS0103 = 1
			end

			local var_59_13 = 1.5

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_13 then
				if arg_56_1.var_.alphaMatValueS0103 then
					arg_56_1.var_.alphaMatValueS0103.color.a = Mathf.Lerp(arg_56_1.var_.alphaOldValueS0103, 0, (arg_56_1.time_ - 0) / var_59_13)
					arg_56_1.var_.alphaMatValueS0103.color = arg_56_1.var_.alphaMatValueS0103.color
				end
			end

			if arg_56_1.time_ >= 0 + var_59_13 and arg_56_1.time_ < 0 + var_59_13 + arg_59_0 and arg_56_1.var_.alphaMatValueS0103 then
				arg_56_1.var_.alphaMatValueS0103.color.a = 0
				arg_56_1.var_.alphaMatValueS0103.color = arg_56_1.var_.alphaMatValueS0103.color
			end

			local var_59_14 = arg_56_1.bgs_.S0103.transform

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				arg_56_1.var_.moveOldPosS0103 = var_59_14.localPosition
			end

			local var_59_15 = 0.001

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_15 then
				var_59_14.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosS0103, Vector3.New(0, -100, 10), (arg_56_1.time_ - 1.5) / var_59_15)
			end

			if arg_56_1.time_ >= 1.5 + var_59_15 and arg_56_1.time_ < 1.5 + var_59_15 + arg_59_0 then
				var_59_14.localPosition = Vector3.New(0, -100, 10)
			end

			local var_59_16 = "B03d"

			if arg_56_1.bgs_.B03d == nil then
				local var_59_17 = Object.Instantiate(arg_56_1.paintGo_)

				var_59_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_59_16)
				var_59_17.name = var_59_16
				var_59_17.transform.parent = arg_56_1.stage_.transform
				var_59_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.bgs_[var_59_16] = var_59_17
			end

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				local var_59_18 = arg_56_1.bgs_.B03d:GetComponent("SpriteRenderer")

				if var_59_18 then
					arg_56_1.var_.alphaOldValueB03d = var_59_18.color.a
					arg_56_1.var_.alphaMatValueB03d = var_59_18
				end

				arg_56_1.var_.alphaOldValueB03d = 0
			end

			local var_59_19 = 1.5

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_19 then
				if arg_56_1.var_.alphaMatValueB03d then
					arg_56_1.var_.alphaMatValueB03d.color.a = Mathf.Lerp(arg_56_1.var_.alphaOldValueB03d, 1, (arg_56_1.time_ - 1.5) / var_59_19)
					arg_56_1.var_.alphaMatValueB03d.color = arg_56_1.var_.alphaMatValueB03d.color
				end
			end

			if arg_56_1.time_ >= 1.5 + var_59_19 and arg_56_1.time_ < 1.5 + var_59_19 + arg_59_0 and arg_56_1.var_.alphaMatValueB03d then
				arg_56_1.var_.alphaMatValueB03d.color.a = 1
				arg_56_1.var_.alphaMatValueB03d.color = arg_56_1.var_.alphaMatValueB03d.color
			end

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				local var_59_20 = arg_56_1.bgs_.B03d

				arg_56_1.bgs_.B03d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_59_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_21 = var_59_20:GetComponent("SpriteRenderer")

				if var_59_21 and var_59_21.sprite then
					local var_59_22 = 2 * (var_59_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_59_20.transform.localScale = Vector3.New(var_59_22 / var_59_21.sprite.bounds.size.y < var_59_22 * manager.ui.mainCameraCom_.aspect / var_59_21.sprite.bounds.size.x and var_59_22 * manager.ui.mainCameraCom_.aspect / var_59_21.sprite.bounds.size.x or var_59_22 / var_59_21.sprite.bounds.size.y, var_59_22 / var_59_21.sprite.bounds.size.y < var_59_22 * manager.ui.mainCameraCom_.aspect / var_59_21.sprite.bounds.size.x and var_59_22 * manager.ui.mainCameraCom_.aspect / var_59_21.sprite.bounds.size.x or var_59_22 / var_59_21.sprite.bounds.size.y, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "B03d" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_23 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_23 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_23 + 2 and arg_56_1.time_ < var_59_23 + 2 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_24 = 2
			local var_59_25 = 0.825

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_24 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_26 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_26:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_27 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(104011014).content)

				arg_56_1.text_.text = var_59_27

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_29 = 33 <= 0 and var_59_25 or var_59_25 * (utf8.len(var_59_27) / 33)

				if (33 <= 0 and var_59_25 or var_59_25 * (utf8.len(var_59_27) / 33)) > 0 and var_59_25 < var_59_29 then
					arg_56_1.talkMaxDuration = var_59_29
					var_59_24 = var_59_24 + 0.3

					if var_59_29 + var_59_24 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_29 + var_59_24
					end
				end

				arg_56_1.text_.text = var_59_27
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_30 = var_59_24 + 0.3
			local var_59_31 = math.max(var_59_25, arg_56_1.talkMaxDuration)

			if var_59_24 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_30 + var_59_31 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_30) / var_59_31

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_30 + var_59_31 and arg_56_1.time_ < var_59_30 + var_59_31 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play104011015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104011015
		arg_62_1.duration_ = 8.3

		local var_62_0 = {
			ja = 8.3,
			ko = 5.666,
			zh = 7.8,
			en = 6.6
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
				arg_62_0:Play104011016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1019ui_story = arg_62_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1019ui_story"].transform.position).z)
				arg_62_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1019ui_story"].transform.localEulerAngles = arg_62_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_62_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1019ui_story"].transform.position).z)
				arg_62_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1019ui_story"].transform.localEulerAngles = arg_62_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_65_1 = 0
			local var_65_2 = 1.025

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
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

				local var_65_3 = arg_62_1:GetWordFromCfg(104011015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 41 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_4) / 41)

				if (41 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_4) / 41)) > 0 and var_65_2 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011015", "story_v_out_104011.awb") ~= 0 then
					local var_65_7 = manager.audio:GetVoiceLength("story_v_out_104011", "104011015", "story_v_out_104011.awb") / 1000

					if var_65_7 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_1
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_104011", "104011015", "story_v_out_104011.awb")

						arg_62_1:RecordAudio("104011015", var_65_8)
						arg_62_1:RecordAudio("104011015", var_65_8)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104011", "104011015", "story_v_out_104011.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104011", "104011015", "story_v_out_104011.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_9 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_9 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_9

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_9 and arg_62_1.time_ < var_65_1 + var_65_9 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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
	Play104011016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104011016
		arg_66_1.duration_ = 1.5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play104011017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_69_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_66_1.stage_.transform)

				var_69_0.name = "1084ui_story"
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["1084ui_story"] = var_69_0

				local var_69_1 = var_69_0:GetComponentInChildren(typeof(CharacterEffect))

				var_69_1.enabled = true

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_1.transform, false)

				arg_66_1.var_["1084ui_story" .. "Animator"] = var_69_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_66_1.var_["1084ui_story" .. "LipSync"] = var_69_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_3 = arg_66_1.actors_["1084ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect1084ui_story == nil then
				arg_66_1.var_.characterEffect1084ui_story = var_69_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_4 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 and not isNil(var_69_3) then
				if arg_66_1.var_.characterEffect1084ui_story and not isNil(var_69_3) then
					arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect1084ui_story then
				arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_69_6 = arg_66_1.actors_["1019ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_6) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_7 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 and not isNil(var_69_6) then
				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_6) then
					arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_7)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 and not isNil(var_69_6) and arg_66_1.var_.characterEffect1019ui_story then
				arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_69_8 = arg_66_1.actors_["1019ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1019ui_story = var_69_8.localPosition
			end

			local var_69_9 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_9 then
				var_69_8.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_9)
				var_69_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_8.position).x, (manager.ui.mainCamera.transform.position - var_69_8.position).y, (manager.ui.mainCamera.transform.position - var_69_8.position).z)
				var_69_8.localEulerAngles.z = 0
				var_69_8.localEulerAngles.x = 0
				var_69_8.localEulerAngles = var_69_8.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_9 and arg_66_1.time_ < 0 + var_69_9 + arg_69_0 then
				var_69_8.localPosition = Vector3.New(0, 100, 0)
				var_69_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_8.position).x, (manager.ui.mainCamera.transform.position - var_69_8.position).y, (manager.ui.mainCamera.transform.position - var_69_8.position).z)
				var_69_8.localEulerAngles.z = 0
				var_69_8.localEulerAngles.x = 0
				var_69_8.localEulerAngles = var_69_8.localEulerAngles
			end

			local var_69_10 = arg_66_1.actors_["1084ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1084ui_story = var_69_10.localPosition
			end

			local var_69_11 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_11 then
				var_69_10.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_66_1.time_ - 0) / var_69_11)
				var_69_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_10.position).x, (manager.ui.mainCamera.transform.position - var_69_10.position).y, (manager.ui.mainCamera.transform.position - var_69_10.position).z)
				var_69_10.localEulerAngles.z = 0
				var_69_10.localEulerAngles.x = 0
				var_69_10.localEulerAngles = var_69_10.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_11 and arg_66_1.time_ < 0 + var_69_11 + arg_69_0 then
				var_69_10.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_69_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_10.position).x, (manager.ui.mainCamera.transform.position - var_69_10.position).y, (manager.ui.mainCamera.transform.position - var_69_10.position).z)
				var_69_10.localEulerAngles.z = 0
				var_69_10.localEulerAngles.x = 0
				var_69_10.localEulerAngles = var_69_10.localEulerAngles
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_69_12 = 0
			local var_69_13 = 0.05

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_14 = arg_66_1:GetWordFromCfg(104011016)
				local var_69_15 = arg_66_1:FormatText(var_69_14.content)

				arg_66_1.text_.text = var_69_15

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_17 = 2 <= 0 and var_69_13 or var_69_13 * (utf8.len(var_69_15) / 2)

				if (2 <= 0 and var_69_13 or var_69_13 * (utf8.len(var_69_15) / 2)) > 0 and var_69_13 < var_69_17 then
					arg_66_1.talkMaxDuration = var_69_17

					if var_69_17 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_17 + var_69_12
					end
				end

				arg_66_1.text_.text = var_69_15
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011016", "story_v_out_104011.awb") ~= 0 then
					local var_69_18 = manager.audio:GetVoiceLength("story_v_out_104011", "104011016", "story_v_out_104011.awb") / 1000

					if var_69_18 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_18 + var_69_12
					end

					if var_69_14.prefab_name ~= "" and arg_66_1.actors_[var_69_14.prefab_name] ~= nil then
						local var_69_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_14.prefab_name].transform, "story_v_out_104011", "104011016", "story_v_out_104011.awb")

						arg_66_1:RecordAudio("104011016", var_69_19)
						arg_66_1:RecordAudio("104011016", var_69_19)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_104011", "104011016", "story_v_out_104011.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_104011", "104011016", "story_v_out_104011.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_20 = math.max(var_69_13, arg_66_1.talkMaxDuration)

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_20 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_12) / var_69_20

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_12 + var_69_20 and arg_66_1.time_ < var_69_12 + var_69_20 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play104011017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104011017
		arg_70_1.duration_ = 2.13

		local var_70_0 = {
			ja = 1.7,
			ko = 1.499999999999,
			zh = 2.133,
			en = 1.6
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
				arg_70_0:Play104011018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_73_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_70_1.stage_.transform)

				var_73_0.name = "1011ui_story"
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1011ui_story"] = var_73_0

				local var_73_1 = var_73_0:GetComponentInChildren(typeof(CharacterEffect))

				var_73_1.enabled = true

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end

				arg_70_1:ShowWeapon(var_73_1.transform, false)

				arg_70_1.var_["1011ui_story" .. "Animator"] = var_73_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_70_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_70_1.var_["1011ui_story" .. "LipSync"] = var_73_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_73_3 = arg_70_1.actors_["1011ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect1011ui_story == nil then
				arg_70_1.var_.characterEffect1011ui_story = var_73_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_4 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 and not isNil(var_73_3) then
				if arg_70_1.var_.characterEffect1011ui_story and not isNil(var_73_3) then
					arg_70_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect1011ui_story then
				arg_70_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_73_6 = arg_70_1.actors_["1084ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_6) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = var_73_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 and not isNil(var_73_6) then
				if arg_70_1.var_.characterEffect1084ui_story and not isNil(var_73_6) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_7)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 and not isNil(var_73_6) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_73_8 = arg_70_1.actors_["1011ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1011ui_story = var_73_8.localPosition
			end

			local var_73_9 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_9 then
				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_70_1.time_ - 0) / var_73_9)
				var_73_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_8.position).x, (manager.ui.mainCamera.transform.position - var_73_8.position).y, (manager.ui.mainCamera.transform.position - var_73_8.position).z)
				var_73_8.localEulerAngles.z = 0
				var_73_8.localEulerAngles.x = 0
				var_73_8.localEulerAngles = var_73_8.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_9 and arg_70_1.time_ < 0 + var_73_9 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_73_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_8.position).x, (manager.ui.mainCamera.transform.position - var_73_8.position).y, (manager.ui.mainCamera.transform.position - var_73_8.position).z)
				var_73_8.localEulerAngles.z = 0
				var_73_8.localEulerAngles.x = 0
				var_73_8.localEulerAngles = var_73_8.localEulerAngles
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_73_10 = 0
			local var_73_11 = 0.125

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_12 = arg_70_1:GetWordFromCfg(104011017)
				local var_73_13 = arg_70_1:FormatText(var_73_12.content)

				arg_70_1.text_.text = var_73_13

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_15 = 5 <= 0 and var_73_11 or var_73_11 * (utf8.len(var_73_13) / 5)

				if (5 <= 0 and var_73_11 or var_73_11 * (utf8.len(var_73_13) / 5)) > 0 and var_73_11 < var_73_15 then
					arg_70_1.talkMaxDuration = var_73_15

					if var_73_15 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_15 + var_73_10
					end
				end

				arg_70_1.text_.text = var_73_13
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011017", "story_v_out_104011.awb") ~= 0 then
					local var_73_16 = manager.audio:GetVoiceLength("story_v_out_104011", "104011017", "story_v_out_104011.awb") / 1000

					if var_73_16 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_16 + var_73_10
					end

					if var_73_12.prefab_name ~= "" and arg_70_1.actors_[var_73_12.prefab_name] ~= nil then
						local var_73_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_12.prefab_name].transform, "story_v_out_104011", "104011017", "story_v_out_104011.awb")

						arg_70_1:RecordAudio("104011017", var_73_17)
						arg_70_1:RecordAudio("104011017", var_73_17)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_104011", "104011017", "story_v_out_104011.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_104011", "104011017", "story_v_out_104011.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_18 = math.max(var_73_11, arg_70_1.talkMaxDuration)

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_18 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_10) / var_73_18

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_10 + var_73_18 and arg_70_1.time_ < var_73_10 + var_73_18 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play104011018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104011018
		arg_74_1.duration_ = 10.6

		local var_74_0 = {
			ja = 10.4,
			ko = 10.5,
			zh = 8.566,
			en = 10.6
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
				arg_74_0:Play104011019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1036ui_story"]) and arg_74_1.var_.characterEffect1036ui_story == nil then
				arg_74_1.var_.characterEffect1036ui_story = arg_74_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1036ui_story"]) then
				if arg_74_1.var_.characterEffect1036ui_story and not isNil(arg_74_1.actors_["1036ui_story"]) then
					arg_74_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1036ui_story"]) and arg_74_1.var_.characterEffect1036ui_story then
				arg_74_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_77_2 = arg_74_1.actors_["1011ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1011ui_story == nil then
				arg_74_1.var_.characterEffect1011ui_story = var_77_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_3 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.characterEffect1011ui_story and not isNil(var_77_2) then
					arg_74_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_3)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1011ui_story then
				arg_74_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_77_4 = arg_74_1.actors_["1011ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1011ui_story = var_77_4.localPosition
			end

			local var_77_5 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_5 then
				var_77_4.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_5)
				var_77_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_4.position).x, (manager.ui.mainCamera.transform.position - var_77_4.position).y, (manager.ui.mainCamera.transform.position - var_77_4.position).z)
				var_77_4.localEulerAngles.z = 0
				var_77_4.localEulerAngles.x = 0
				var_77_4.localEulerAngles = var_77_4.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_5 and arg_74_1.time_ < 0 + var_77_5 + arg_77_0 then
				var_77_4.localPosition = Vector3.New(0, 100, 0)
				var_77_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_4.position).x, (manager.ui.mainCamera.transform.position - var_77_4.position).y, (manager.ui.mainCamera.transform.position - var_77_4.position).z)
				var_77_4.localEulerAngles.z = 0
				var_77_4.localEulerAngles.x = 0
				var_77_4.localEulerAngles = var_77_4.localEulerAngles
			end

			local var_77_6 = arg_74_1.actors_["1084ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1084ui_story = var_77_6.localPosition
			end

			local var_77_7 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				var_77_6.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_7)
				var_77_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_6.position).x, (manager.ui.mainCamera.transform.position - var_77_6.position).y, (manager.ui.mainCamera.transform.position - var_77_6.position).z)
				var_77_6.localEulerAngles.z = 0
				var_77_6.localEulerAngles.x = 0
				var_77_6.localEulerAngles = var_77_6.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				var_77_6.localPosition = Vector3.New(0, 100, 0)
				var_77_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_6.position).x, (manager.ui.mainCamera.transform.position - var_77_6.position).y, (manager.ui.mainCamera.transform.position - var_77_6.position).z)
				var_77_6.localEulerAngles.z = 0
				var_77_6.localEulerAngles.x = 0
				var_77_6.localEulerAngles = var_77_6.localEulerAngles
			end

			local var_77_8 = arg_74_1.actors_["1036ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1036ui_story = var_77_8.localPosition
			end

			local var_77_9 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_9 then
				var_77_8.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_74_1.time_ - 0) / var_77_9)
				var_77_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_8.position).x, (manager.ui.mainCamera.transform.position - var_77_8.position).y, (manager.ui.mainCamera.transform.position - var_77_8.position).z)
				var_77_8.localEulerAngles.z = 0
				var_77_8.localEulerAngles.x = 0
				var_77_8.localEulerAngles = var_77_8.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_9 and arg_74_1.time_ < 0 + var_77_9 + arg_77_0 then
				var_77_8.localPosition = Vector3.New(0, -1.09, -5.78)
				var_77_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_8.position).x, (manager.ui.mainCamera.transform.position - var_77_8.position).y, (manager.ui.mainCamera.transform.position - var_77_8.position).z)
				var_77_8.localEulerAngles.z = 0
				var_77_8.localEulerAngles.x = 0
				var_77_8.localEulerAngles = var_77_8.localEulerAngles
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_77_10 = 0
			local var_77_11 = 1.25

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_12 = arg_74_1:GetWordFromCfg(104011018)
				local var_77_13 = arg_74_1:FormatText(var_77_12.content)

				arg_74_1.text_.text = var_77_13

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_15 = 50 <= 0 and var_77_11 or var_77_11 * (utf8.len(var_77_13) / 50)

				if (50 <= 0 and var_77_11 or var_77_11 * (utf8.len(var_77_13) / 50)) > 0 and var_77_11 < var_77_15 then
					arg_74_1.talkMaxDuration = var_77_15

					if var_77_15 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_15 + var_77_10
					end
				end

				arg_74_1.text_.text = var_77_13
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011018", "story_v_out_104011.awb") ~= 0 then
					local var_77_16 = manager.audio:GetVoiceLength("story_v_out_104011", "104011018", "story_v_out_104011.awb") / 1000

					if var_77_16 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_16 + var_77_10
					end

					if var_77_12.prefab_name ~= "" and arg_74_1.actors_[var_77_12.prefab_name] ~= nil then
						local var_77_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_12.prefab_name].transform, "story_v_out_104011", "104011018", "story_v_out_104011.awb")

						arg_74_1:RecordAudio("104011018", var_77_17)
						arg_74_1:RecordAudio("104011018", var_77_17)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104011", "104011018", "story_v_out_104011.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104011", "104011018", "story_v_out_104011.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_18 = math.max(var_77_11, arg_74_1.talkMaxDuration)

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_18 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_10) / var_77_18

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_10 + var_77_18 and arg_74_1.time_ < var_77_10 + var_77_18 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play104011019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104011019
		arg_78_1.duration_ = 8.1

		local var_78_0 = {
			ja = 8.1,
			ko = 4.733,
			zh = 4.533,
			en = 5.7
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
				arg_78_0:Play104011020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action454")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_81_0 = 0
			local var_81_1 = 0.6

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_2 = arg_78_1:GetWordFromCfg(104011019)
				local var_81_3 = arg_78_1:FormatText(var_81_2.content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 24 <= 0 and var_81_1 or var_81_1 * (utf8.len(var_81_3) / 24)

				if (24 <= 0 and var_81_1 or var_81_1 * (utf8.len(var_81_3) / 24)) > 0 and var_81_1 < var_81_5 then
					arg_78_1.talkMaxDuration = var_81_5

					if var_81_5 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011019", "story_v_out_104011.awb") ~= 0 then
					local var_81_6 = manager.audio:GetVoiceLength("story_v_out_104011", "104011019", "story_v_out_104011.awb") / 1000

					if var_81_6 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_6 + var_81_0
					end

					if var_81_2.prefab_name ~= "" and arg_78_1.actors_[var_81_2.prefab_name] ~= nil then
						local var_81_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_2.prefab_name].transform, "story_v_out_104011", "104011019", "story_v_out_104011.awb")

						arg_78_1:RecordAudio("104011019", var_81_7)
						arg_78_1:RecordAudio("104011019", var_81_7)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_104011", "104011019", "story_v_out_104011.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_104011", "104011019", "story_v_out_104011.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_8 and arg_78_1.time_ < var_81_0 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play104011020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104011020
		arg_82_1.duration_ = 1.67

		local var_82_0 = {
			ja = 1.666,
			ko = 1.433,
			zh = 1.266,
			en = 1.4
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
				arg_82_0:Play104011021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1019ui_story"]) and arg_82_1.var_.characterEffect1019ui_story == nil then
				arg_82_1.var_.characterEffect1019ui_story = arg_82_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1019ui_story"]) then
				if arg_82_1.var_.characterEffect1019ui_story and not isNil(arg_82_1.actors_["1019ui_story"]) then
					arg_82_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1019ui_story"]) and arg_82_1.var_.characterEffect1019ui_story then
				arg_82_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_85_2 = arg_82_1.actors_["1036ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1036ui_story == nil then
				arg_82_1.var_.characterEffect1036ui_story = var_85_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_3 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.characterEffect1036ui_story and not isNil(var_85_2) then
					arg_82_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_3)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1036ui_story then
				arg_82_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_85_4 = 0
			local var_85_5 = 0.05

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_6 = arg_82_1:GetWordFromCfg(104011020)
				local var_85_7 = arg_82_1:FormatText(var_85_6.content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 2 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 2)

				if (2 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 2)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011020", "story_v_out_104011.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_104011", "104011020", "story_v_out_104011.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_104011", "104011020", "story_v_out_104011.awb")

						arg_82_1:RecordAudio("104011020", var_85_11)
						arg_82_1:RecordAudio("104011020", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104011", "104011020", "story_v_out_104011.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104011", "104011020", "story_v_out_104011.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_12 and arg_82_1.time_ < var_85_4 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play104011021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 104011021
		arg_86_1.duration_ = 8.73

		local var_86_0 = {
			ja = 8.733,
			ko = 4.433,
			zh = 4.833,
			en = 8.2
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play104011022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = arg_86_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) then
				if arg_86_1.var_.characterEffect1084ui_story and not isNil(arg_86_1.actors_["1084ui_story"]) then
					arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) and arg_86_1.var_.characterEffect1084ui_story then
				arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_89_2 = arg_86_1.actors_["1019ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1019ui_story == nil then
				arg_86_1.var_.characterEffect1019ui_story = var_89_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_3 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 and not isNil(var_89_2) then
				if arg_86_1.var_.characterEffect1019ui_story and not isNil(var_89_2) then
					arg_86_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_3)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1019ui_story then
				arg_86_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_89_4 = arg_86_1.actors_["1036ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1036ui_story = var_89_4.localPosition
			end

			local var_89_5 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_5 then
				var_89_4.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_5)
				var_89_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_4.position).x, (manager.ui.mainCamera.transform.position - var_89_4.position).y, (manager.ui.mainCamera.transform.position - var_89_4.position).z)
				var_89_4.localEulerAngles.z = 0
				var_89_4.localEulerAngles.x = 0
				var_89_4.localEulerAngles = var_89_4.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_5 and arg_86_1.time_ < 0 + var_89_5 + arg_89_0 then
				var_89_4.localPosition = Vector3.New(0, 100, 0)
				var_89_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_4.position).x, (manager.ui.mainCamera.transform.position - var_89_4.position).y, (manager.ui.mainCamera.transform.position - var_89_4.position).z)
				var_89_4.localEulerAngles.z = 0
				var_89_4.localEulerAngles.x = 0
				var_89_4.localEulerAngles = var_89_4.localEulerAngles
			end

			local var_89_6 = arg_86_1.actors_["1036ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1036ui_story = var_89_6.localPosition
			end

			local var_89_7 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				var_89_6.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_7)
				var_89_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_6.position).x, (manager.ui.mainCamera.transform.position - var_89_6.position).y, (manager.ui.mainCamera.transform.position - var_89_6.position).z)
				var_89_6.localEulerAngles.z = 0
				var_89_6.localEulerAngles.x = 0
				var_89_6.localEulerAngles = var_89_6.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				var_89_6.localPosition = Vector3.New(0, 100, 0)
				var_89_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_6.position).x, (manager.ui.mainCamera.transform.position - var_89_6.position).y, (manager.ui.mainCamera.transform.position - var_89_6.position).z)
				var_89_6.localEulerAngles.z = 0
				var_89_6.localEulerAngles.x = 0
				var_89_6.localEulerAngles = var_89_6.localEulerAngles
			end

			local var_89_8 = arg_86_1.actors_["1084ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1084ui_story = var_89_8.localPosition
			end

			local var_89_9 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_9 then
				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_86_1.time_ - 0) / var_89_9)
				var_89_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_8.position).x, (manager.ui.mainCamera.transform.position - var_89_8.position).y, (manager.ui.mainCamera.transform.position - var_89_8.position).z)
				var_89_8.localEulerAngles.z = 0
				var_89_8.localEulerAngles.x = 0
				var_89_8.localEulerAngles = var_89_8.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_9 and arg_86_1.time_ < 0 + var_89_9 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_89_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_8.position).x, (manager.ui.mainCamera.transform.position - var_89_8.position).y, (manager.ui.mainCamera.transform.position - var_89_8.position).z)
				var_89_8.localEulerAngles.z = 0
				var_89_8.localEulerAngles.x = 0
				var_89_8.localEulerAngles = var_89_8.localEulerAngles
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_89_10 = 0
			local var_89_11 = 0.6

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_12 = arg_86_1:GetWordFromCfg(104011021)
				local var_89_13 = arg_86_1:FormatText(var_89_12.content)

				arg_86_1.text_.text = var_89_13

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 21 <= 0 and var_89_11 or var_89_11 * (utf8.len(var_89_13) / 21)

				if (21 <= 0 and var_89_11 or var_89_11 * (utf8.len(var_89_13) / 21)) > 0 and var_89_11 < var_89_15 then
					arg_86_1.talkMaxDuration = var_89_15

					if var_89_15 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_15 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_13
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011021", "story_v_out_104011.awb") ~= 0 then
					local var_89_16 = manager.audio:GetVoiceLength("story_v_out_104011", "104011021", "story_v_out_104011.awb") / 1000

					if var_89_16 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_10
					end

					if var_89_12.prefab_name ~= "" and arg_86_1.actors_[var_89_12.prefab_name] ~= nil then
						local var_89_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_12.prefab_name].transform, "story_v_out_104011", "104011021", "story_v_out_104011.awb")

						arg_86_1:RecordAudio("104011021", var_89_17)
						arg_86_1:RecordAudio("104011021", var_89_17)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_104011", "104011021", "story_v_out_104011.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_104011", "104011021", "story_v_out_104011.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_18 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_18 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_18

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_18 and arg_86_1.time_ < var_89_10 + var_89_18 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_86_1:InitPlayNodeList()
	end,
	Play104011022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 104011022
		arg_90_1.duration_ = 7.97

		local var_90_0 = {
			ja = 7.966,
			ko = 3.733,
			zh = 4.633,
			en = 4.3
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
				arg_90_0:Play104011023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1011ui_story"]) and arg_90_1.var_.characterEffect1011ui_story == nil then
				arg_90_1.var_.characterEffect1011ui_story = arg_90_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1011ui_story"]) then
				if arg_90_1.var_.characterEffect1011ui_story and not isNil(arg_90_1.actors_["1011ui_story"]) then
					arg_90_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1011ui_story"]) and arg_90_1.var_.characterEffect1011ui_story then
				arg_90_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_93_2 = arg_90_1.actors_["1084ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1084ui_story then
				arg_90_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_93_4 = arg_90_1.actors_["1011ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1011ui_story = var_93_4.localPosition
			end

			local var_93_5 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_5 then
				var_93_4.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_90_1.time_ - 0) / var_93_5)
				var_93_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_4.position).x, (manager.ui.mainCamera.transform.position - var_93_4.position).y, (manager.ui.mainCamera.transform.position - var_93_4.position).z)
				var_93_4.localEulerAngles.z = 0
				var_93_4.localEulerAngles.x = 0
				var_93_4.localEulerAngles = var_93_4.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_5 and arg_90_1.time_ < 0 + var_93_5 + arg_93_0 then
				var_93_4.localPosition = Vector3.New(0.7, -0.71, -6)
				var_93_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_4.position).x, (manager.ui.mainCamera.transform.position - var_93_4.position).y, (manager.ui.mainCamera.transform.position - var_93_4.position).z)
				var_93_4.localEulerAngles.z = 0
				var_93_4.localEulerAngles.x = 0
				var_93_4.localEulerAngles = var_93_4.localEulerAngles
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_93_6 = 0
			local var_93_7 = 0.375

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_8 = arg_90_1:GetWordFromCfg(104011022)
				local var_93_9 = arg_90_1:FormatText(var_93_8.content)

				arg_90_1.text_.text = var_93_9

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 15 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 15)

				if (15 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 15)) > 0 and var_93_7 < var_93_11 then
					arg_90_1.talkMaxDuration = var_93_11

					if var_93_11 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_9
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011022", "story_v_out_104011.awb") ~= 0 then
					local var_93_12 = manager.audio:GetVoiceLength("story_v_out_104011", "104011022", "story_v_out_104011.awb") / 1000

					if var_93_12 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_6
					end

					if var_93_8.prefab_name ~= "" and arg_90_1.actors_[var_93_8.prefab_name] ~= nil then
						local var_93_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_8.prefab_name].transform, "story_v_out_104011", "104011022", "story_v_out_104011.awb")

						arg_90_1:RecordAudio("104011022", var_93_13)
						arg_90_1:RecordAudio("104011022", var_93_13)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_104011", "104011022", "story_v_out_104011.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_104011", "104011022", "story_v_out_104011.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play104011023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 104011023
		arg_94_1.duration_ = 11.7

		local var_94_0 = {
			ja = 11.7,
			ko = 6.3,
			zh = 6.566,
			en = 7.5
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
				arg_94_0:Play104011024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1019ui_story"]) and arg_94_1.var_.characterEffect1019ui_story == nil then
				arg_94_1.var_.characterEffect1019ui_story = arg_94_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1019ui_story"]) then
				if arg_94_1.var_.characterEffect1019ui_story and not isNil(arg_94_1.actors_["1019ui_story"]) then
					arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1019ui_story"]) and arg_94_1.var_.characterEffect1019ui_story then
				arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["1011ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1011ui_story == nil then
				arg_94_1.var_.characterEffect1011ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect1011ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1011ui_story then
				arg_94_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_97_4 = arg_94_1.actors_["1011ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1011ui_story = var_97_4.localPosition
			end

			local var_97_5 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_5 then
				var_97_4.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_5)
				var_97_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_4.position).x, (manager.ui.mainCamera.transform.position - var_97_4.position).y, (manager.ui.mainCamera.transform.position - var_97_4.position).z)
				var_97_4.localEulerAngles.z = 0
				var_97_4.localEulerAngles.x = 0
				var_97_4.localEulerAngles = var_97_4.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_5 and arg_94_1.time_ < 0 + var_97_5 + arg_97_0 then
				var_97_4.localPosition = Vector3.New(0, 100, 0)
				var_97_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_4.position).x, (manager.ui.mainCamera.transform.position - var_97_4.position).y, (manager.ui.mainCamera.transform.position - var_97_4.position).z)
				var_97_4.localEulerAngles.z = 0
				var_97_4.localEulerAngles.x = 0
				var_97_4.localEulerAngles = var_97_4.localEulerAngles
			end

			local var_97_6 = arg_94_1.actors_["1084ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = var_97_6.localPosition
			end

			local var_97_7 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				var_97_6.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_7)
				var_97_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_6.position).x, (manager.ui.mainCamera.transform.position - var_97_6.position).y, (manager.ui.mainCamera.transform.position - var_97_6.position).z)
				var_97_6.localEulerAngles.z = 0
				var_97_6.localEulerAngles.x = 0
				var_97_6.localEulerAngles = var_97_6.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				var_97_6.localPosition = Vector3.New(0, 100, 0)
				var_97_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_6.position).x, (manager.ui.mainCamera.transform.position - var_97_6.position).y, (manager.ui.mainCamera.transform.position - var_97_6.position).z)
				var_97_6.localEulerAngles.z = 0
				var_97_6.localEulerAngles.x = 0
				var_97_6.localEulerAngles = var_97_6.localEulerAngles
			end

			local var_97_8 = arg_94_1.actors_["1019ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1019ui_story = var_97_8.localPosition
			end

			local var_97_9 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_9 then
				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_94_1.time_ - 0) / var_97_9)
				var_97_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_8.position).x, (manager.ui.mainCamera.transform.position - var_97_8.position).y, (manager.ui.mainCamera.transform.position - var_97_8.position).z)
				var_97_8.localEulerAngles.z = 0
				var_97_8.localEulerAngles.x = 0
				var_97_8.localEulerAngles = var_97_8.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_9 and arg_94_1.time_ < 0 + var_97_9 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_97_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_8.position).x, (manager.ui.mainCamera.transform.position - var_97_8.position).y, (manager.ui.mainCamera.transform.position - var_97_8.position).z)
				var_97_8.localEulerAngles.z = 0
				var_97_8.localEulerAngles.x = 0
				var_97_8.localEulerAngles = var_97_8.localEulerAngles
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_97_10 = 0
			local var_97_11 = 0.8

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_12 = arg_94_1:GetWordFromCfg(104011023)
				local var_97_13 = arg_94_1:FormatText(var_97_12.content)

				arg_94_1.text_.text = var_97_13

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_15 = 32 <= 0 and var_97_11 or var_97_11 * (utf8.len(var_97_13) / 32)

				if (32 <= 0 and var_97_11 or var_97_11 * (utf8.len(var_97_13) / 32)) > 0 and var_97_11 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15

					if var_97_15 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_10
					end
				end

				arg_94_1.text_.text = var_97_13
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011023", "story_v_out_104011.awb") ~= 0 then
					local var_97_16 = manager.audio:GetVoiceLength("story_v_out_104011", "104011023", "story_v_out_104011.awb") / 1000

					if var_97_16 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_16 + var_97_10
					end

					if var_97_12.prefab_name ~= "" and arg_94_1.actors_[var_97_12.prefab_name] ~= nil then
						local var_97_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_12.prefab_name].transform, "story_v_out_104011", "104011023", "story_v_out_104011.awb")

						arg_94_1:RecordAudio("104011023", var_97_17)
						arg_94_1:RecordAudio("104011023", var_97_17)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_104011", "104011023", "story_v_out_104011.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_104011", "104011023", "story_v_out_104011.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_18 = math.max(var_97_11, arg_94_1.talkMaxDuration)

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_18 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_10) / var_97_18

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_10 + var_97_18 and arg_94_1.time_ < var_97_10 + var_97_18 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play104011024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 104011024
		arg_98_1.duration_ = 5.23

		local var_98_0 = {
			ja = 5.233,
			ko = 2.2,
			zh = 2.366,
			en = 1.999999999999
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
				arg_98_0:Play104011025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1036ui_story"]) and arg_98_1.var_.characterEffect1036ui_story == nil then
				arg_98_1.var_.characterEffect1036ui_story = arg_98_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1036ui_story"]) then
				if arg_98_1.var_.characterEffect1036ui_story and not isNil(arg_98_1.actors_["1036ui_story"]) then
					arg_98_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1036ui_story"]) and arg_98_1.var_.characterEffect1036ui_story then
				arg_98_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["1019ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect1019ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1019ui_story then
				arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_101_4 = arg_98_1.actors_["1019ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1019ui_story = var_101_4.localPosition
			end

			local var_101_5 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_5 then
				var_101_4.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_5)
				var_101_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_4.position).x, (manager.ui.mainCamera.transform.position - var_101_4.position).y, (manager.ui.mainCamera.transform.position - var_101_4.position).z)
				var_101_4.localEulerAngles.z = 0
				var_101_4.localEulerAngles.x = 0
				var_101_4.localEulerAngles = var_101_4.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_5 and arg_98_1.time_ < 0 + var_101_5 + arg_101_0 then
				var_101_4.localPosition = Vector3.New(0, 100, 0)
				var_101_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_4.position).x, (manager.ui.mainCamera.transform.position - var_101_4.position).y, (manager.ui.mainCamera.transform.position - var_101_4.position).z)
				var_101_4.localEulerAngles.z = 0
				var_101_4.localEulerAngles.x = 0
				var_101_4.localEulerAngles = var_101_4.localEulerAngles
			end

			local var_101_6 = arg_98_1.actors_["1036ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1036ui_story = var_101_6.localPosition
			end

			local var_101_7 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				var_101_6.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_98_1.time_ - 0) / var_101_7)
				var_101_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_6.position).x, (manager.ui.mainCamera.transform.position - var_101_6.position).y, (manager.ui.mainCamera.transform.position - var_101_6.position).z)
				var_101_6.localEulerAngles.z = 0
				var_101_6.localEulerAngles.x = 0
				var_101_6.localEulerAngles = var_101_6.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				var_101_6.localPosition = Vector3.New(0, -1.09, -5.78)
				var_101_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_6.position).x, (manager.ui.mainCamera.transform.position - var_101_6.position).y, (manager.ui.mainCamera.transform.position - var_101_6.position).z)
				var_101_6.localEulerAngles.z = 0
				var_101_6.localEulerAngles.x = 0
				var_101_6.localEulerAngles = var_101_6.localEulerAngles
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_101_8 = 0
			local var_101_9 = 0.225

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_10 = arg_98_1:GetWordFromCfg(104011024)
				local var_101_11 = arg_98_1:FormatText(var_101_10.content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 9 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 9)

				if (9 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 9)) > 0 and var_101_9 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011024", "story_v_out_104011.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_104011", "104011024", "story_v_out_104011.awb") / 1000

					if var_101_14 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_8
					end

					if var_101_10.prefab_name ~= "" and arg_98_1.actors_[var_101_10.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_10.prefab_name].transform, "story_v_out_104011", "104011024", "story_v_out_104011.awb")

						arg_98_1:RecordAudio("104011024", var_101_15)
						arg_98_1:RecordAudio("104011024", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_104011", "104011024", "story_v_out_104011.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_104011", "104011024", "story_v_out_104011.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_16 and arg_98_1.time_ < var_101_8 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play104011025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 104011025
		arg_102_1.duration_ = 0.1

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"

			SetActive(arg_102_1.choicesGo_, true)

			for iter_103_0, iter_103_1 in ipairs(arg_102_1.choices_) do
				SetActive(iter_103_1.go, iter_103_0 <= 2)
			end

			arg_102_1.choices_[1].txt.text = arg_102_1:FormatText(StoryChoiceCfg[20].name)
			arg_102_1.choices_[2].txt.text = arg_102_1:FormatText(StoryChoiceCfg[21].name)
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play104011026(arg_102_1)
			end

			if arg_104_0 == 2 then
				arg_102_0:Play104011029(arg_102_1)
			end

			arg_102_1:RecordChoiceLog(104011025, 20, 21)
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1036ui_story"]) and arg_102_1.var_.characterEffect1036ui_story == nil then
				arg_102_1.var_.characterEffect1036ui_story = arg_102_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1036ui_story"]) then
				if arg_102_1.var_.characterEffect1036ui_story and not isNil(arg_102_1.actors_["1036ui_story"]) then
					arg_102_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1036ui_story"]) and arg_102_1.var_.characterEffect1036ui_story then
				arg_102_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play104011026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 104011026
		arg_106_1.duration_ = 2.17

		local var_106_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.166,
			en = 1.999999999999
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
				arg_106_0:Play104011027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1036ui_story"]) and arg_106_1.var_.characterEffect1036ui_story == nil then
				arg_106_1.var_.characterEffect1036ui_story = arg_106_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1036ui_story"]) then
				if arg_106_1.var_.characterEffect1036ui_story and not isNil(arg_106_1.actors_["1036ui_story"]) then
					arg_106_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1036ui_story"]) and arg_106_1.var_.characterEffect1036ui_story then
				arg_106_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action442")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_109_2 = 0
			local var_109_3 = 0.25

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(104011026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 10 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 10)

				if (10 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 10)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011026", "story_v_out_104011.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_104011", "104011026", "story_v_out_104011.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_104011", "104011026", "story_v_out_104011.awb")

						arg_106_1:RecordAudio("104011026", var_109_9)
						arg_106_1:RecordAudio("104011026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_104011", "104011026", "story_v_out_104011.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_104011", "104011026", "story_v_out_104011.awb")
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
	Play104011027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 104011027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play104011028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1036ui_story"]) and arg_110_1.var_.characterEffect1036ui_story == nil then
				arg_110_1.var_.characterEffect1036ui_story = arg_110_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1036ui_story"]) then
				if arg_110_1.var_.characterEffect1036ui_story and not isNil(arg_110_1.actors_["1036ui_story"]) then
					arg_110_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1036ui_story"]) and arg_110_1.var_.characterEffect1036ui_story then
				arg_110_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 0.775

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(104011027).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 31 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 31)

				if (31 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 31)) > 0 and var_113_2 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_6 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_6 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_6

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_6 and arg_110_1.time_ < var_113_1 + var_113_6 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play104011028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 104011028
		arg_114_1.duration_ = 4.4

		local var_114_0 = {
			ja = 4.4,
			ko = 2.166,
			zh = 3.833,
			en = 2.966
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
				arg_114_0:Play104011033(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1036ui_story"]) and arg_114_1.var_.characterEffect1036ui_story == nil then
				arg_114_1.var_.characterEffect1036ui_story = arg_114_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1036ui_story"]) then
				if arg_114_1.var_.characterEffect1036ui_story and not isNil(arg_114_1.actors_["1036ui_story"]) then
					arg_114_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1036ui_story"]) and arg_114_1.var_.characterEffect1036ui_story then
				arg_114_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action425")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_117_2 = 0
			local var_117_3 = 0.425

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:GetWordFromCfg(104011028)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 16 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 16)

				if (16 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 16)) > 0 and var_117_3 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011028", "story_v_out_104011.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_104011", "104011028", "story_v_out_104011.awb") / 1000

					if var_117_8 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_2
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_out_104011", "104011028", "story_v_out_104011.awb")

						arg_114_1:RecordAudio("104011028", var_117_9)
						arg_114_1:RecordAudio("104011028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_104011", "104011028", "story_v_out_104011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_104011", "104011028", "story_v_out_104011.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_10 and arg_114_1.time_ < var_117_2 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play104011033 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 104011033
		arg_118_1.duration_ = 4

		local var_118_0 = {
			ja = 4,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_118_0:Play104011034(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) and arg_118_1.var_.characterEffect1019ui_story == nil then
				arg_118_1.var_.characterEffect1019ui_story = arg_118_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) then
				if arg_118_1.var_.characterEffect1019ui_story and not isNil(arg_118_1.actors_["1019ui_story"]) then
					arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) and arg_118_1.var_.characterEffect1019ui_story then
				arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["1036ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1036ui_story = var_121_2.localPosition
			end

			local var_121_3 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 then
				var_121_2.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_3)
				var_121_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_2.position).x, (manager.ui.mainCamera.transform.position - var_121_2.position).y, (manager.ui.mainCamera.transform.position - var_121_2.position).z)
				var_121_2.localEulerAngles.z = 0
				var_121_2.localEulerAngles.x = 0
				var_121_2.localEulerAngles = var_121_2.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 then
				var_121_2.localPosition = Vector3.New(0, 100, 0)
				var_121_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_2.position).x, (manager.ui.mainCamera.transform.position - var_121_2.position).y, (manager.ui.mainCamera.transform.position - var_121_2.position).z)
				var_121_2.localEulerAngles.z = 0
				var_121_2.localEulerAngles.x = 0
				var_121_2.localEulerAngles = var_121_2.localEulerAngles
			end

			local var_121_4 = arg_118_1.actors_["1019ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1019ui_story = var_121_4.localPosition
			end

			local var_121_5 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_5 then
				var_121_4.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_118_1.time_ - 0) / var_121_5)
				var_121_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_4.position).x, (manager.ui.mainCamera.transform.position - var_121_4.position).y, (manager.ui.mainCamera.transform.position - var_121_4.position).z)
				var_121_4.localEulerAngles.z = 0
				var_121_4.localEulerAngles.x = 0
				var_121_4.localEulerAngles = var_121_4.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_5 and arg_118_1.time_ < 0 + var_121_5 + arg_121_0 then
				var_121_4.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_121_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_4.position).x, (manager.ui.mainCamera.transform.position - var_121_4.position).y, (manager.ui.mainCamera.transform.position - var_121_4.position).z)
				var_121_4.localEulerAngles.z = 0
				var_121_4.localEulerAngles.x = 0
				var_121_4.localEulerAngles = var_121_4.localEulerAngles
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_121_6 = 0
			local var_121_7 = 0.15

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_8 = arg_118_1:GetWordFromCfg(104011033)
				local var_121_9 = arg_118_1:FormatText(var_121_8.content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 6 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 6)

				if (6 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 6)) > 0 and var_121_7 < var_121_11 then
					arg_118_1.talkMaxDuration = var_121_11

					if var_121_11 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_11 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011033", "story_v_out_104011.awb") ~= 0 then
					local var_121_12 = manager.audio:GetVoiceLength("story_v_out_104011", "104011033", "story_v_out_104011.awb") / 1000

					if var_121_12 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_6
					end

					if var_121_8.prefab_name ~= "" and arg_118_1.actors_[var_121_8.prefab_name] ~= nil then
						local var_121_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_8.prefab_name].transform, "story_v_out_104011", "104011033", "story_v_out_104011.awb")

						arg_118_1:RecordAudio("104011033", var_121_13)
						arg_118_1:RecordAudio("104011033", var_121_13)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_104011", "104011033", "story_v_out_104011.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_104011", "104011033", "story_v_out_104011.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
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

		arg_118_1:InitPlayNodeList()
	end,
	Play104011034 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 104011034
		arg_122_1.duration_ = 15.67

		local var_122_0 = {
			ja = 15.666,
			ko = 9.166,
			zh = 9.633,
			en = 13.066
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
				arg_122_0:Play104011035(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_125_0 = 0
			local var_125_1 = 1.25

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(104011034)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 49 <= 0 and var_125_1 or var_125_1 * (utf8.len(var_125_3) / 49)

				if (49 <= 0 and var_125_1 or var_125_1 * (utf8.len(var_125_3) / 49)) > 0 and var_125_1 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011034", "story_v_out_104011.awb") ~= 0 then
					local var_125_6 = manager.audio:GetVoiceLength("story_v_out_104011", "104011034", "story_v_out_104011.awb") / 1000

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end

					if var_125_2.prefab_name ~= "" and arg_122_1.actors_[var_125_2.prefab_name] ~= nil then
						local var_125_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_2.prefab_name].transform, "story_v_out_104011", "104011034", "story_v_out_104011.awb")

						arg_122_1:RecordAudio("104011034", var_125_7)
						arg_122_1:RecordAudio("104011034", var_125_7)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_104011", "104011034", "story_v_out_104011.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_104011", "104011034", "story_v_out_104011.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_8 and arg_122_1.time_ < var_125_0 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play104011035 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 104011035
		arg_126_1.duration_ = 2

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play104011036(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1011ui_story"]) and arg_126_1.var_.characterEffect1011ui_story == nil then
				arg_126_1.var_.characterEffect1011ui_story = arg_126_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1011ui_story"]) then
				if arg_126_1.var_.characterEffect1011ui_story and not isNil(arg_126_1.actors_["1011ui_story"]) then
					arg_126_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1011ui_story"]) and arg_126_1.var_.characterEffect1011ui_story then
				arg_126_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_129_2 = arg_126_1.actors_["1084ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_3 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_2) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_129_5 = arg_126_1.actors_["1019ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1019ui_story == nil then
				arg_126_1.var_.characterEffect1019ui_story = var_129_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 and not isNil(var_129_5) then
				if arg_126_1.var_.characterEffect1019ui_story and not isNil(var_129_5) then
					arg_126_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_6)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1019ui_story then
				arg_126_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_129_7 = arg_126_1.actors_["1019ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1019ui_story = var_129_7.localPosition
			end

			local var_129_8 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_8 then
				var_129_7.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_8)
				var_129_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_7.position).x, (manager.ui.mainCamera.transform.position - var_129_7.position).y, (manager.ui.mainCamera.transform.position - var_129_7.position).z)
				var_129_7.localEulerAngles.z = 0
				var_129_7.localEulerAngles.x = 0
				var_129_7.localEulerAngles = var_129_7.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_8 and arg_126_1.time_ < 0 + var_129_8 + arg_129_0 then
				var_129_7.localPosition = Vector3.New(0, 100, 0)
				var_129_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_7.position).x, (manager.ui.mainCamera.transform.position - var_129_7.position).y, (manager.ui.mainCamera.transform.position - var_129_7.position).z)
				var_129_7.localEulerAngles.z = 0
				var_129_7.localEulerAngles.x = 0
				var_129_7.localEulerAngles = var_129_7.localEulerAngles
			end

			local var_129_9 = arg_126_1.actors_["1084ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_9.localPosition
			end

			local var_129_10 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_10 then
				var_129_9.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_126_1.time_ - 0) / var_129_10)
				var_129_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_9.position).x, (manager.ui.mainCamera.transform.position - var_129_9.position).y, (manager.ui.mainCamera.transform.position - var_129_9.position).z)
				var_129_9.localEulerAngles.z = 0
				var_129_9.localEulerAngles.x = 0
				var_129_9.localEulerAngles = var_129_9.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_10 and arg_126_1.time_ < 0 + var_129_10 + arg_129_0 then
				var_129_9.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_129_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_9.position).x, (manager.ui.mainCamera.transform.position - var_129_9.position).y, (manager.ui.mainCamera.transform.position - var_129_9.position).z)
				var_129_9.localEulerAngles.z = 0
				var_129_9.localEulerAngles.x = 0
				var_129_9.localEulerAngles = var_129_9.localEulerAngles
			end

			local var_129_11 = arg_126_1.actors_["1011ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1011ui_story = var_129_11.localPosition
			end

			local var_129_12 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_12 then
				var_129_11.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_126_1.time_ - 0) / var_129_12)
				var_129_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_11.position).x, (manager.ui.mainCamera.transform.position - var_129_11.position).y, (manager.ui.mainCamera.transform.position - var_129_11.position).z)
				var_129_11.localEulerAngles.z = 0
				var_129_11.localEulerAngles.x = 0
				var_129_11.localEulerAngles = var_129_11.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_12 and arg_126_1.time_ < 0 + var_129_12 + arg_129_0 then
				var_129_11.localPosition = Vector3.New(0.7, -0.71, -6)
				var_129_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_11.position).x, (manager.ui.mainCamera.transform.position - var_129_11.position).y, (manager.ui.mainCamera.transform.position - var_129_11.position).z)
				var_129_11.localEulerAngles.z = 0
				var_129_11.localEulerAngles.x = 0
				var_129_11.localEulerAngles = var_129_11.localEulerAngles
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_129_13 = 0
			local var_129_14 = 0.05

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[54].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_15 = arg_126_1:GetWordFromCfg(104011035)
				local var_129_16 = arg_126_1:FormatText(var_129_15.content)

				arg_126_1.text_.text = var_129_16

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_18 = 2 <= 0 and var_129_14 or var_129_14 * (utf8.len(var_129_16) / 2)

				if (2 <= 0 and var_129_14 or var_129_14 * (utf8.len(var_129_16) / 2)) > 0 and var_129_14 < var_129_18 then
					arg_126_1.talkMaxDuration = var_129_18

					if var_129_18 + var_129_13 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_18 + var_129_13
					end
				end

				arg_126_1.text_.text = var_129_16
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011035", "story_v_out_104011.awb") ~= 0 then
					local var_129_19 = manager.audio:GetVoiceLength("story_v_out_104011", "104011035", "story_v_out_104011.awb") / 1000

					if var_129_19 + var_129_13 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_19 + var_129_13
					end

					if var_129_15.prefab_name ~= "" and arg_126_1.actors_[var_129_15.prefab_name] ~= nil then
						local var_129_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_15.prefab_name].transform, "story_v_out_104011", "104011035", "story_v_out_104011.awb")

						arg_126_1:RecordAudio("104011035", var_129_20)
						arg_126_1:RecordAudio("104011035", var_129_20)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_104011", "104011035", "story_v_out_104011.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_104011", "104011035", "story_v_out_104011.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_21 = math.max(var_129_14, arg_126_1.talkMaxDuration)

			if var_129_13 <= arg_126_1.time_ and arg_126_1.time_ < var_129_13 + var_129_21 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_13) / var_129_21

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_13 + var_129_21 and arg_126_1.time_ < var_129_13 + var_129_21 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play104011036 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 104011036
		arg_130_1.duration_ = 3.5

		local var_130_0 = {
			ja = 3.5,
			ko = 2.1,
			zh = 2.433,
			en = 2.866
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
				arg_130_0:Play104011037(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1019ui_story"]) and arg_130_1.var_.characterEffect1019ui_story == nil then
				arg_130_1.var_.characterEffect1019ui_story = arg_130_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1019ui_story"]) then
				if arg_130_1.var_.characterEffect1019ui_story and not isNil(arg_130_1.actors_["1019ui_story"]) then
					arg_130_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1019ui_story"]) and arg_130_1.var_.characterEffect1019ui_story then
				arg_130_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_133_2 = arg_130_1.actors_["1011ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1011ui_story = var_133_2.localPosition
			end

			local var_133_3 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 then
				var_133_2.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_3)
				var_133_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_2.position).x, (manager.ui.mainCamera.transform.position - var_133_2.position).y, (manager.ui.mainCamera.transform.position - var_133_2.position).z)
				var_133_2.localEulerAngles.z = 0
				var_133_2.localEulerAngles.x = 0
				var_133_2.localEulerAngles = var_133_2.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 then
				var_133_2.localPosition = Vector3.New(0, 100, 0)
				var_133_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_2.position).x, (manager.ui.mainCamera.transform.position - var_133_2.position).y, (manager.ui.mainCamera.transform.position - var_133_2.position).z)
				var_133_2.localEulerAngles.z = 0
				var_133_2.localEulerAngles.x = 0
				var_133_2.localEulerAngles = var_133_2.localEulerAngles
			end

			local var_133_4 = arg_130_1.actors_["1084ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1084ui_story = var_133_4.localPosition
			end

			local var_133_5 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_5 then
				var_133_4.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_5)
				var_133_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_4.position).x, (manager.ui.mainCamera.transform.position - var_133_4.position).y, (manager.ui.mainCamera.transform.position - var_133_4.position).z)
				var_133_4.localEulerAngles.z = 0
				var_133_4.localEulerAngles.x = 0
				var_133_4.localEulerAngles = var_133_4.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_5 and arg_130_1.time_ < 0 + var_133_5 + arg_133_0 then
				var_133_4.localPosition = Vector3.New(0, 100, 0)
				var_133_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_4.position).x, (manager.ui.mainCamera.transform.position - var_133_4.position).y, (manager.ui.mainCamera.transform.position - var_133_4.position).z)
				var_133_4.localEulerAngles.z = 0
				var_133_4.localEulerAngles.x = 0
				var_133_4.localEulerAngles = var_133_4.localEulerAngles
			end

			local var_133_6 = arg_130_1.actors_["1019ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1019ui_story = var_133_6.localPosition
			end

			local var_133_7 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				var_133_6.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_130_1.time_ - 0) / var_133_7)
				var_133_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_6.position).x, (manager.ui.mainCamera.transform.position - var_133_6.position).y, (manager.ui.mainCamera.transform.position - var_133_6.position).z)
				var_133_6.localEulerAngles.z = 0
				var_133_6.localEulerAngles.x = 0
				var_133_6.localEulerAngles = var_133_6.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				var_133_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_133_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_6.position).x, (manager.ui.mainCamera.transform.position - var_133_6.position).y, (manager.ui.mainCamera.transform.position - var_133_6.position).z)
				var_133_6.localEulerAngles.z = 0
				var_133_6.localEulerAngles.x = 0
				var_133_6.localEulerAngles = var_133_6.localEulerAngles
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_133_8 = 0
			local var_133_9 = 0.25

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_8 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_10 = arg_130_1:GetWordFromCfg(104011036)
				local var_133_11 = arg_130_1:FormatText(var_133_10.content)

				arg_130_1.text_.text = var_133_11

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_13 = 10 <= 0 and var_133_9 or var_133_9 * (utf8.len(var_133_11) / 10)

				if (10 <= 0 and var_133_9 or var_133_9 * (utf8.len(var_133_11) / 10)) > 0 and var_133_9 < var_133_13 then
					arg_130_1.talkMaxDuration = var_133_13

					if var_133_13 + var_133_8 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_13 + var_133_8
					end
				end

				arg_130_1.text_.text = var_133_11
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011036", "story_v_out_104011.awb") ~= 0 then
					local var_133_14 = manager.audio:GetVoiceLength("story_v_out_104011", "104011036", "story_v_out_104011.awb") / 1000

					if var_133_14 + var_133_8 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_14 + var_133_8
					end

					if var_133_10.prefab_name ~= "" and arg_130_1.actors_[var_133_10.prefab_name] ~= nil then
						local var_133_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_10.prefab_name].transform, "story_v_out_104011", "104011036", "story_v_out_104011.awb")

						arg_130_1:RecordAudio("104011036", var_133_15)
						arg_130_1:RecordAudio("104011036", var_133_15)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_104011", "104011036", "story_v_out_104011.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_104011", "104011036", "story_v_out_104011.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_16 = math.max(var_133_9, arg_130_1.talkMaxDuration)

			if var_133_8 <= arg_130_1.time_ and arg_130_1.time_ < var_133_8 + var_133_16 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_8) / var_133_16

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_8 + var_133_16 and arg_130_1.time_ < var_133_8 + var_133_16 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play104011037 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 104011037
		arg_134_1.duration_ = 5.03

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
			arg_134_1.auto_ = false
		end

		function arg_134_1.playNext_(arg_136_0)
			arg_134_1.onStoryFinished_()
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1019ui_story"]) and arg_134_1.var_.characterEffect1019ui_story == nil then
				arg_134_1.var_.characterEffect1019ui_story = arg_134_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1019ui_story"]) then
				if arg_134_1.var_.characterEffect1019ui_story and not isNil(arg_134_1.actors_["1019ui_story"]) then
					arg_134_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1019ui_story"]) and arg_134_1.var_.characterEffect1019ui_story then
				arg_134_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0x0.0000000000001p-1022

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(104011037).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 7 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 7)

				if (7 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 7)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end

			local var_137_7 = 0.025
			local var_137_8 = 0.175

			if 0.025 < arg_134_1.time_ and arg_134_1.time_ <= var_137_7 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_9 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(104011037).content)

				arg_134_1.text_.text = var_137_9

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 7 <= 0 and var_137_8 or var_137_8 * (utf8.len(var_137_9) / 7)

				if (7 <= 0 and var_137_8 or var_137_8 * (utf8.len(var_137_9) / 7)) > 0 and var_137_8 < var_137_11 then
					arg_134_1.talkMaxDuration = var_137_11

					if var_137_11 + var_137_7 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_11 + var_137_7
					end
				end

				arg_134_1.text_.text = var_137_9
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_8, arg_134_1.talkMaxDuration)

			if var_137_7 <= arg_134_1.time_ and arg_134_1.time_ < var_137_7 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_7) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_7 + var_137_12 and arg_134_1.time_ < var_137_7 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play104011029 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 104011029
		arg_138_1.duration_ = 2.13

		local var_138_0 = {
			ja = 1.999999999999,
			ko = 2,
			zh = 2.133,
			en = 1.999999999999
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
				arg_138_0:Play104011030(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1036ui_story"]) and arg_138_1.var_.characterEffect1036ui_story == nil then
				arg_138_1.var_.characterEffect1036ui_story = arg_138_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1036ui_story"]) then
				if arg_138_1.var_.characterEffect1036ui_story and not isNil(arg_138_1.actors_["1036ui_story"]) then
					arg_138_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1036ui_story"]) and arg_138_1.var_.characterEffect1036ui_story then
				arg_138_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_141_2 = "1036ui_story"

			if arg_138_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_141_3 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_138_1.stage_.transform)

				var_141_3.name = var_141_2
				var_141_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_[var_141_2] = var_141_3

				local var_141_4 = var_141_3:GetComponentInChildren(typeof(CharacterEffect))

				var_141_4.enabled = true

				local var_141_5 = GameObjectTools.GetOrAddComponent(var_141_3, typeof(DynamicBoneHelper))

				if var_141_5 then
					var_141_5:EnableDynamicBone(false)
				end

				arg_138_1:ShowWeapon(var_141_4.transform, false)

				arg_138_1.var_[var_141_2 .. "Animator"] = var_141_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_138_1.var_[var_141_2 .. "Animator"].applyRootMotion = true
				arg_138_1.var_[var_141_2 .. "LipSync"] = var_141_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action442")
			end

			local var_141_6 = "1036ui_story"

			if arg_138_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_141_7 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_138_1.stage_.transform)

				var_141_7.name = var_141_6
				var_141_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_[var_141_6] = var_141_7

				local var_141_8 = var_141_7:GetComponentInChildren(typeof(CharacterEffect))

				var_141_8.enabled = true

				local var_141_9 = GameObjectTools.GetOrAddComponent(var_141_7, typeof(DynamicBoneHelper))

				if var_141_9 then
					var_141_9:EnableDynamicBone(false)
				end

				arg_138_1:ShowWeapon(var_141_8.transform, false)

				arg_138_1.var_[var_141_6 .. "Animator"] = var_141_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_138_1.var_[var_141_6 .. "Animator"].applyRootMotion = true
				arg_138_1.var_[var_141_6 .. "LipSync"] = var_141_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_10 = 0
			local var_141_11 = 0.25

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_12 = arg_138_1:GetWordFromCfg(104011029)
				local var_141_13 = arg_138_1:FormatText(var_141_12.content)

				arg_138_1.text_.text = var_141_13

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_15 = 10 <= 0 and var_141_11 or var_141_11 * (utf8.len(var_141_13) / 10)

				if (10 <= 0 and var_141_11 or var_141_11 * (utf8.len(var_141_13) / 10)) > 0 and var_141_11 < var_141_15 then
					arg_138_1.talkMaxDuration = var_141_15

					if var_141_15 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_15 + var_141_10
					end
				end

				arg_138_1.text_.text = var_141_13
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011029", "story_v_out_104011.awb") ~= 0 then
					local var_141_16 = manager.audio:GetVoiceLength("story_v_out_104011", "104011029", "story_v_out_104011.awb") / 1000

					if var_141_16 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_16 + var_141_10
					end

					if var_141_12.prefab_name ~= "" and arg_138_1.actors_[var_141_12.prefab_name] ~= nil then
						local var_141_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_12.prefab_name].transform, "story_v_out_104011", "104011029", "story_v_out_104011.awb")

						arg_138_1:RecordAudio("104011029", var_141_17)
						arg_138_1:RecordAudio("104011029", var_141_17)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_104011", "104011029", "story_v_out_104011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_104011", "104011029", "story_v_out_104011.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_18 = math.max(var_141_11, arg_138_1.talkMaxDuration)

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_18 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_10) / var_141_18

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_10 + var_141_18 and arg_138_1.time_ < var_141_10 + var_141_18 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play104011030 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 104011030
		arg_142_1.duration_ = 7.8

		local var_142_0 = {
			ja = 7.8,
			ko = 5.5,
			zh = 6.033,
			en = 6.766
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
				arg_142_0:Play104011031(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_145_0 = 0
			local var_145_1 = 0.875

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(104011030)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 35 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 35)

				if (35 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 35)) > 0 and var_145_1 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011030", "story_v_out_104011.awb") ~= 0 then
					local var_145_6 = manager.audio:GetVoiceLength("story_v_out_104011", "104011030", "story_v_out_104011.awb") / 1000

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end

					if var_145_2.prefab_name ~= "" and arg_142_1.actors_[var_145_2.prefab_name] ~= nil then
						local var_145_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_2.prefab_name].transform, "story_v_out_104011", "104011030", "story_v_out_104011.awb")

						arg_142_1:RecordAudio("104011030", var_145_7)
						arg_142_1:RecordAudio("104011030", var_145_7)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_104011", "104011030", "story_v_out_104011.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_104011", "104011030", "story_v_out_104011.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play104011031 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 104011031
		arg_146_1.duration_ = 2.8

		local var_146_0 = {
			ja = 2.8,
			ko = 2.8,
			zh = 2.6,
			en = 2.633
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
				arg_146_0:Play104011032(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = arg_146_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.1

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) then
				if arg_146_1.var_.characterEffect1084ui_story and not isNil(arg_146_1.actors_["1084ui_story"]) then
					arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1084ui_story"]) and arg_146_1.var_.characterEffect1084ui_story then
				arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_149_2 = arg_146_1.actors_["1036ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1036ui_story = var_149_2.localPosition
			end

			local var_149_3 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 then
				var_149_2.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_3)
				var_149_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_2.position).x, (manager.ui.mainCamera.transform.position - var_149_2.position).y, (manager.ui.mainCamera.transform.position - var_149_2.position).z)
				var_149_2.localEulerAngles.z = 0
				var_149_2.localEulerAngles.x = 0
				var_149_2.localEulerAngles = var_149_2.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 then
				var_149_2.localPosition = Vector3.New(0, 100, 0)
				var_149_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_2.position).x, (manager.ui.mainCamera.transform.position - var_149_2.position).y, (manager.ui.mainCamera.transform.position - var_149_2.position).z)
				var_149_2.localEulerAngles.z = 0
				var_149_2.localEulerAngles.x = 0
				var_149_2.localEulerAngles = var_149_2.localEulerAngles
			end

			local var_149_4 = arg_146_1.actors_["1084ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_4.localPosition
			end

			local var_149_5 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_5 then
				var_149_4.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_146_1.time_ - 0) / var_149_5)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_5 and arg_146_1.time_ < 0 + var_149_5 + arg_149_0 then
				var_149_4.localPosition = Vector3.New(0, -0.97, -6)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_149_6 = 0
			local var_149_7 = 0.175

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:GetWordFromCfg(104011031)
				local var_149_9 = arg_146_1:FormatText(var_149_8.content)

				arg_146_1.text_.text = var_149_9

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 7 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_9) / 7)

				if (7 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_9) / 7)) > 0 and var_149_7 < var_149_11 then
					arg_146_1.talkMaxDuration = var_149_11

					if var_149_11 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_11 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_9
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011031", "story_v_out_104011.awb") ~= 0 then
					local var_149_12 = manager.audio:GetVoiceLength("story_v_out_104011", "104011031", "story_v_out_104011.awb") / 1000

					if var_149_12 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_12 + var_149_6
					end

					if var_149_8.prefab_name ~= "" and arg_146_1.actors_[var_149_8.prefab_name] ~= nil then
						local var_149_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_8.prefab_name].transform, "story_v_out_104011", "104011031", "story_v_out_104011.awb")

						arg_146_1:RecordAudio("104011031", var_149_13)
						arg_146_1:RecordAudio("104011031", var_149_13)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_104011", "104011031", "story_v_out_104011.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_104011", "104011031", "story_v_out_104011.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_14 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_14 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_14

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_14 and arg_146_1.time_ < var_149_6 + var_149_14 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_146_1:InitPlayNodeList()
	end,
	Play104011032 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 104011032
		arg_150_1.duration_ = 4.4

		local var_150_0 = {
			ja = 4.4,
			ko = 2.566,
			zh = 3.833,
			en = 2.833
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
				arg_150_0:Play104011033(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1036ui_story"]) and arg_150_1.var_.characterEffect1036ui_story == nil then
				arg_150_1.var_.characterEffect1036ui_story = arg_150_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1036ui_story"]) then
				if arg_150_1.var_.characterEffect1036ui_story and not isNil(arg_150_1.actors_["1036ui_story"]) then
					arg_150_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1036ui_story"]) and arg_150_1.var_.characterEffect1036ui_story then
				arg_150_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_153_2 = arg_150_1.actors_["1084ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1084ui_story == nil then
				arg_150_1.var_.characterEffect1084ui_story = var_153_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_3 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.characterEffect1084ui_story and not isNil(var_153_2) then
					arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_3)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1084ui_story then
				arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_153_4 = arg_150_1.actors_["1084ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1084ui_story = var_153_4.localPosition
			end

			local var_153_5 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_5 then
				var_153_4.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_5)
				var_153_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_4.position).x, (manager.ui.mainCamera.transform.position - var_153_4.position).y, (manager.ui.mainCamera.transform.position - var_153_4.position).z)
				var_153_4.localEulerAngles.z = 0
				var_153_4.localEulerAngles.x = 0
				var_153_4.localEulerAngles = var_153_4.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_5 and arg_150_1.time_ < 0 + var_153_5 + arg_153_0 then
				var_153_4.localPosition = Vector3.New(0, 100, 0)
				var_153_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_4.position).x, (manager.ui.mainCamera.transform.position - var_153_4.position).y, (manager.ui.mainCamera.transform.position - var_153_4.position).z)
				var_153_4.localEulerAngles.z = 0
				var_153_4.localEulerAngles.x = 0
				var_153_4.localEulerAngles = var_153_4.localEulerAngles
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_153_6 = arg_150_1.actors_["1036ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1036ui_story = var_153_6.localPosition
			end

			local var_153_7 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				var_153_6.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_150_1.time_ - 0) / var_153_7)
				var_153_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_6.position).x, (manager.ui.mainCamera.transform.position - var_153_6.position).y, (manager.ui.mainCamera.transform.position - var_153_6.position).z)
				var_153_6.localEulerAngles.z = 0
				var_153_6.localEulerAngles.x = 0
				var_153_6.localEulerAngles = var_153_6.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				var_153_6.localPosition = Vector3.New(0, -1.09, -5.78)
				var_153_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_6.position).x, (manager.ui.mainCamera.transform.position - var_153_6.position).y, (manager.ui.mainCamera.transform.position - var_153_6.position).z)
				var_153_6.localEulerAngles.z = 0
				var_153_6.localEulerAngles.x = 0
				var_153_6.localEulerAngles = var_153_6.localEulerAngles
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_153_8 = 0
			local var_153_9 = 0.475

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_10 = arg_150_1:GetWordFromCfg(104011032)
				local var_153_11 = arg_150_1:FormatText(var_153_10.content)

				arg_150_1.text_.text = var_153_11

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_13 = 16 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 16)

				if (16 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 16)) > 0 and var_153_9 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_8
					end
				end

				arg_150_1.text_.text = var_153_11
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104011", "104011032", "story_v_out_104011.awb") ~= 0 then
					local var_153_14 = manager.audio:GetVoiceLength("story_v_out_104011", "104011032", "story_v_out_104011.awb") / 1000

					if var_153_14 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_8
					end

					if var_153_10.prefab_name ~= "" and arg_150_1.actors_[var_153_10.prefab_name] ~= nil then
						local var_153_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_10.prefab_name].transform, "story_v_out_104011", "104011032", "story_v_out_104011.awb")

						arg_150_1:RecordAudio("104011032", var_153_15)
						arg_150_1:RecordAudio("104011032", var_153_15)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_104011", "104011032", "story_v_out_104011.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_104011", "104011032", "story_v_out_104011.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_9, arg_150_1.talkMaxDuration)

			if var_153_8 <= arg_150_1.time_ and arg_150_1.time_ < var_153_8 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_8) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_8 + var_153_16 and arg_150_1.time_ < var_153_8 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0103",
		"TextureConfig/Background/B03d"
	},
	voices = {
		"story_v_out_104011.awb"
	}
}
