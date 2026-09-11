return {
	Play105121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105121001
		arg_1_1.duration_ = 12.67

		local var_1_0 = {
			ja = 12.666,
			ko = 7.9,
			zh = 9.966,
			en = 12.2
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
				arg_1_0:Play105121002(arg_1_1)
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v0_environment_source", "se_story_v0_environment_source", "se_story_v0_environment_source")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_5", "se_story_5_steamloop", "")
			end

			local var_4_5 = "B12a"

			if arg_1_1.bgs_.B12a == nil then
				local var_4_6 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_5)
				var_4_6.name = var_4_5
				var_4_6.transform.parent = arg_1_1.stage_.transform
				var_4_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_5] = var_4_6
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.B12a:GetComponent("SpriteRenderer")

				if var_4_7 then
					arg_1_1.var_.alphaOldValueB12a = var_4_7.color.a
					arg_1_1.var_.alphaMatValueB12a = var_4_7
				end

				arg_1_1.var_.alphaOldValueB12a = 0
			end

			local var_4_8 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_8 then
				if arg_1_1.var_.alphaMatValueB12a then
					arg_1_1.var_.alphaMatValueB12a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB12a, 1, (arg_1_1.time_ - 0) / var_4_8)
					arg_1_1.var_.alphaMatValueB12a.color = arg_1_1.var_.alphaMatValueB12a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_8 and arg_1_1.time_ < 0 + var_4_8 + arg_4_0 and arg_1_1.var_.alphaMatValueB12a then
				arg_1_1.var_.alphaMatValueB12a.color.a = 1
				arg_1_1.var_.alphaMatValueB12a.color = arg_1_1.var_.alphaMatValueB12a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_9 = arg_1_1.bgs_.B12a

				arg_1_1.bgs_.B12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_10 = var_4_9:GetComponent("SpriteRenderer")

				if var_4_10 and var_4_10.sprite then
					local var_4_11 = 2 * (var_4_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_9.transform.localScale = Vector3.New(var_4_11 / var_4_10.sprite.bounds.size.y < var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x and var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x or var_4_11 / var_4_10.sprite.bounds.size.y, var_4_11 / var_4_10.sprite.bounds.size.y < var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x and var_4_11 * manager.ui.mainCameraCom_.aspect / var_4_10.sprite.bounds.size.x or var_4_11 / var_4_10.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B12a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_12 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_12 + 2 and arg_1_1.time_ < var_4_12 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.65

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(105121001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 25 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 25)

				if (25 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 25)) > 0 and var_4_14 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_13 = var_4_13 + 0.3

					if var_4_19 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121001", "story_v_out_105121.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121001", "story_v_out_105121.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_105121", "105121001", "story_v_out_105121.awb")

						arg_1_1:RecordAudio("105121001", var_4_21)
						arg_1_1:RecordAudio("105121001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_105121", "105121001", "story_v_out_105121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_105121", "105121001", "story_v_out_105121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_13 + 0.3
			local var_4_23 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play105121002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105121002
		arg_8_1.duration_ = 1.27

		local var_8_0 = {
			ja = 1.133,
			ko = 1.166,
			zh = 1.266,
			en = 1.266
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play105121003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(105121002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 5 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 5)

				if (5 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 5)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121002", "story_v_out_105121.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121002", "story_v_out_105121.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_105121", "105121002", "story_v_out_105121.awb")

						arg_8_1:RecordAudio("105121002", var_11_6)
						arg_8_1:RecordAudio("105121002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_105121", "105121002", "story_v_out_105121.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_105121", "105121002", "story_v_out_105121.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play105121003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105121003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play105121004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_5", "se_story_5_bossarrow", "")
			end

			local var_15_1 = manager.ui.mainCamera.transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.shakeOldPos = var_15_1.localPosition
			end

			local var_15_2 = 0.6

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_2 then
				local var_15_3, var_15_4 = math.modf((arg_12_1.time_ - 0) / 0.066)

				var_15_1.localPosition = Vector3.New(var_15_4 * 0.13, var_15_4 * 0.13, var_15_4 * 0.13) + arg_12_1.var_.shakeOldPos
			end

			if arg_12_1.time_ >= 0 + var_15_2 and arg_12_1.time_ < 0 + var_15_2 + arg_15_0 then
				var_15_1.localPosition = arg_12_1.var_.shakeOldPos
			end

			local var_15_5 = 0
			local var_15_6 = 1.225

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_7 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(105121003).content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 49 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_7) / 49)

				if (49 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_7) / 49)) > 0 and var_15_6 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_5 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_5
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_6, arg_12_1.talkMaxDuration)

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_5) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_5 + var_15_10 and arg_12_1.time_ < var_15_5 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play105121004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105121004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play105121005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.275

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(105121004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 51 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 51)

				if (51 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 51)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play105121005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105121005
		arg_20_1.duration_ = 16.08

		local var_20_0 = {
			ja = 16.083,
			ko = 5.95,
			zh = 8.95,
			en = 14.75
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
				arg_20_0:Play105121006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0.25 < arg_20_1.time_ and arg_20_1.time_ <= 0.25 + arg_23_0 then
				arg_20_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_23_0 = 0.6

			if 0.25 <= arg_20_1.time_ and arg_20_1.time_ < 0.25 + var_23_0 then
				local var_23_1, var_23_2 = math.modf((arg_20_1.time_ - 0.25) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_23_2 * 0.13, var_23_2 * 0.13, var_23_2 * 0.13) + arg_20_1.var_.shakeOldPos
			end

			if arg_20_1.time_ >= 0.25 + var_23_0 and arg_20_1.time_ < 0.25 + var_23_0 + arg_23_0 then
				manager.ui.mainCamera.transform.localPosition = arg_20_1.var_.shakeOldPos
			end

			local var_23_3 = 0.25
			local var_23_4 = 0.75

			if 0.25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_5 = arg_20_1:GetWordFromCfg(105121005)
				local var_23_6 = arg_20_1:FormatText(var_23_5.content)

				arg_20_1.text_.text = var_23_6

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_8 = 30 <= 0 and var_23_4 or var_23_4 * (utf8.len(var_23_6) / 30)

				if (30 <= 0 and var_23_4 or var_23_4 * (utf8.len(var_23_6) / 30)) > 0 and var_23_4 < var_23_8 then
					arg_20_1.talkMaxDuration = var_23_8

					if var_23_8 + var_23_3 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_3
					end
				end

				arg_20_1.text_.text = var_23_6
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121005", "story_v_out_105121.awb") ~= 0 then
					local var_23_9 = manager.audio:GetVoiceLength("story_v_out_105121", "105121005", "story_v_out_105121.awb") / 1000

					if var_23_9 + var_23_3 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_3
					end

					if var_23_5.prefab_name ~= "" and arg_20_1.actors_[var_23_5.prefab_name] ~= nil then
						local var_23_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_5.prefab_name].transform, "story_v_out_105121", "105121005", "story_v_out_105121.awb")

						arg_20_1:RecordAudio("105121005", var_23_10)
						arg_20_1:RecordAudio("105121005", var_23_10)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_105121", "105121005", "story_v_out_105121.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_105121", "105121005", "story_v_out_105121.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_11 = math.max(var_23_4, arg_20_1.talkMaxDuration)

			if var_23_3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_3 + var_23_11 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_3) / var_23_11

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_3 + var_23_11 and arg_20_1.time_ < var_23_3 + var_23_11 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play105121006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105121006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play105121007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "1019ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1019ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["1019ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["1019ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["1019ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_27_6 = arg_24_1.actors_["1019ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_6.localPosition
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_6.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_24_1.time_ - 0) / var_27_7)
				var_27_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_6.position).x, (manager.ui.mainCamera.transform.position - var_27_6.position).y, (manager.ui.mainCamera.transform.position - var_27_6.position).z)
				var_27_6.localEulerAngles.z = 0
				var_27_6.localEulerAngles.x = 0
				var_27_6.localEulerAngles = var_27_6.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				var_27_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_27_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_6.position).x, (manager.ui.mainCamera.transform.position - var_27_6.position).y, (manager.ui.mainCamera.transform.position - var_27_6.position).z)
				var_27_6.localEulerAngles.z = 0
				var_27_6.localEulerAngles.x = 0
				var_27_6.localEulerAngles = var_27_6.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_27_8 = 0
			local var_27_9 = 0.175

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_10 = arg_24_1:GetWordFromCfg(105121006)
				local var_27_11 = arg_24_1:FormatText(var_27_10.content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 7 <= 0 and var_27_9 or var_27_9 * (utf8.len(var_27_11) / 7)

				if (7 <= 0 and var_27_9 or var_27_9 * (utf8.len(var_27_11) / 7)) > 0 and var_27_9 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_8
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121006", "story_v_out_105121.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121006", "story_v_out_105121.awb") / 1000

					if var_27_14 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_8
					end

					if var_27_10.prefab_name ~= "" and arg_24_1.actors_[var_27_10.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_10.prefab_name].transform, "story_v_out_105121", "105121006", "story_v_out_105121.awb")

						arg_24_1:RecordAudio("105121006", var_27_15)
						arg_24_1:RecordAudio("105121006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_105121", "105121006", "story_v_out_105121.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_105121", "105121006", "story_v_out_105121.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_9, arg_24_1.talkMaxDuration)

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_8) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_8 + var_27_16 and arg_24_1.time_ < var_27_8 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play105121007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105121007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play105121008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1084ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1084ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1084ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1084ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1084ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_6 = arg_28_1.actors_["1019ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 and not isNil(var_31_6) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_6) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_7)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_31_8 = arg_28_1.actors_["1084ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_8.localPosition

				arg_28_1:ShowWeapon(arg_28_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_31_9 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_28_1.time_ - 0) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(0.7, -0.97, -6)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_31_10 = 0
			local var_31_11 = 0.125

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(105121007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 5 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 5)

				if (5 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 5)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121007", "story_v_out_105121.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_105121", "105121007", "story_v_out_105121.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_105121", "105121007", "story_v_out_105121.awb")

						arg_28_1:RecordAudio("105121007", var_31_17)
						arg_28_1:RecordAudio("105121007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_105121", "105121007", "story_v_out_105121.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_105121", "105121007", "story_v_out_105121.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play105121008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105121008
		arg_32_1.duration_ = 5.6

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play105121009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_5", "se_story_5_bosscollapse", "")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_5", "se_story_5_bossflee", "")
			end

			local var_35_2 = manager.ui.mainCamera.transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.shakeOldPosMainCamera = var_35_2.localPosition
			end

			local var_35_3 = 0.600000023841858

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 then
				local var_35_4, var_35_5 = math.modf((arg_32_1.time_ - 0) / 0.066)

				var_35_2.localPosition = Vector3.New(var_35_5 * 0.13, var_35_5 * 0.13, var_35_5 * 0.13) + arg_32_1.var_.shakeOldPosMainCamera
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 then
				var_35_2.localPosition = arg_32_1.var_.shakeOldPosMainCamera
			end

			local var_35_6 = arg_32_1.actors_["1019ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_6.localPosition
			end

			local var_35_7 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				var_35_6.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_7)
				var_35_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_6.position).x, (manager.ui.mainCamera.transform.position - var_35_6.position).y, (manager.ui.mainCamera.transform.position - var_35_6.position).z)
				var_35_6.localEulerAngles.z = 0
				var_35_6.localEulerAngles.x = 0
				var_35_6.localEulerAngles = var_35_6.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				var_35_6.localPosition = Vector3.New(0, 100, 0)
				var_35_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_6.position).x, (manager.ui.mainCamera.transform.position - var_35_6.position).y, (manager.ui.mainCamera.transform.position - var_35_6.position).z)
				var_35_6.localEulerAngles.z = 0
				var_35_6.localEulerAngles.x = 0
				var_35_6.localEulerAngles = var_35_6.localEulerAngles
			end

			local var_35_8 = arg_32_1.actors_["1084ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_8.localPosition

				arg_32_1:ShowWeapon(arg_32_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_35_9 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0, 100, 0)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			local var_35_10 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_11 = 0.5

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 then
				local var_35_12 = Color.New(1, 1, 1)

				var_35_12.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_10) / var_35_11)
				arg_32_1.mask_.color = var_35_12
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 then
				local var_35_13 = Color.New(1, 1, 1)

				arg_32_1.mask_.enabled = false
				var_35_13.a = 0
				arg_32_1.mask_.color = var_35_13
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_14 = 0.600000023841858
			local var_35_15 = 0.65

			if 0.600000023841858 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_16 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_16:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_17 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(105121008).content)

				arg_32_1.text_.text = var_35_17

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_19 = 26 <= 0 and var_35_15 or var_35_15 * (utf8.len(var_35_17) / 26)

				if (26 <= 0 and var_35_15 or var_35_15 * (utf8.len(var_35_17) / 26)) > 0 and var_35_15 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19
					var_35_14 = var_35_14 + 0.3

					if var_35_19 + var_35_14 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_14
					end
				end

				arg_32_1.text_.text = var_35_17
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = var_35_14 + 0.3
			local var_35_21 = math.max(var_35_15, arg_32_1.talkMaxDuration)

			if var_35_14 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_21 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_20) / var_35_21

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_20 + var_35_21 and arg_32_1.time_ < var_35_20 + var_35_21 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play105121009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 105121009
		arg_38_1.duration_ = 6

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play105121010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = false

				arg_38_1:SetGaussion(false)
			end

			local var_41_0 = 1

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 then
				local var_41_1 = Color.New(1, 1, 1)

				var_41_1.a = Mathf.Lerp(0, 1, (arg_38_1.time_ - 0) / var_41_0)
				arg_38_1.mask_.color = var_41_1
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 then
				local var_41_2 = Color.New(1, 1, 1)

				var_41_2.a = 1
				arg_38_1.mask_.color = var_41_2
			end

			local var_41_3 = 1

			if 1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = false

				arg_38_1:SetGaussion(false)
			end

			local var_41_4 = 1

			if var_41_3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_3 + var_41_4 then
				local var_41_5 = Color.New(1, 1, 1)

				var_41_5.a = Mathf.Lerp(1, 0, (arg_38_1.time_ - var_41_3) / var_41_4)
				arg_38_1.mask_.color = var_41_5
			end

			if arg_38_1.time_ >= var_41_3 + var_41_4 and arg_38_1.time_ < var_41_3 + var_41_4 + arg_41_0 then
				local var_41_6 = Color.New(1, 1, 1)

				arg_38_1.mask_.enabled = false
				var_41_6.a = 0
				arg_38_1.mask_.color = var_41_6
			end

			local var_41_7 = "S0505"

			if arg_38_1.bgs_.S0505 == nil then
				local var_41_8 = Object.Instantiate(arg_38_1.paintGo_)

				var_41_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_41_7)
				var_41_8.name = var_41_7
				var_41_8.transform.parent = arg_38_1.stage_.transform
				var_41_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.bgs_[var_41_7] = var_41_8
			end

			if 1 < arg_38_1.time_ and arg_38_1.time_ <= 1 + arg_41_0 then
				local var_41_9 = arg_38_1.bgs_.S0505

				arg_38_1.bgs_.S0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_41_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_10 = var_41_9:GetComponent("SpriteRenderer")

				if var_41_10 and var_41_10.sprite then
					local var_41_11 = 2 * (var_41_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_41_9.transform.localScale = Vector3.New(var_41_11 / var_41_10.sprite.bounds.size.y < var_41_11 * manager.ui.mainCameraCom_.aspect / var_41_10.sprite.bounds.size.x and var_41_11 * manager.ui.mainCameraCom_.aspect / var_41_10.sprite.bounds.size.x or var_41_11 / var_41_10.sprite.bounds.size.y, var_41_11 / var_41_10.sprite.bounds.size.y < var_41_11 * manager.ui.mainCameraCom_.aspect / var_41_10.sprite.bounds.size.x and var_41_11 * manager.ui.mainCameraCom_.aspect / var_41_10.sprite.bounds.size.x or var_41_11 / var_41_10.sprite.bounds.size.y, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "S0505" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_12 = 1
			local var_41_13 = 1.55

			if 1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_12 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_14 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_14:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_38_1.dialogCg_.alpha = arg_42_0
				end))
				var_41_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_15 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(105121009).content)

				arg_38_1.text_.text = var_41_15

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_17 = 62 <= 0 and var_41_13 or var_41_13 * (utf8.len(var_41_15) / 62)

				if (62 <= 0 and var_41_13 or var_41_13 * (utf8.len(var_41_15) / 62)) > 0 and var_41_13 < var_41_17 then
					arg_38_1.talkMaxDuration = var_41_17
					var_41_12 = var_41_12 + 0.3

					if var_41_17 + var_41_12 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_17 + var_41_12
					end
				end

				arg_38_1.text_.text = var_41_15
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_18 = var_41_12 + 0.3
			local var_41_19 = math.max(var_41_13, arg_38_1.talkMaxDuration)

			if var_41_12 + 0.3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_18 + var_41_19 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_18) / var_41_19

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_18 + var_41_19 and arg_38_1.time_ < var_41_18 + var_41_19 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play105121010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 105121010
		arg_44_1.duration_ = 10.67

		local var_44_0 = {
			ja = 10.666,
			ko = 5.5,
			zh = 8.133,
			en = 9.466
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
				arg_44_0:Play105121011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.575

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(105121010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 23 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 23)

				if (23 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 23)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121010", "story_v_out_105121.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121010", "story_v_out_105121.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_105121", "105121010", "story_v_out_105121.awb")

						arg_44_1:RecordAudio("105121010", var_47_6)
						arg_44_1:RecordAudio("105121010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_105121", "105121010", "story_v_out_105121.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_105121", "105121010", "story_v_out_105121.awb")
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
	Play105121011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 105121011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play105121012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:AudioAction("play", "effect", "se_story_5", "se_story_5_spear", "")
			end

			local var_51_1 = 0
			local var_51_2 = 1.925

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(105121011).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 77 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 77)

				if (77 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 77)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play105121012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 105121012
		arg_52_1.duration_ = 10.5

		local var_52_0 = {
			ja = 9,
			ko = 5,
			zh = 9.433,
			en = 10.5
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
				arg_52_0:Play105121013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_0 = 0.5

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				local var_55_1 = Color.New(1, 1, 1)

				var_55_1.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.mask_.color = var_55_1
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				local var_55_2 = Color.New(1, 1, 1)

				arg_52_1.mask_.enabled = false
				var_55_2.a = 0
				arg_52_1.mask_.color = var_55_2
			end

			local var_55_3 = manager.ui.mainCamera.transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.shakeOldPosMainCamera = var_55_3.localPosition
			end

			local var_55_4 = 0.600000023841858

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				local var_55_5, var_55_6 = math.modf((arg_52_1.time_ - 0) / 0.066)

				var_55_3.localPosition = Vector3.New(var_55_6 * 0.13, var_55_6 * 0.13, var_55_6 * 0.13) + arg_52_1.var_.shakeOldPosMainCamera
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				var_55_3.localPosition = arg_52_1.var_.shakeOldPosMainCamera
			end

			local var_55_7 = 0.5
			local var_55_8 = 0.4

			if 0.5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(105121012)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_12 = 16 <= 0 and var_55_8 or var_55_8 * (utf8.len(var_55_10) / 16)

				if (16 <= 0 and var_55_8 or var_55_8 * (utf8.len(var_55_10) / 16)) > 0 and var_55_8 < var_55_12 then
					arg_52_1.talkMaxDuration = var_55_12

					if var_55_12 + var_55_7 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_7
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121012", "story_v_out_105121.awb") ~= 0 then
					local var_55_13 = manager.audio:GetVoiceLength("story_v_out_105121", "105121012", "story_v_out_105121.awb") / 1000

					if var_55_13 + var_55_7 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_7
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_105121", "105121012", "story_v_out_105121.awb")

						arg_52_1:RecordAudio("105121012", var_55_14)
						arg_52_1:RecordAudio("105121012", var_55_14)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_105121", "105121012", "story_v_out_105121.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_105121", "105121012", "story_v_out_105121.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_15 = math.max(var_55_8, arg_52_1.talkMaxDuration)

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_15 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_7) / var_55_15

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_7 + var_55_15 and arg_52_1.time_ < var_55_7 + var_55_15 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play105121013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 105121013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play105121014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story_5", "se_story_5_sword", "")
			end

			local var_59_1 = 0
			local var_59_2 = 1.875

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(105121013).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 75 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 75)

				if (75 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 75)) > 0 and var_59_2 < var_59_5 then
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
	Play105121014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 105121014
		arg_60_1.duration_ = 3.97

		local var_60_0 = {
			ja = 3.166,
			ko = 3.3,
			zh = 3.1,
			en = 3.966
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play105121015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0.375 < arg_60_1.time_ and arg_60_1.time_ <= 0.375 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_0 = 0.5

			if 0.375 <= arg_60_1.time_ and arg_60_1.time_ < 0.375 + var_63_0 then
				local var_63_1 = Color.New(1, 1, 1)

				var_63_1.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - 0.375) / var_63_0)
				arg_60_1.mask_.color = var_63_1
			end

			if arg_60_1.time_ >= 0.375 + var_63_0 and arg_60_1.time_ < 0.375 + var_63_0 + arg_63_0 then
				local var_63_2 = Color.New(1, 1, 1)

				arg_60_1.mask_.enabled = false
				var_63_2.a = 0
				arg_60_1.mask_.color = var_63_2
			end

			local var_63_3 = manager.ui.mainCamera.transform

			if 0.375 < arg_60_1.time_ and arg_60_1.time_ <= 0.375 + arg_63_0 then
				arg_60_1.var_.shakeOldPosMainCamera = var_63_3.localPosition
			end

			local var_63_4 = 0.600000023841858

			if 0.375 <= arg_60_1.time_ and arg_60_1.time_ < 0.375 + var_63_4 then
				local var_63_5, var_63_6 = math.modf((arg_60_1.time_ - 0.375) / 0.066)

				var_63_3.localPosition = Vector3.New(var_63_6 * 0.13, var_63_6 * 0.13, var_63_6 * 0.13) + arg_60_1.var_.shakeOldPosMainCamera
			end

			if arg_60_1.time_ >= 0.375 + var_63_4 and arg_60_1.time_ < 0.375 + var_63_4 + arg_63_0 then
				var_63_3.localPosition = arg_60_1.var_.shakeOldPosMainCamera
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_63_7 = 0
			local var_63_8 = 0.375

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_9 = arg_60_1:GetWordFromCfg(105121014)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_12 = 15 <= 0 and var_63_8 or var_63_8 * (utf8.len(var_63_10) / 15)

				if (15 <= 0 and var_63_8 or var_63_8 * (utf8.len(var_63_10) / 15)) > 0 and var_63_8 < var_63_12 then
					arg_60_1.talkMaxDuration = var_63_12

					if var_63_12 + var_63_7 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_7
					end
				end

				arg_60_1.text_.text = var_63_10
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121014", "story_v_out_105121.awb") ~= 0 then
					local var_63_13 = manager.audio:GetVoiceLength("story_v_out_105121", "105121014", "story_v_out_105121.awb") / 1000

					if var_63_13 + var_63_7 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_7
					end

					if var_63_9.prefab_name ~= "" and arg_60_1.actors_[var_63_9.prefab_name] ~= nil then
						local var_63_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_9.prefab_name].transform, "story_v_out_105121", "105121014", "story_v_out_105121.awb")

						arg_60_1:RecordAudio("105121014", var_63_14)
						arg_60_1:RecordAudio("105121014", var_63_14)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_105121", "105121014", "story_v_out_105121.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_105121", "105121014", "story_v_out_105121.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_15 = math.max(var_63_8, arg_60_1.talkMaxDuration)

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_15 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_7) / var_63_15

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_7 + var_63_15 and arg_60_1.time_ < var_63_7 + var_63_15 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play105121015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 105121015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play105121016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_67_1 = 0
			local var_67_2 = 1.225

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(105121015).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 49 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 49)

				if (49 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 49)) > 0 and var_67_2 < var_67_5 then
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
	Play105121016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 105121016
		arg_68_1.duration_ = 4.4

		local var_68_0 = {
			ja = 4.4,
			ko = 3.2,
			zh = 3.333,
			en = 3.2
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play105121017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_71_0 = 0
			local var_71_1 = 0.425

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_2 = arg_68_1:GetWordFromCfg(105121016)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 17 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 17)

				if (17 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 17)) > 0 and var_71_1 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121016", "story_v_out_105121.awb") ~= 0 then
					local var_71_6 = manager.audio:GetVoiceLength("story_v_out_105121", "105121016", "story_v_out_105121.awb") / 1000

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end

					if var_71_2.prefab_name ~= "" and arg_68_1.actors_[var_71_2.prefab_name] ~= nil then
						local var_71_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_2.prefab_name].transform, "story_v_out_105121", "105121016", "story_v_out_105121.awb")

						arg_68_1:RecordAudio("105121016", var_71_7)
						arg_68_1:RecordAudio("105121016", var_71_7)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_105121", "105121016", "story_v_out_105121.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_105121", "105121016", "story_v_out_105121.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play105121017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 105121017
		arg_72_1.duration_ = 7.33

		local var_72_0 = {
			ja = 6.966,
			ko = 5.1,
			zh = 5.166,
			en = 7.333
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
				arg_72_0:Play105121018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0.575 < arg_72_1.time_ and arg_72_1.time_ <= 0.575 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_0 = 0.5

			if 0.575 <= arg_72_1.time_ and arg_72_1.time_ < 0.575 + var_75_0 then
				local var_75_1 = Color.New(1, 1, 1)

				var_75_1.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - 0.575) / var_75_0)
				arg_72_1.mask_.color = var_75_1
			end

			if arg_72_1.time_ >= 0.575 + var_75_0 and arg_72_1.time_ < 0.575 + var_75_0 + arg_75_0 then
				local var_75_2 = Color.New(1, 1, 1)

				arg_72_1.mask_.enabled = false
				var_75_2.a = 0
				arg_72_1.mask_.color = var_75_2
			end

			local var_75_3 = manager.ui.mainCamera.transform

			if 0.575 < arg_72_1.time_ and arg_72_1.time_ <= 0.575 + arg_75_0 then
				arg_72_1.var_.shakeOldPosMainCamera = var_75_3.localPosition
			end

			local var_75_4 = 0.600000023841858

			if 0.575 <= arg_72_1.time_ and arg_72_1.time_ < 0.575 + var_75_4 then
				local var_75_5, var_75_6 = math.modf((arg_72_1.time_ - 0.575) / 0.066)

				var_75_3.localPosition = Vector3.New(var_75_6 * 0.13, var_75_6 * 0.13, var_75_6 * 0.13) + arg_72_1.var_.shakeOldPosMainCamera
			end

			if arg_72_1.time_ >= 0.575 + var_75_4 and arg_72_1.time_ < 0.575 + var_75_4 + arg_75_0 then
				var_75_3.localPosition = arg_72_1.var_.shakeOldPosMainCamera
			end

			local var_75_7 = 0
			local var_75_8 = 0.575

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(105121017)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_12 = 23 <= 0 and var_75_8 or var_75_8 * (utf8.len(var_75_10) / 23)

				if (23 <= 0 and var_75_8 or var_75_8 * (utf8.len(var_75_10) / 23)) > 0 and var_75_8 < var_75_12 then
					arg_72_1.talkMaxDuration = var_75_12

					if var_75_12 + var_75_7 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_7
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121017", "story_v_out_105121.awb") ~= 0 then
					local var_75_13 = manager.audio:GetVoiceLength("story_v_out_105121", "105121017", "story_v_out_105121.awb") / 1000

					if var_75_13 + var_75_7 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_7
					end

					if var_75_9.prefab_name ~= "" and arg_72_1.actors_[var_75_9.prefab_name] ~= nil then
						local var_75_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_9.prefab_name].transform, "story_v_out_105121", "105121017", "story_v_out_105121.awb")

						arg_72_1:RecordAudio("105121017", var_75_14)
						arg_72_1:RecordAudio("105121017", var_75_14)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_105121", "105121017", "story_v_out_105121.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_105121", "105121017", "story_v_out_105121.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_15 = math.max(var_75_8, arg_72_1.talkMaxDuration)

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_15 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_7) / var_75_15

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_7 + var_75_15 and arg_72_1.time_ < var_75_7 + var_75_15 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play105121018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 105121018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play105121019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_5", "se_story_5_lastcharge", "")
			end

			local var_79_1 = 0
			local var_79_2 = 0.4

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(105121018).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 16 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 16)

				if (16 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 16)) > 0 and var_79_2 < var_79_5 then
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
	Play105121019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 105121019
		arg_80_1.duration_ = 6.5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play105121020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_5", "se_story_5_laststrike", "")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("stop", "effect", "se_story_5", "se_story_5_steamloop", "")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("stop", "effect", "se_story_5", "se_story_5_bossflee", "")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("stop", "effect", "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_83_4 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_5 = 1.5

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_5 then
				local var_83_6 = Color.New(1, 1, 1)

				var_83_6.a = Mathf.Lerp(0, 1, (arg_80_1.time_ - var_83_4) / var_83_5)
				arg_80_1.mask_.color = var_83_6
			end

			if arg_80_1.time_ >= var_83_4 + var_83_5 and arg_80_1.time_ < var_83_4 + var_83_5 + arg_83_0 then
				local var_83_7 = Color.New(1, 1, 1)

				var_83_7.a = 1
				arg_80_1.mask_.color = var_83_7
			end

			local var_83_8 = 1.49999999999999

			if 1.49999999999999 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = false

				arg_80_1:SetGaussion(false)
			end

			local var_83_9 = 1.5

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_9 then
				local var_83_10 = Color.New(1, 1, 1)

				var_83_10.a = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_8) / var_83_9)
				arg_80_1.mask_.color = var_83_10
			end

			if arg_80_1.time_ >= var_83_8 + var_83_9 and arg_80_1.time_ < var_83_8 + var_83_9 + arg_83_0 then
				local var_83_11 = Color.New(1, 1, 1)

				arg_80_1.mask_.enabled = false
				var_83_11.a = 0
				arg_80_1.mask_.color = var_83_11
			end

			local var_83_12 = manager.ui.mainCamera.transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.shakeOldPosMainCamera = var_83_12.localPosition
			end

			local var_83_13 = 0.600000023841858

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_13 then
				local var_83_14, var_83_15 = math.modf((arg_80_1.time_ - 0) / 0.066)

				var_83_12.localPosition = Vector3.New(var_83_15 * 0.13, var_83_15 * 0.13, var_83_15 * 0.13) + arg_80_1.var_.shakeOldPosMainCamera
			end

			if arg_80_1.time_ >= 0 + var_83_13 and arg_80_1.time_ < 0 + var_83_13 + arg_83_0 then
				var_83_12.localPosition = arg_80_1.var_.shakeOldPosMainCamera
			end

			local var_83_16 = arg_80_1.bgs_.S0505.transform

			if 1.5 < arg_80_1.time_ and arg_80_1.time_ <= 1.5 + arg_83_0 then
				arg_80_1.var_.moveOldPosS0505 = var_83_16.localPosition
			end

			local var_83_17 = 0.001

			if 1.5 <= arg_80_1.time_ and arg_80_1.time_ < 1.5 + var_83_17 then
				var_83_16.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosS0505, Vector3.New(0, -100, 0), (arg_80_1.time_ - 1.5) / var_83_17)
			end

			if arg_80_1.time_ >= 1.5 + var_83_17 and arg_80_1.time_ < 1.5 + var_83_17 + arg_83_0 then
				var_83_16.localPosition = Vector3.New(0, -100, 0)
			end

			local var_83_18 = "STwhite"

			if arg_80_1.bgs_.STwhite == nil then
				local var_83_19 = Object.Instantiate(arg_80_1.paintGo_)

				var_83_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_83_18)
				var_83_19.name = var_83_18
				var_83_19.transform.parent = arg_80_1.stage_.transform
				var_83_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.bgs_[var_83_18] = var_83_19
			end

			local var_83_20 = arg_80_1.bgs_.STwhite.transform

			if 1.5 < arg_80_1.time_ and arg_80_1.time_ <= 1.5 + arg_83_0 then
				arg_80_1.var_.moveOldPosSTwhite = var_83_20.localPosition
				var_83_20.localScale = Vector3.New(12, 12, 12)
			end

			local var_83_21 = 0.001

			if 1.5 <= arg_80_1.time_ and arg_80_1.time_ < 1.5 + var_83_21 then
				var_83_20.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_80_1.time_ - 1.5) / var_83_21)
			end

			if arg_80_1.time_ >= 1.5 + var_83_21 and arg_80_1.time_ < 1.5 + var_83_21 + arg_83_0 then
				var_83_20.localPosition = Vector3.New(0, 0, 0)
			end

			local var_83_22 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_22 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			if arg_80_1.time_ >= var_83_22 + 1.49999999999999 and arg_80_1.time_ < var_83_22 + 1.49999999999999 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_23 = 1.5
			local var_83_24 = 1.375

			if 1.5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_25 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(105121019).content)

				arg_80_1.text_.text = var_83_25

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_27 = 55 <= 0 and var_83_24 or var_83_24 * (utf8.len(var_83_25) / 55)

				if (55 <= 0 and var_83_24 or var_83_24 * (utf8.len(var_83_25) / 55)) > 0 and var_83_24 < var_83_27 then
					arg_80_1.talkMaxDuration = var_83_27

					if var_83_27 + var_83_23 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_27 + var_83_23
					end
				end

				arg_80_1.text_.text = var_83_25
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_28 = math.max(var_83_24, arg_80_1.talkMaxDuration)

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_28 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_23) / var_83_28

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_23 + var_83_28 and arg_80_1.time_ < var_83_23 + var_83_28 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0505",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
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

		arg_80_1:InitPlayNodeList()
	end,
	Play105121020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 105121020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play105121021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_ui", "se_story_stopenv", "")
			end

			local var_87_1 = 0
			local var_87_2 = 0.05

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(105121020).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 2 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 2)

				if (2 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 2)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play105121021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 105121021
		arg_88_1.duration_ = 6.5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play105121022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 1.5 < arg_88_1.time_ and arg_88_1.time_ <= 1.5 + arg_91_0 then
				arg_88_1:AudioAction("play", "effect", "se_story_5", "se_story_5_back", "")
			end

			local var_91_1 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_2 = 1.5

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = Color.New(1, 1, 1)

				var_91_3.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_1) / var_91_2)
				arg_88_1.mask_.color = var_91_3
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				local var_91_4 = Color.New(1, 1, 1)

				arg_88_1.mask_.enabled = false
				var_91_4.a = 0
				arg_88_1.mask_.color = var_91_4
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				local var_91_5 = arg_88_1.bgs_.B12a

				arg_88_1.bgs_.B12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_6 = var_91_5:GetComponent("SpriteRenderer")

				if var_91_6 and var_91_6.sprite then
					local var_91_7 = 2 * (var_91_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_5.transform.localScale = Vector3.New(var_91_7 / var_91_6.sprite.bounds.size.y < var_91_7 * manager.ui.mainCameraCom_.aspect / var_91_6.sprite.bounds.size.x and var_91_7 * manager.ui.mainCameraCom_.aspect / var_91_6.sprite.bounds.size.x or var_91_7 / var_91_6.sprite.bounds.size.y, var_91_7 / var_91_6.sprite.bounds.size.y < var_91_7 * manager.ui.mainCameraCom_.aspect / var_91_6.sprite.bounds.size.x and var_91_7 * manager.ui.mainCameraCom_.aspect / var_91_6.sprite.bounds.size.x or var_91_7 / var_91_6.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "B12a" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_8 = 1.5
			local var_91_9 = 0.625

			if 1.5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_10 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_10:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_11 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(105121021).content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 25 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 25)

				if (25 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 25)) > 0 and var_91_9 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13
					var_91_8 = var_91_8 + 0.3

					if var_91_13 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = var_91_8 + 0.3
			local var_91_15 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_14 + var_91_15 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_14) / var_91_15

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_14 + var_91_15 and arg_88_1.time_ < var_91_14 + var_91_15 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play105121022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 105121022
		arg_94_1.duration_ = 2.4

		local var_94_0 = {
			ja = 1.999999999999,
			ko = 2.166,
			zh = 2.4,
			en = 1.999999999999
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
				arg_94_0:Play105121023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_97_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_94_1.stage_.transform)

				var_97_0.name = "1036ui_story"
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.actors_["1036ui_story"] = var_97_0

				local var_97_1 = var_97_0:GetComponentInChildren(typeof(CharacterEffect))

				var_97_1.enabled = true

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end

				arg_94_1:ShowWeapon(var_97_1.transform, false)

				arg_94_1.var_["1036ui_story" .. "Animator"] = var_97_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_94_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_94_1.var_["1036ui_story" .. "LipSync"] = var_97_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_97_3 = arg_94_1.actors_["1036ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1036ui_story == nil then
				arg_94_1.var_.characterEffect1036ui_story = var_97_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.characterEffect1036ui_story and not isNil(var_97_3) then
					arg_94_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1036ui_story then
				arg_94_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_97_6 = arg_94_1.actors_["1036ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1036ui_story = var_97_6.localPosition
			end

			local var_97_7 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				var_97_6.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_94_1.time_ - 0) / var_97_7)
				var_97_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_6.position).x, (manager.ui.mainCamera.transform.position - var_97_6.position).y, (manager.ui.mainCamera.transform.position - var_97_6.position).z)
				var_97_6.localEulerAngles.z = 0
				var_97_6.localEulerAngles.x = 0
				var_97_6.localEulerAngles = var_97_6.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				var_97_6.localPosition = Vector3.New(0, -1.09, -5.78)
				var_97_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_6.position).x, (manager.ui.mainCamera.transform.position - var_97_6.position).y, (manager.ui.mainCamera.transform.position - var_97_6.position).z)
				var_97_6.localEulerAngles.z = 0
				var_97_6.localEulerAngles.x = 0
				var_97_6.localEulerAngles = var_97_6.localEulerAngles
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action7_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_97_8 = 0
			local var_97_9 = 0.15

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(105121022)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 7 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 7)

				if (7 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 7)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121022", "story_v_out_105121.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121022", "story_v_out_105121.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_105121", "105121022", "story_v_out_105121.awb")

						arg_94_1:RecordAudio("105121022", var_97_15)
						arg_94_1:RecordAudio("105121022", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_105121", "105121022", "story_v_out_105121.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_105121", "105121022", "story_v_out_105121.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play105121023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 105121023
		arg_98_1.duration_ = 3.63

		local var_98_0 = {
			ja = 3.633,
			ko = 2.2,
			zh = 2.6,
			en = 3.066
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
				arg_98_0:Play105121024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1084ui_story"]) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = arg_98_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1084ui_story"]) then
				if arg_98_1.var_.characterEffect1084ui_story and not isNil(arg_98_1.actors_["1084ui_story"]) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1084ui_story"]) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["1036ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1036ui_story == nil then
				arg_98_1.var_.characterEffect1036ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect1036ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1036ui_story then
				arg_98_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_101_4 = 0
			local var_101_5 = 0.15

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_6 = arg_98_1:GetWordFromCfg(105121023)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 6 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 6)

				if (6 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 6)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121023", "story_v_out_105121.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121023", "story_v_out_105121.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_105121", "105121023", "story_v_out_105121.awb")

						arg_98_1:RecordAudio("105121023", var_101_11)
						arg_98_1:RecordAudio("105121023", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_105121", "105121023", "story_v_out_105121.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_105121", "105121023", "story_v_out_105121.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play105121024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 105121024
		arg_102_1.duration_ = 3.67

		local var_102_0 = {
			ja = 3.666,
			ko = 2.766,
			zh = 2.9,
			en = 2.966
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play105121025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1019ui_story"]) and arg_102_1.var_.characterEffect1019ui_story == nil then
				arg_102_1.var_.characterEffect1019ui_story = arg_102_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1019ui_story"]) then
				if arg_102_1.var_.characterEffect1019ui_story and not isNil(arg_102_1.actors_["1019ui_story"]) then
					arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1019ui_story"]) and arg_102_1.var_.characterEffect1019ui_story then
				arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["1084ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect1084ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1084ui_story then
				arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_105_4 = arg_102_1.actors_["1036ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1036ui_story = var_105_4.localPosition
			end

			local var_105_5 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_5 then
				var_105_4.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_5)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_5 and arg_102_1.time_ < 0 + var_105_5 + arg_105_0 then
				var_105_4.localPosition = Vector3.New(0, 100, 0)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			local var_105_6 = arg_102_1.actors_["1019ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1019ui_story = var_105_6.localPosition
			end

			local var_105_7 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				var_105_6.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_102_1.time_ - 0) / var_105_7)
				var_105_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_6.position).x, (manager.ui.mainCamera.transform.position - var_105_6.position).y, (manager.ui.mainCamera.transform.position - var_105_6.position).z)
				var_105_6.localEulerAngles.z = 0
				var_105_6.localEulerAngles.x = 0
				var_105_6.localEulerAngles = var_105_6.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				var_105_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_105_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_6.position).x, (manager.ui.mainCamera.transform.position - var_105_6.position).y, (manager.ui.mainCamera.transform.position - var_105_6.position).z)
				var_105_6.localEulerAngles.z = 0
				var_105_6.localEulerAngles.x = 0
				var_105_6.localEulerAngles = var_105_6.localEulerAngles
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_105_8 = 0
			local var_105_9 = 0.225

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_10 = arg_102_1:GetWordFromCfg(105121024)
				local var_105_11 = arg_102_1:FormatText(var_105_10.content)

				arg_102_1.text_.text = var_105_11

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 9 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_11) / 9)

				if (9 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_11) / 9)) > 0 and var_105_9 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_11
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121024", "story_v_out_105121.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121024", "story_v_out_105121.awb") / 1000

					if var_105_14 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_8
					end

					if var_105_10.prefab_name ~= "" and arg_102_1.actors_[var_105_10.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_10.prefab_name].transform, "story_v_out_105121", "105121024", "story_v_out_105121.awb")

						arg_102_1:RecordAudio("105121024", var_105_15)
						arg_102_1:RecordAudio("105121024", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_105121", "105121024", "story_v_out_105121.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_105121", "105121024", "story_v_out_105121.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_16 and arg_102_1.time_ < var_105_8 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play105121025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 105121025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play105121026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) and arg_106_1.var_.characterEffect1019ui_story == nil then
				arg_106_1.var_.characterEffect1019ui_story = arg_106_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) then
				if arg_106_1.var_.characterEffect1019ui_story and not isNil(arg_106_1.actors_["1019ui_story"]) then
					arg_106_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) and arg_106_1.var_.characterEffect1019ui_story then
				arg_106_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_109_1 = arg_106_1.actors_["1019ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1019ui_story = var_109_1.localPosition
			end

			local var_109_2 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 then
				var_109_1.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_2)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 then
				var_109_1.localPosition = Vector3.New(0, 100, 0)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles
			end

			local var_109_3 = 0
			local var_109_4 = 1.3

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_3 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_5 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(105121025).content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 52 <= 0 and var_109_4 or var_109_4 * (utf8.len(var_109_5) / 52)

				if (52 <= 0 and var_109_4 or var_109_4 * (utf8.len(var_109_5) / 52)) > 0 and var_109_4 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_3 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_3
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_4, arg_106_1.talkMaxDuration)

			if var_109_3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_3 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_3) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_3 + var_109_8 and arg_106_1.time_ < var_109_3 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play105121026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 105121026
		arg_110_1.duration_ = 4.93

		local var_110_0 = {
			ja = 4.933,
			ko = 3.7,
			zh = 2.5,
			en = 4.666
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
				arg_110_0:Play105121027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1036ui_story"]) and arg_110_1.var_.characterEffect1036ui_story == nil then
				arg_110_1.var_.characterEffect1036ui_story = arg_110_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1036ui_story"]) then
				if arg_110_1.var_.characterEffect1036ui_story and not isNil(arg_110_1.actors_["1036ui_story"]) then
					arg_110_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1036ui_story"]) and arg_110_1.var_.characterEffect1036ui_story then
				arg_110_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_113_2 = 0
			local var_113_3 = 0.35

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_4 = arg_110_1:GetWordFromCfg(105121026)
				local var_113_5 = arg_110_1:FormatText(var_113_4.content)

				arg_110_1.text_.text = var_113_5

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_7 = 14 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 14)

				if (14 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 14)) > 0 and var_113_3 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_2
					end
				end

				arg_110_1.text_.text = var_113_5
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121026", "story_v_out_105121.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121026", "story_v_out_105121.awb") / 1000

					if var_113_8 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_2
					end

					if var_113_4.prefab_name ~= "" and arg_110_1.actors_[var_113_4.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_4.prefab_name].transform, "story_v_out_105121", "105121026", "story_v_out_105121.awb")

						arg_110_1:RecordAudio("105121026", var_113_9)
						arg_110_1:RecordAudio("105121026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_105121", "105121026", "story_v_out_105121.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_105121", "105121026", "story_v_out_105121.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_3, arg_110_1.talkMaxDuration)

			if var_113_2 <= arg_110_1.time_ and arg_110_1.time_ < var_113_2 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_2) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_2 + var_113_10 and arg_110_1.time_ < var_113_2 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play105121027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 105121027
		arg_114_1.duration_ = 3.3

		local var_114_0 = {
			ja = 3.3,
			ko = 2,
			zh = 3,
			en = 1.9
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
				arg_114_0:Play105121028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1019ui_story"]) and arg_114_1.var_.characterEffect1019ui_story == nil then
				arg_114_1.var_.characterEffect1019ui_story = arg_114_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1019ui_story"]) then
				if arg_114_1.var_.characterEffect1019ui_story and not isNil(arg_114_1.actors_["1019ui_story"]) then
					arg_114_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1019ui_story"]) and arg_114_1.var_.characterEffect1019ui_story then
				arg_114_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["1036ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1036ui_story == nil then
				arg_114_1.var_.characterEffect1036ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect1036ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1036ui_story then
				arg_114_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_117_4 = 0
			local var_117_5 = 0.25

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_6 = arg_114_1:GetWordFromCfg(105121027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 10 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 10)

				if (10 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 10)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121027", "story_v_out_105121.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121027", "story_v_out_105121.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_105121", "105121027", "story_v_out_105121.awb")

						arg_114_1:RecordAudio("105121027", var_117_11)
						arg_114_1:RecordAudio("105121027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_105121", "105121027", "story_v_out_105121.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_105121", "105121027", "story_v_out_105121.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play105121028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 105121028
		arg_118_1.duration_ = 4.53

		local var_118_0 = {
			ja = 4.533,
			ko = 3.2,
			zh = 3.1,
			en = 3.633
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
				arg_118_0:Play105121029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = arg_118_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) then
				if arg_118_1.var_.characterEffect1084ui_story and not isNil(arg_118_1.actors_["1084ui_story"]) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["1019ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1019ui_story == nil then
				arg_118_1.var_.characterEffect1019ui_story = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_3 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.characterEffect1019ui_story and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_3)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1019ui_story then
				arg_118_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_121_4 = 0
			local var_121_5 = 0.225

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_6 = arg_118_1:GetWordFromCfg(105121028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 9 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 9)

				if (9 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 9)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121028", "story_v_out_105121.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121028", "story_v_out_105121.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_105121", "105121028", "story_v_out_105121.awb")

						arg_118_1:RecordAudio("105121028", var_121_11)
						arg_118_1:RecordAudio("105121028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_105121", "105121028", "story_v_out_105121.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_105121", "105121028", "story_v_out_105121.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play105121029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 105121029
		arg_122_1.duration_ = 8

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play105121030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_125_1 = arg_122_1.actors_["1084ui_story"]

			if 2 < arg_122_1.time_ and arg_122_1.time_ <= 2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.1

			if 2 <= arg_122_1.time_ and arg_122_1.time_ < 2 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 2) / var_125_2)
				end
			end

			if arg_122_1.time_ >= 2 + var_125_2 and arg_122_1.time_ < 2 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				local var_125_3 = arg_122_1.bgs_.B12a:GetComponent("SpriteRenderer")

				if var_125_3 then
					arg_122_1.var_.alphaOldValueB12a = var_125_3.color.a
					arg_122_1.var_.alphaMatValueB12a = var_125_3
				end

				arg_122_1.var_.alphaOldValueB12a = 1
			end

			local var_125_4 = 1.5

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				if arg_122_1.var_.alphaMatValueB12a then
					arg_122_1.var_.alphaMatValueB12a.color.a = Mathf.Lerp(arg_122_1.var_.alphaOldValueB12a, 0, (arg_122_1.time_ - 0) / var_125_4)
					arg_122_1.var_.alphaMatValueB12a.color = arg_122_1.var_.alphaMatValueB12a.color
				end
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 and arg_122_1.var_.alphaMatValueB12a then
				arg_122_1.var_.alphaMatValueB12a.color.a = 0
				arg_122_1.var_.alphaMatValueB12a.color = arg_122_1.var_.alphaMatValueB12a.color
			end

			local var_125_5 = arg_122_1.bgs_.B12a.transform

			if 1.5 < arg_122_1.time_ and arg_122_1.time_ <= 1.5 + arg_125_0 then
				arg_122_1.var_.moveOldPosB12a = var_125_5.localPosition
			end

			local var_125_6 = 0.001

			if 1.5 <= arg_122_1.time_ and arg_122_1.time_ < 1.5 + var_125_6 then
				var_125_5.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPosB12a, Vector3.New(0, -100, 10), (arg_122_1.time_ - 1.5) / var_125_6)
			end

			if arg_122_1.time_ >= 1.5 + var_125_6 and arg_122_1.time_ < 1.5 + var_125_6 + arg_125_0 then
				var_125_5.localPosition = Vector3.New(0, -100, 10)
			end

			local var_125_7 = "B01a"

			if arg_122_1.bgs_.B01a == nil then
				local var_125_8 = Object.Instantiate(arg_122_1.paintGo_)

				var_125_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_125_7)
				var_125_8.name = var_125_7
				var_125_8.transform.parent = arg_122_1.stage_.transform
				var_125_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.bgs_[var_125_7] = var_125_8
			end

			if 1.5 < arg_122_1.time_ and arg_122_1.time_ <= 1.5 + arg_125_0 then
				local var_125_9 = arg_122_1.bgs_.B01a:GetComponent("SpriteRenderer")

				if var_125_9 then
					arg_122_1.var_.alphaOldValueB01a = var_125_9.color.a
					arg_122_1.var_.alphaMatValueB01a = var_125_9
				end

				arg_122_1.var_.alphaOldValueB01a = 0
			end

			local var_125_10 = 1.5

			if 1.5 <= arg_122_1.time_ and arg_122_1.time_ < 1.5 + var_125_10 then
				if arg_122_1.var_.alphaMatValueB01a then
					arg_122_1.var_.alphaMatValueB01a.color.a = Mathf.Lerp(arg_122_1.var_.alphaOldValueB01a, 1, (arg_122_1.time_ - 1.5) / var_125_10)
					arg_122_1.var_.alphaMatValueB01a.color = arg_122_1.var_.alphaMatValueB01a.color
				end
			end

			if arg_122_1.time_ >= 1.5 + var_125_10 and arg_122_1.time_ < 1.5 + var_125_10 + arg_125_0 and arg_122_1.var_.alphaMatValueB01a then
				arg_122_1.var_.alphaMatValueB01a.color.a = 1
				arg_122_1.var_.alphaMatValueB01a.color = arg_122_1.var_.alphaMatValueB01a.color
			end

			if 1.5 < arg_122_1.time_ and arg_122_1.time_ <= 1.5 + arg_125_0 then
				local var_125_11 = arg_122_1.bgs_.B01a

				arg_122_1.bgs_.B01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_125_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_12 = var_125_11:GetComponent("SpriteRenderer")

				if var_125_12 and var_125_12.sprite then
					local var_125_13 = 2 * (var_125_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_125_11.transform.localScale = Vector3.New(var_125_13 / var_125_12.sprite.bounds.size.y < var_125_13 * manager.ui.mainCameraCom_.aspect / var_125_12.sprite.bounds.size.x and var_125_13 * manager.ui.mainCameraCom_.aspect / var_125_12.sprite.bounds.size.x or var_125_13 / var_125_12.sprite.bounds.size.y, var_125_13 / var_125_12.sprite.bounds.size.y < var_125_13 * manager.ui.mainCameraCom_.aspect / var_125_12.sprite.bounds.size.x and var_125_13 * manager.ui.mainCameraCom_.aspect / var_125_12.sprite.bounds.size.x or var_125_13 / var_125_12.sprite.bounds.size.y, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "B01a" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_14 = 0

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_14 + arg_125_0 then
				arg_122_1.allBtn_.enabled = false
			end

			if arg_122_1.time_ >= var_125_14 + 3 and arg_122_1.time_ < var_125_14 + 3 + arg_125_0 then
				arg_122_1.allBtn_.enabled = true
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_15 = 3
			local var_125_16 = 0.2

			if 3 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_17 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_17:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_18 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(105121029).content)

				arg_122_1.text_.text = var_125_18

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_20 = 8 <= 0 and var_125_16 or var_125_16 * (utf8.len(var_125_18) / 8)

				if (8 <= 0 and var_125_16 or var_125_16 * (utf8.len(var_125_18) / 8)) > 0 and var_125_16 < var_125_20 then
					arg_122_1.talkMaxDuration = var_125_20
					var_125_15 = var_125_15 + 0.3

					if var_125_20 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_20 + var_125_15
					end
				end

				arg_122_1.text_.text = var_125_18
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_21 = var_125_15 + 0.3
			local var_125_22 = math.max(var_125_16, arg_122_1.talkMaxDuration)

			if var_125_15 + 0.3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_21 + var_125_22 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_21) / var_125_22

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_21 + var_125_22 and arg_122_1.time_ < var_125_21 + var_125_22 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B12a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play105121030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 105121030
		arg_128_1.duration_ = 7.43

		local var_128_0 = {
			ja = 7.433,
			ko = 5.4,
			zh = 5.633,
			en = 6.5
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
				arg_128_0:Play105121031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if arg_128_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_131_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_128_1.stage_.transform)

				var_131_0.name = "1059ui_story"
				var_131_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["1059ui_story"] = var_131_0

				local var_131_1 = var_131_0:GetComponentInChildren(typeof(CharacterEffect))

				var_131_1.enabled = true

				local var_131_2 = GameObjectTools.GetOrAddComponent(var_131_0, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(false)
				end

				arg_128_1:ShowWeapon(var_131_1.transform, false)

				arg_128_1.var_["1059ui_story" .. "Animator"] = var_131_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_128_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_128_1.var_["1059ui_story" .. "LipSync"] = var_131_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_131_3 = arg_128_1.actors_["1059ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1059ui_story == nil then
				arg_128_1.var_.characterEffect1059ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.1

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect1059ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1059ui_story then
				arg_128_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_131_6 = arg_128_1.actors_["1059ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1059ui_story = var_131_6.localPosition
			end

			local var_131_7 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				var_131_6.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_128_1.time_ - 0) / var_131_7)
				var_131_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_6.position).x, (manager.ui.mainCamera.transform.position - var_131_6.position).y, (manager.ui.mainCamera.transform.position - var_131_6.position).z)
				var_131_6.localEulerAngles.z = 0
				var_131_6.localEulerAngles.x = 0
				var_131_6.localEulerAngles = var_131_6.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				var_131_6.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_131_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_6.position).x, (manager.ui.mainCamera.transform.position - var_131_6.position).y, (manager.ui.mainCamera.transform.position - var_131_6.position).z)
				var_131_6.localEulerAngles.z = 0
				var_131_6.localEulerAngles.x = 0
				var_131_6.localEulerAngles = var_131_6.localEulerAngles
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_131_8 = 0
			local var_131_9 = 0.6

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_10 = arg_128_1:GetWordFromCfg(105121030)
				local var_131_11 = arg_128_1:FormatText(var_131_10.content)

				arg_128_1.text_.text = var_131_11

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_13 = 24 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_11) / 24)

				if (24 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_11) / 24)) > 0 and var_131_9 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_8
					end
				end

				arg_128_1.text_.text = var_131_11
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121030", "story_v_out_105121.awb") ~= 0 then
					local var_131_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121030", "story_v_out_105121.awb") / 1000

					if var_131_14 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_8
					end

					if var_131_10.prefab_name ~= "" and arg_128_1.actors_[var_131_10.prefab_name] ~= nil then
						local var_131_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_10.prefab_name].transform, "story_v_out_105121", "105121030", "story_v_out_105121.awb")

						arg_128_1:RecordAudio("105121030", var_131_15)
						arg_128_1:RecordAudio("105121030", var_131_15)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_105121", "105121030", "story_v_out_105121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_105121", "105121030", "story_v_out_105121.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_9, arg_128_1.talkMaxDuration)

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_8) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_8 + var_131_16 and arg_128_1.time_ < var_131_8 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play105121031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 105121031
		arg_132_1.duration_ = 4.37

		local var_132_0 = {
			ja = 3.6,
			ko = 4.366,
			zh = 3.4,
			en = 2.333
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
				arg_132_0:Play105121032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if arg_132_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_135_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_132_1.stage_.transform)

				var_135_0.name = "1037ui_story"
				var_135_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["1037ui_story"] = var_135_0

				local var_135_1 = var_135_0:GetComponentInChildren(typeof(CharacterEffect))

				var_135_1.enabled = true

				local var_135_2 = GameObjectTools.GetOrAddComponent(var_135_0, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(false)
				end

				arg_132_1:ShowWeapon(var_135_1.transform, false)

				arg_132_1.var_["1037ui_story" .. "Animator"] = var_135_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_132_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_132_1.var_["1037ui_story" .. "LipSync"] = var_135_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_135_3 = arg_132_1.actors_["1037ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect1037ui_story == nil then
				arg_132_1.var_.characterEffect1037ui_story = var_135_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_4 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 and not isNil(var_135_3) then
				if arg_132_1.var_.characterEffect1037ui_story and not isNil(var_135_3) then
					arg_132_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect1037ui_story then
				arg_132_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_135_6 = arg_132_1.actors_["1059ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1059ui_story == nil then
				arg_132_1.var_.characterEffect1059ui_story = var_135_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_7 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 and not isNil(var_135_6) then
				if arg_132_1.var_.characterEffect1059ui_story and not isNil(var_135_6) then
					arg_132_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_7)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1059ui_story then
				arg_132_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_135_8 = arg_132_1.actors_["1037ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1037ui_story = var_135_8.localPosition
			end

			local var_135_9 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_9 then
				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1037ui_story, Vector3.New(0.7, -1.09, -5.81), (arg_132_1.time_ - 0) / var_135_9)
				var_135_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_8.position).x, (manager.ui.mainCamera.transform.position - var_135_8.position).y, (manager.ui.mainCamera.transform.position - var_135_8.position).z)
				var_135_8.localEulerAngles.z = 0
				var_135_8.localEulerAngles.x = 0
				var_135_8.localEulerAngles = var_135_8.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_9 and arg_132_1.time_ < 0 + var_135_9 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(0.7, -1.09, -5.81)
				var_135_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_8.position).x, (manager.ui.mainCamera.transform.position - var_135_8.position).y, (manager.ui.mainCamera.transform.position - var_135_8.position).z)
				var_135_8.localEulerAngles.z = 0
				var_135_8.localEulerAngles.x = 0
				var_135_8.localEulerAngles = var_135_8.localEulerAngles
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_135_10 = 0
			local var_135_11 = 0.4

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_12 = arg_132_1:GetWordFromCfg(105121031)
				local var_135_13 = arg_132_1:FormatText(var_135_12.content)

				arg_132_1.text_.text = var_135_13

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_15 = 16 <= 0 and var_135_11 or var_135_11 * (utf8.len(var_135_13) / 16)

				if (16 <= 0 and var_135_11 or var_135_11 * (utf8.len(var_135_13) / 16)) > 0 and var_135_11 < var_135_15 then
					arg_132_1.talkMaxDuration = var_135_15

					if var_135_15 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_15 + var_135_10
					end
				end

				arg_132_1.text_.text = var_135_13
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121031", "story_v_out_105121.awb") ~= 0 then
					local var_135_16 = manager.audio:GetVoiceLength("story_v_out_105121", "105121031", "story_v_out_105121.awb") / 1000

					if var_135_16 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_16 + var_135_10
					end

					if var_135_12.prefab_name ~= "" and arg_132_1.actors_[var_135_12.prefab_name] ~= nil then
						local var_135_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_12.prefab_name].transform, "story_v_out_105121", "105121031", "story_v_out_105121.awb")

						arg_132_1:RecordAudio("105121031", var_135_17)
						arg_132_1:RecordAudio("105121031", var_135_17)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_105121", "105121031", "story_v_out_105121.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_105121", "105121031", "story_v_out_105121.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_18 = math.max(var_135_11, arg_132_1.talkMaxDuration)

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_18 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_10) / var_135_18

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_10 + var_135_18 and arg_132_1.time_ < var_135_10 + var_135_18 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play105121032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 105121032
		arg_136_1.duration_ = 5.37

		local var_136_0 = {
			ja = 5.366,
			ko = 4.3,
			zh = 3.066,
			en = 3.066
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
				arg_136_0:Play105121033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1036ui_story"]) and arg_136_1.var_.characterEffect1036ui_story == nil then
				arg_136_1.var_.characterEffect1036ui_story = arg_136_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1036ui_story"]) then
				if arg_136_1.var_.characterEffect1036ui_story and not isNil(arg_136_1.actors_["1036ui_story"]) then
					arg_136_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1036ui_story"]) and arg_136_1.var_.characterEffect1036ui_story then
				arg_136_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1037ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1037ui_story == nil then
				arg_136_1.var_.characterEffect1037ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1037ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1037ui_story then
				arg_136_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_139_4 = arg_136_1.actors_["1037ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1037ui_story = var_139_4.localPosition
			end

			local var_139_5 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 then
				var_139_4.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_5)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 then
				var_139_4.localPosition = Vector3.New(0, 100, 0)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			local var_139_6 = arg_136_1.actors_["1059ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1059ui_story = var_139_6.localPosition
			end

			local var_139_7 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				var_139_6.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_7)
				var_139_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_6.position).x, (manager.ui.mainCamera.transform.position - var_139_6.position).y, (manager.ui.mainCamera.transform.position - var_139_6.position).z)
				var_139_6.localEulerAngles.z = 0
				var_139_6.localEulerAngles.x = 0
				var_139_6.localEulerAngles = var_139_6.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				var_139_6.localPosition = Vector3.New(0, 100, 0)
				var_139_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_6.position).x, (manager.ui.mainCamera.transform.position - var_139_6.position).y, (manager.ui.mainCamera.transform.position - var_139_6.position).z)
				var_139_6.localEulerAngles.z = 0
				var_139_6.localEulerAngles.x = 0
				var_139_6.localEulerAngles = var_139_6.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_139_8 = arg_136_1.actors_["1036ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1036ui_story = var_139_8.localPosition
			end

			local var_139_9 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_9 then
				var_139_8.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_136_1.time_ - 0) / var_139_9)
				var_139_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_8.position).x, (manager.ui.mainCamera.transform.position - var_139_8.position).y, (manager.ui.mainCamera.transform.position - var_139_8.position).z)
				var_139_8.localEulerAngles.z = 0
				var_139_8.localEulerAngles.x = 0
				var_139_8.localEulerAngles = var_139_8.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_9 and arg_136_1.time_ < 0 + var_139_9 + arg_139_0 then
				var_139_8.localPosition = Vector3.New(0, -1.09, -5.78)
				var_139_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_8.position).x, (manager.ui.mainCamera.transform.position - var_139_8.position).y, (manager.ui.mainCamera.transform.position - var_139_8.position).z)
				var_139_8.localEulerAngles.z = 0
				var_139_8.localEulerAngles.x = 0
				var_139_8.localEulerAngles = var_139_8.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_139_10 = 0
			local var_139_11 = 0.45

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_12 = arg_136_1:GetWordFromCfg(105121032)
				local var_139_13 = arg_136_1:FormatText(var_139_12.content)

				arg_136_1.text_.text = var_139_13

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_15 = 16 <= 0 and var_139_11 or var_139_11 * (utf8.len(var_139_13) / 16)

				if (16 <= 0 and var_139_11 or var_139_11 * (utf8.len(var_139_13) / 16)) > 0 and var_139_11 < var_139_15 then
					arg_136_1.talkMaxDuration = var_139_15

					if var_139_15 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_10
					end
				end

				arg_136_1.text_.text = var_139_13
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121032", "story_v_out_105121.awb") ~= 0 then
					local var_139_16 = manager.audio:GetVoiceLength("story_v_out_105121", "105121032", "story_v_out_105121.awb") / 1000

					if var_139_16 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_16 + var_139_10
					end

					if var_139_12.prefab_name ~= "" and arg_136_1.actors_[var_139_12.prefab_name] ~= nil then
						local var_139_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_12.prefab_name].transform, "story_v_out_105121", "105121032", "story_v_out_105121.awb")

						arg_136_1:RecordAudio("105121032", var_139_17)
						arg_136_1:RecordAudio("105121032", var_139_17)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_105121", "105121032", "story_v_out_105121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_105121", "105121032", "story_v_out_105121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_18 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_18 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_10) / var_139_18

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_10 + var_139_18 and arg_136_1.time_ < var_139_10 + var_139_18 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
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

		arg_136_1:InitPlayNodeList()
	end,
	Play105121033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 105121033
		arg_140_1.duration_ = 0.1

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"

			SetActive(arg_140_1.choicesGo_, true)

			for iter_141_0, iter_141_1 in ipairs(arg_140_1.choices_) do
				SetActive(iter_141_1.go, iter_141_0 <= 1)
			end

			arg_140_1.choices_[1].txt.text = arg_140_1:FormatText(StoryChoiceCfg[34].name)
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play105121034(arg_140_1)
			end

			arg_140_1:RecordChoiceLog(105121033, 34)
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1036ui_story"]) and arg_140_1.var_.characterEffect1036ui_story == nil then
				arg_140_1.var_.characterEffect1036ui_story = arg_140_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1036ui_story"]) then
				if arg_140_1.var_.characterEffect1036ui_story and not isNil(arg_140_1.actors_["1036ui_story"]) then
					arg_140_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1036ui_story"]) and arg_140_1.var_.characterEffect1036ui_story then
				arg_140_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play105121034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 105121034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play105121035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1036ui_story = arg_144_1.actors_["1036ui_story"].transform.localPosition
			end

			local var_147_0 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				arg_144_1.actors_["1036ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_0)
				arg_144_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1036ui_story"].transform.position).z)
				arg_144_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1036ui_story"].transform.localEulerAngles = arg_144_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				arg_144_1.actors_["1036ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1036ui_story"].transform.position).z)
				arg_144_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1036ui_story"].transform.localEulerAngles = arg_144_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			local var_147_1 = 0
			local var_147_2 = 0.35

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(105121034).content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 14 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 14)

				if (14 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 14)) > 0 and var_147_2 < var_147_5 then
					arg_144_1.talkMaxDuration = var_147_5

					if var_147_5 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_6 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_6 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_6

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_6 and arg_144_1.time_ < var_147_1 + var_147_6 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play105121035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 105121035
		arg_148_1.duration_ = 5

		local var_148_0 = {
			ja = 5,
			ko = 3.7,
			zh = 3.7,
			en = 4.033
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
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play105121036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1019ui_story"]) and arg_148_1.var_.characterEffect1019ui_story == nil then
				arg_148_1.var_.characterEffect1019ui_story = arg_148_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.1

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1019ui_story"]) then
				if arg_148_1.var_.characterEffect1019ui_story and not isNil(arg_148_1.actors_["1019ui_story"]) then
					arg_148_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1019ui_story"]) and arg_148_1.var_.characterEffect1019ui_story then
				arg_148_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_151_2 = arg_148_1.actors_["1019ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1019ui_story = var_151_2.localPosition
			end

			local var_151_3 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 then
				var_151_2.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_148_1.time_ - 0) / var_151_3)
				var_151_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_2.position).x, (manager.ui.mainCamera.transform.position - var_151_2.position).y, (manager.ui.mainCamera.transform.position - var_151_2.position).z)
				var_151_2.localEulerAngles.z = 0
				var_151_2.localEulerAngles.x = 0
				var_151_2.localEulerAngles = var_151_2.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 then
				var_151_2.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_151_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_2.position).x, (manager.ui.mainCamera.transform.position - var_151_2.position).y, (manager.ui.mainCamera.transform.position - var_151_2.position).z)
				var_151_2.localEulerAngles.z = 0
				var_151_2.localEulerAngles.x = 0
				var_151_2.localEulerAngles = var_151_2.localEulerAngles
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_151_4 = 0
			local var_151_5 = 0.375

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(105121035)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 13 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 13)

				if (13 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 13)) > 0 and var_151_5 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121035", "story_v_out_105121.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121035", "story_v_out_105121.awb") / 1000

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end

					if var_151_6.prefab_name ~= "" and arg_148_1.actors_[var_151_6.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_6.prefab_name].transform, "story_v_out_105121", "105121035", "story_v_out_105121.awb")

						arg_148_1:RecordAudio("105121035", var_151_11)
						arg_148_1:RecordAudio("105121035", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_105121", "105121035", "story_v_out_105121.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_105121", "105121035", "story_v_out_105121.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_12 and arg_148_1.time_ < var_151_4 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play105121036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 105121036
		arg_152_1.duration_ = 10.87

		local var_152_0 = {
			ja = 10.866,
			ko = 3.166,
			zh = 5.266,
			en = 5.066
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play105121037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if arg_152_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_155_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_152_1.stage_.transform)

				var_155_0.name = "1148ui_story"
				var_155_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_["1148ui_story"] = var_155_0

				local var_155_1 = var_155_0:GetComponentInChildren(typeof(CharacterEffect))

				var_155_1.enabled = true

				local var_155_2 = GameObjectTools.GetOrAddComponent(var_155_0, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(false)
				end

				arg_152_1:ShowWeapon(var_155_1.transform, false)

				arg_152_1.var_["1148ui_story" .. "Animator"] = var_155_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_152_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_152_1.var_["1148ui_story" .. "LipSync"] = var_155_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_155_3 = arg_152_1.actors_["1148ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect1148ui_story == nil then
				arg_152_1.var_.characterEffect1148ui_story = var_155_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_4 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 and not isNil(var_155_3) then
				if arg_152_1.var_.characterEffect1148ui_story and not isNil(var_155_3) then
					arg_152_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect1148ui_story then
				arg_152_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_155_6 = "1011ui_story"

			if arg_152_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_155_7 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_152_1.stage_.transform)

				var_155_7.name = var_155_6
				var_155_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_[var_155_6] = var_155_7

				local var_155_8 = var_155_7:GetComponentInChildren(typeof(CharacterEffect))

				var_155_8.enabled = true

				local var_155_9 = GameObjectTools.GetOrAddComponent(var_155_7, typeof(DynamicBoneHelper))

				if var_155_9 then
					var_155_9:EnableDynamicBone(false)
				end

				arg_152_1:ShowWeapon(var_155_8.transform, false)

				arg_152_1.var_[var_155_6 .. "Animator"] = var_155_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_152_1.var_[var_155_6 .. "Animator"].applyRootMotion = true
				arg_152_1.var_[var_155_6 .. "LipSync"] = var_155_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_155_10 = arg_152_1.actors_["1011ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_10) and arg_152_1.var_.characterEffect1011ui_story == nil then
				arg_152_1.var_.characterEffect1011ui_story = var_155_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_11 and not isNil(var_155_10) then
				if arg_152_1.var_.characterEffect1011ui_story and not isNil(var_155_10) then
					arg_152_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_11)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_11 and arg_152_1.time_ < 0 + var_155_11 + arg_155_0 and not isNil(var_155_10) and arg_152_1.var_.characterEffect1011ui_story then
				arg_152_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_155_12 = arg_152_1.actors_["1019ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1019ui_story = var_155_12.localPosition
			end

			local var_155_13 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_13 then
				var_155_12.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_152_1.time_ - 0) / var_155_13)
				var_155_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_12.position).x, (manager.ui.mainCamera.transform.position - var_155_12.position).y, (manager.ui.mainCamera.transform.position - var_155_12.position).z)
				var_155_12.localEulerAngles.z = 0
				var_155_12.localEulerAngles.x = 0
				var_155_12.localEulerAngles = var_155_12.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_13 and arg_152_1.time_ < 0 + var_155_13 + arg_155_0 then
				var_155_12.localPosition = Vector3.New(0, 100, 0)
				var_155_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_12.position).x, (manager.ui.mainCamera.transform.position - var_155_12.position).y, (manager.ui.mainCamera.transform.position - var_155_12.position).z)
				var_155_12.localEulerAngles.z = 0
				var_155_12.localEulerAngles.x = 0
				var_155_12.localEulerAngles = var_155_12.localEulerAngles
			end

			local var_155_14 = arg_152_1.actors_["1148ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1148ui_story = var_155_14.localPosition
			end

			local var_155_15 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_15 then
				var_155_14.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_152_1.time_ - 0) / var_155_15)
				var_155_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_14.position).x, (manager.ui.mainCamera.transform.position - var_155_14.position).y, (manager.ui.mainCamera.transform.position - var_155_14.position).z)
				var_155_14.localEulerAngles.z = 0
				var_155_14.localEulerAngles.x = 0
				var_155_14.localEulerAngles = var_155_14.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_15 and arg_152_1.time_ < 0 + var_155_15 + arg_155_0 then
				var_155_14.localPosition = Vector3.New(0, -0.8, -6.2)
				var_155_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_14.position).x, (manager.ui.mainCamera.transform.position - var_155_14.position).y, (manager.ui.mainCamera.transform.position - var_155_14.position).z)
				var_155_14.localEulerAngles.z = 0
				var_155_14.localEulerAngles.x = 0
				var_155_14.localEulerAngles = var_155_14.localEulerAngles
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_155_16 = 0
			local var_155_17 = 0.575

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(105121036)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_21 = 23 <= 0 and var_155_17 or var_155_17 * (utf8.len(var_155_19) / 23)

				if (23 <= 0 and var_155_17 or var_155_17 * (utf8.len(var_155_19) / 23)) > 0 and var_155_17 < var_155_21 then
					arg_152_1.talkMaxDuration = var_155_21

					if var_155_21 + var_155_16 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_21 + var_155_16
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121036", "story_v_out_105121.awb") ~= 0 then
					local var_155_22 = manager.audio:GetVoiceLength("story_v_out_105121", "105121036", "story_v_out_105121.awb") / 1000

					if var_155_22 + var_155_16 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_16
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_105121", "105121036", "story_v_out_105121.awb")

						arg_152_1:RecordAudio("105121036", var_155_23)
						arg_152_1:RecordAudio("105121036", var_155_23)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_105121", "105121036", "story_v_out_105121.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_105121", "105121036", "story_v_out_105121.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_24 = math.max(var_155_17, arg_152_1.talkMaxDuration)

			if var_155_16 <= arg_152_1.time_ and arg_152_1.time_ < var_155_16 + var_155_24 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_16) / var_155_24

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_16 + var_155_24 and arg_152_1.time_ < var_155_16 + var_155_24 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play105121037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 105121037
		arg_156_1.duration_ = 5.9

		local var_156_0 = {
			ja = 5.9,
			ko = 5.433,
			zh = 5.533,
			en = 5.133
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play105121038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if arg_156_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_159_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_156_1.stage_.transform)

				var_159_0.name = "10001_tpose"
				var_159_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["10001_tpose"] = var_159_0

				local var_159_1 = var_159_0:GetComponentInChildren(typeof(CharacterEffect))

				var_159_1.enabled = true

				local var_159_2 = GameObjectTools.GetOrAddComponent(var_159_0, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(false)
				end

				arg_156_1:ShowWeapon(var_159_1.transform, false)

				arg_156_1.var_["10001_tpose" .. "Animator"] = var_159_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_156_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_156_1.var_["10001_tpose" .. "LipSync"] = var_159_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_159_3 = arg_156_1.actors_["10001_tpose"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect10001_tpose == nil then
				arg_156_1.var_.characterEffect10001_tpose = var_159_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_4 = 0.1

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 and not isNil(var_159_3) then
				if arg_156_1.var_.characterEffect10001_tpose and not isNil(var_159_3) then
					arg_156_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect10001_tpose then
				arg_156_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_159_6 = arg_156_1.actors_["1148ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_6) and arg_156_1.var_.characterEffect1148ui_story == nil then
				arg_156_1.var_.characterEffect1148ui_story = var_159_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_7 = 0.1

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 and not isNil(var_159_6) then
				if arg_156_1.var_.characterEffect1148ui_story and not isNil(var_159_6) then
					arg_156_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_7)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 and not isNil(var_159_6) and arg_156_1.var_.characterEffect1148ui_story then
				arg_156_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_159_8 = arg_156_1.actors_["1148ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1148ui_story = var_159_8.localPosition
			end

			local var_159_9 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_9 then
				var_159_8.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_9)
				var_159_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_8.position).x, (manager.ui.mainCamera.transform.position - var_159_8.position).y, (manager.ui.mainCamera.transform.position - var_159_8.position).z)
				var_159_8.localEulerAngles.z = 0
				var_159_8.localEulerAngles.x = 0
				var_159_8.localEulerAngles = var_159_8.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_9 and arg_156_1.time_ < 0 + var_159_9 + arg_159_0 then
				var_159_8.localPosition = Vector3.New(0, 100, 0)
				var_159_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_8.position).x, (manager.ui.mainCamera.transform.position - var_159_8.position).y, (manager.ui.mainCamera.transform.position - var_159_8.position).z)
				var_159_8.localEulerAngles.z = 0
				var_159_8.localEulerAngles.x = 0
				var_159_8.localEulerAngles = var_159_8.localEulerAngles
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			local var_159_10 = arg_156_1.actors_["10001_tpose"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10001_tpose = var_159_10.localPosition

				local var_159_11 = GameObjectTools.GetOrAddComponent(var_159_10.gameObject, typeof(DynamicBoneHelper))

				if var_159_11 then
					var_159_11:EnableDynamicBone(false)
				end
			end

			local var_159_12 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_12 then
				var_159_10.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_156_1.time_ - 0) / var_159_12)
				var_159_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_10.position).x, (manager.ui.mainCamera.transform.position - var_159_10.position).y, (manager.ui.mainCamera.transform.position - var_159_10.position).z)
				var_159_10.localEulerAngles.z = 0
				var_159_10.localEulerAngles.x = 0
				var_159_10.localEulerAngles = var_159_10.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_12 and arg_156_1.time_ < 0 + var_159_12 + arg_159_0 then
				var_159_10.localPosition = Vector3.New(0, -1.23, -5.8)
				var_159_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_10.position).x, (manager.ui.mainCamera.transform.position - var_159_10.position).y, (manager.ui.mainCamera.transform.position - var_159_10.position).z)
				var_159_10.localEulerAngles.z = 0
				var_159_10.localEulerAngles.x = 0
				var_159_10.localEulerAngles = var_159_10.localEulerAngles

				local var_159_13 = GameObjectTools.GetOrAddComponent(var_159_10.gameObject, typeof(DynamicBoneHelper))

				if var_159_13 then
					var_159_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_159_14 = 0
			local var_159_15 = 0.55

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_16 = arg_156_1:GetWordFromCfg(105121037)
				local var_159_17 = arg_156_1:FormatText(var_159_16.content)

				arg_156_1.text_.text = var_159_17

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_19 = 22 <= 0 and var_159_15 or var_159_15 * (utf8.len(var_159_17) / 22)

				if (22 <= 0 and var_159_15 or var_159_15 * (utf8.len(var_159_17) / 22)) > 0 and var_159_15 < var_159_19 then
					arg_156_1.talkMaxDuration = var_159_19

					if var_159_19 + var_159_14 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_19 + var_159_14
					end
				end

				arg_156_1.text_.text = var_159_17
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121037", "story_v_out_105121.awb") ~= 0 then
					local var_159_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121037", "story_v_out_105121.awb") / 1000

					if var_159_20 + var_159_14 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_20 + var_159_14
					end

					if var_159_16.prefab_name ~= "" and arg_156_1.actors_[var_159_16.prefab_name] ~= nil then
						local var_159_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_16.prefab_name].transform, "story_v_out_105121", "105121037", "story_v_out_105121.awb")

						arg_156_1:RecordAudio("105121037", var_159_21)
						arg_156_1:RecordAudio("105121037", var_159_21)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_105121", "105121037", "story_v_out_105121.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_105121", "105121037", "story_v_out_105121.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_22 = math.max(var_159_15, arg_156_1.talkMaxDuration)

			if var_159_14 <= arg_156_1.time_ and arg_156_1.time_ < var_159_14 + var_159_22 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_14) / var_159_22

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_14 + var_159_22 and arg_156_1.time_ < var_159_14 + var_159_22 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play105121038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 105121038
		arg_160_1.duration_ = 4.03

		local var_160_0 = {
			ja = 4,
			ko = 2.2,
			zh = 2.933,
			en = 4.033
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play105121039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1036ui_story"]) and arg_160_1.var_.characterEffect1036ui_story == nil then
				arg_160_1.var_.characterEffect1036ui_story = arg_160_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.1

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1036ui_story"]) then
				if arg_160_1.var_.characterEffect1036ui_story and not isNil(arg_160_1.actors_["1036ui_story"]) then
					arg_160_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1036ui_story"]) and arg_160_1.var_.characterEffect1036ui_story then
				arg_160_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_163_2 = arg_160_1.actors_["10001_tpose"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.characterEffect10001_tpose == nil then
				arg_160_1.var_.characterEffect10001_tpose = var_163_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_3 = 0.1

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_3 and not isNil(var_163_2) then
				if arg_160_1.var_.characterEffect10001_tpose and not isNil(var_163_2) then
					arg_160_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_160_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_3)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_3 and arg_160_1.time_ < 0 + var_163_3 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.characterEffect10001_tpose then
				arg_160_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_160_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_163_4 = arg_160_1.actors_["10001_tpose"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos10001_tpose = var_163_4.localPosition

				local var_163_5 = GameObjectTools.GetOrAddComponent(var_163_4.gameObject, typeof(DynamicBoneHelper))

				if var_163_5 then
					var_163_5:EnableDynamicBone(false)
				end
			end

			local var_163_6 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_6 then
				var_163_4.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_6)
				var_163_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_4.position).x, (manager.ui.mainCamera.transform.position - var_163_4.position).y, (manager.ui.mainCamera.transform.position - var_163_4.position).z)
				var_163_4.localEulerAngles.z = 0
				var_163_4.localEulerAngles.x = 0
				var_163_4.localEulerAngles = var_163_4.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_6 and arg_160_1.time_ < 0 + var_163_6 + arg_163_0 then
				var_163_4.localPosition = Vector3.New(0, 100, 0)
				var_163_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_4.position).x, (manager.ui.mainCamera.transform.position - var_163_4.position).y, (manager.ui.mainCamera.transform.position - var_163_4.position).z)
				var_163_4.localEulerAngles.z = 0
				var_163_4.localEulerAngles.x = 0
				var_163_4.localEulerAngles = var_163_4.localEulerAngles

				local var_163_7 = GameObjectTools.GetOrAddComponent(var_163_4.gameObject, typeof(DynamicBoneHelper))

				if var_163_7 then
					var_163_7:EnableDynamicBone(true)
				end
			end

			local var_163_8 = arg_160_1.actors_["1036ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1036ui_story = var_163_8.localPosition
			end

			local var_163_9 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_9 then
				var_163_8.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1036ui_story, Vector3.New(-0.7, -1.09, -5.78), (arg_160_1.time_ - 0) / var_163_9)
				var_163_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_8.position).x, (manager.ui.mainCamera.transform.position - var_163_8.position).y, (manager.ui.mainCamera.transform.position - var_163_8.position).z)
				var_163_8.localEulerAngles.z = 0
				var_163_8.localEulerAngles.x = 0
				var_163_8.localEulerAngles = var_163_8.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_9 and arg_160_1.time_ < 0 + var_163_9 + arg_163_0 then
				var_163_8.localPosition = Vector3.New(-0.7, -1.09, -5.78)
				var_163_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_8.position).x, (manager.ui.mainCamera.transform.position - var_163_8.position).y, (manager.ui.mainCamera.transform.position - var_163_8.position).z)
				var_163_8.localEulerAngles.z = 0
				var_163_8.localEulerAngles.x = 0
				var_163_8.localEulerAngles = var_163_8.localEulerAngles
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_163_10 = 0
			local var_163_11 = 0.35

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_12 = arg_160_1:GetWordFromCfg(105121038)
				local var_163_13 = arg_160_1:FormatText(var_163_12.content)

				arg_160_1.text_.text = var_163_13

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_15 = 14 <= 0 and var_163_11 or var_163_11 * (utf8.len(var_163_13) / 14)

				if (14 <= 0 and var_163_11 or var_163_11 * (utf8.len(var_163_13) / 14)) > 0 and var_163_11 < var_163_15 then
					arg_160_1.talkMaxDuration = var_163_15

					if var_163_15 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_15 + var_163_10
					end
				end

				arg_160_1.text_.text = var_163_13
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121038", "story_v_out_105121.awb") ~= 0 then
					local var_163_16 = manager.audio:GetVoiceLength("story_v_out_105121", "105121038", "story_v_out_105121.awb") / 1000

					if var_163_16 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_16 + var_163_10
					end

					if var_163_12.prefab_name ~= "" and arg_160_1.actors_[var_163_12.prefab_name] ~= nil then
						local var_163_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_12.prefab_name].transform, "story_v_out_105121", "105121038", "story_v_out_105121.awb")

						arg_160_1:RecordAudio("105121038", var_163_17)
						arg_160_1:RecordAudio("105121038", var_163_17)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_105121", "105121038", "story_v_out_105121.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_105121", "105121038", "story_v_out_105121.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_18 = math.max(var_163_11, arg_160_1.talkMaxDuration)

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_18 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_10) / var_163_18

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_10 + var_163_18 and arg_160_1.time_ < var_163_10 + var_163_18 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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

		arg_160_1:InitPlayNodeList()
	end,
	Play105121039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 105121039
		arg_164_1.duration_ = 6.1

		local var_164_0 = {
			ja = 6.1,
			ko = 4.466,
			zh = 5.733,
			en = 5.333
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play105121040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1148ui_story"]) and arg_164_1.var_.characterEffect1148ui_story == nil then
				arg_164_1.var_.characterEffect1148ui_story = arg_164_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.1

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1148ui_story"]) then
				if arg_164_1.var_.characterEffect1148ui_story and not isNil(arg_164_1.actors_["1148ui_story"]) then
					arg_164_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1148ui_story"]) and arg_164_1.var_.characterEffect1148ui_story then
				arg_164_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_167_2 = arg_164_1.actors_["1036ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1036ui_story == nil then
				arg_164_1.var_.characterEffect1036ui_story = var_167_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_3 = 0.1

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 and not isNil(var_167_2) then
				if arg_164_1.var_.characterEffect1036ui_story and not isNil(var_167_2) then
					arg_164_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_3)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1036ui_story then
				arg_164_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_167_4 = arg_164_1.actors_["1148ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1148ui_story = var_167_4.localPosition
			end

			local var_167_5 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_5 then
				var_167_4.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_164_1.time_ - 0) / var_167_5)
				var_167_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_4.position).x, (manager.ui.mainCamera.transform.position - var_167_4.position).y, (manager.ui.mainCamera.transform.position - var_167_4.position).z)
				var_167_4.localEulerAngles.z = 0
				var_167_4.localEulerAngles.x = 0
				var_167_4.localEulerAngles = var_167_4.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_5 and arg_164_1.time_ < 0 + var_167_5 + arg_167_0 then
				var_167_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_167_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_4.position).x, (manager.ui.mainCamera.transform.position - var_167_4.position).y, (manager.ui.mainCamera.transform.position - var_167_4.position).z)
				var_167_4.localEulerAngles.z = 0
				var_167_4.localEulerAngles.x = 0
				var_167_4.localEulerAngles = var_167_4.localEulerAngles
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_167_6 = 0
			local var_167_7 = 0.55

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(105121039)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 22 <= 0 and var_167_7 or var_167_7 * (utf8.len(var_167_9) / 22)

				if (22 <= 0 and var_167_7 or var_167_7 * (utf8.len(var_167_9) / 22)) > 0 and var_167_7 < var_167_11 then
					arg_164_1.talkMaxDuration = var_167_11

					if var_167_11 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121039", "story_v_out_105121.awb") ~= 0 then
					local var_167_12 = manager.audio:GetVoiceLength("story_v_out_105121", "105121039", "story_v_out_105121.awb") / 1000

					if var_167_12 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_6
					end

					if var_167_8.prefab_name ~= "" and arg_164_1.actors_[var_167_8.prefab_name] ~= nil then
						local var_167_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_8.prefab_name].transform, "story_v_out_105121", "105121039", "story_v_out_105121.awb")

						arg_164_1:RecordAudio("105121039", var_167_13)
						arg_164_1:RecordAudio("105121039", var_167_13)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_105121", "105121039", "story_v_out_105121.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_105121", "105121039", "story_v_out_105121.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play105121040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 105121040
		arg_168_1.duration_ = 14.4

		local var_168_0 = {
			ja = 14.4,
			ko = 6.166,
			zh = 6.8,
			en = 8.066
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play105121041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1019ui_story"]) and arg_168_1.var_.characterEffect1019ui_story == nil then
				arg_168_1.var_.characterEffect1019ui_story = arg_168_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.1

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1019ui_story"]) then
				if arg_168_1.var_.characterEffect1019ui_story and not isNil(arg_168_1.actors_["1019ui_story"]) then
					arg_168_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1019ui_story"]) and arg_168_1.var_.characterEffect1019ui_story then
				arg_168_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_171_2 = arg_168_1.actors_["1148ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.characterEffect1148ui_story == nil then
				arg_168_1.var_.characterEffect1148ui_story = var_171_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_3 = 0.1

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 and not isNil(var_171_2) then
				if arg_168_1.var_.characterEffect1148ui_story and not isNil(var_171_2) then
					arg_168_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_3)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.characterEffect1148ui_story then
				arg_168_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_171_4 = arg_168_1.actors_["1148ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1148ui_story = var_171_4.localPosition
			end

			local var_171_5 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_5 then
				var_171_4.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_5)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_5 and arg_168_1.time_ < 0 + var_171_5 + arg_171_0 then
				var_171_4.localPosition = Vector3.New(0, 100, 0)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			local var_171_6 = arg_168_1.actors_["1036ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1036ui_story = var_171_6.localPosition
			end

			local var_171_7 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				var_171_6.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_7)
				var_171_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_6.position).x, (manager.ui.mainCamera.transform.position - var_171_6.position).y, (manager.ui.mainCamera.transform.position - var_171_6.position).z)
				var_171_6.localEulerAngles.z = 0
				var_171_6.localEulerAngles.x = 0
				var_171_6.localEulerAngles = var_171_6.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				var_171_6.localPosition = Vector3.New(0, 100, 0)
				var_171_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_6.position).x, (manager.ui.mainCamera.transform.position - var_171_6.position).y, (manager.ui.mainCamera.transform.position - var_171_6.position).z)
				var_171_6.localEulerAngles.z = 0
				var_171_6.localEulerAngles.x = 0
				var_171_6.localEulerAngles = var_171_6.localEulerAngles
			end

			local var_171_8 = arg_168_1.actors_["1019ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1019ui_story = var_171_8.localPosition
			end

			local var_171_9 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_9 then
				var_171_8.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_168_1.time_ - 0) / var_171_9)
				var_171_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_8.position).x, (manager.ui.mainCamera.transform.position - var_171_8.position).y, (manager.ui.mainCamera.transform.position - var_171_8.position).z)
				var_171_8.localEulerAngles.z = 0
				var_171_8.localEulerAngles.x = 0
				var_171_8.localEulerAngles = var_171_8.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_9 and arg_168_1.time_ < 0 + var_171_9 + arg_171_0 then
				var_171_8.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_171_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_8.position).x, (manager.ui.mainCamera.transform.position - var_171_8.position).y, (manager.ui.mainCamera.transform.position - var_171_8.position).z)
				var_171_8.localEulerAngles.z = 0
				var_171_8.localEulerAngles.x = 0
				var_171_8.localEulerAngles = var_171_8.localEulerAngles
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_171_10 = 0
			local var_171_11 = 0.925

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_12 = arg_168_1:GetWordFromCfg(105121040)
				local var_171_13 = arg_168_1:FormatText(var_171_12.content)

				arg_168_1.text_.text = var_171_13

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_15 = 37 <= 0 and var_171_11 or var_171_11 * (utf8.len(var_171_13) / 37)

				if (37 <= 0 and var_171_11 or var_171_11 * (utf8.len(var_171_13) / 37)) > 0 and var_171_11 < var_171_15 then
					arg_168_1.talkMaxDuration = var_171_15

					if var_171_15 + var_171_10 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_15 + var_171_10
					end
				end

				arg_168_1.text_.text = var_171_13
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121040", "story_v_out_105121.awb") ~= 0 then
					local var_171_16 = manager.audio:GetVoiceLength("story_v_out_105121", "105121040", "story_v_out_105121.awb") / 1000

					if var_171_16 + var_171_10 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_16 + var_171_10
					end

					if var_171_12.prefab_name ~= "" and arg_168_1.actors_[var_171_12.prefab_name] ~= nil then
						local var_171_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_12.prefab_name].transform, "story_v_out_105121", "105121040", "story_v_out_105121.awb")

						arg_168_1:RecordAudio("105121040", var_171_17)
						arg_168_1:RecordAudio("105121040", var_171_17)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_105121", "105121040", "story_v_out_105121.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_105121", "105121040", "story_v_out_105121.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_18 = math.max(var_171_11, arg_168_1.talkMaxDuration)

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_18 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_10) / var_171_18

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_10 + var_171_18 and arg_168_1.time_ < var_171_10 + var_171_18 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play105121041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 105121041
		arg_172_1.duration_ = 1.53

		local var_172_0 = {
			ja = 1.3,
			ko = 1.433,
			zh = 1.333,
			en = 1.533
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play105121042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10001_tpose"]) and arg_172_1.var_.characterEffect10001_tpose == nil then
				arg_172_1.var_.characterEffect10001_tpose = arg_172_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.1

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10001_tpose"]) then
				if arg_172_1.var_.characterEffect10001_tpose and not isNil(arg_172_1.actors_["10001_tpose"]) then
					arg_172_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10001_tpose"]) and arg_172_1.var_.characterEffect10001_tpose then
				arg_172_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_175_2 = arg_172_1.actors_["1019ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect1019ui_story == nil then
				arg_172_1.var_.characterEffect1019ui_story = var_175_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_3 = 0.1

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 and not isNil(var_175_2) then
				if arg_172_1.var_.characterEffect1019ui_story and not isNil(var_175_2) then
					arg_172_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_3)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect1019ui_story then
				arg_172_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_175_4 = 0
			local var_175_5 = 0.075

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_6 = arg_172_1:GetWordFromCfg(105121041)
				local var_175_7 = arg_172_1:FormatText(var_175_6.content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 3 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 3)

				if (3 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 3)) > 0 and var_175_5 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121041", "story_v_out_105121.awb") ~= 0 then
					local var_175_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121041", "story_v_out_105121.awb") / 1000

					if var_175_10 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_4
					end

					if var_175_6.prefab_name ~= "" and arg_172_1.actors_[var_175_6.prefab_name] ~= nil then
						local var_175_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_6.prefab_name].transform, "story_v_out_105121", "105121041", "story_v_out_105121.awb")

						arg_172_1:RecordAudio("105121041", var_175_11)
						arg_172_1:RecordAudio("105121041", var_175_11)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_105121", "105121041", "story_v_out_105121.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_105121", "105121041", "story_v_out_105121.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_12 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_12 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_12

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_12 and arg_172_1.time_ < var_175_4 + var_175_12 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play105121042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 105121042
		arg_176_1.duration_ = 8.23

		local var_176_0 = {
			ja = 4.466,
			ko = 8.233,
			zh = 7.366,
			en = 7.9
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play105121043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1036ui_story"]) and arg_176_1.var_.characterEffect1036ui_story == nil then
				arg_176_1.var_.characterEffect1036ui_story = arg_176_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.1

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1036ui_story"]) then
				if arg_176_1.var_.characterEffect1036ui_story and not isNil(arg_176_1.actors_["1036ui_story"]) then
					arg_176_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1036ui_story"]) and arg_176_1.var_.characterEffect1036ui_story then
				arg_176_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_179_2 = arg_176_1.actors_["10001_tpose"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.characterEffect10001_tpose == nil then
				arg_176_1.var_.characterEffect10001_tpose = var_179_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_3 = 0.1

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_3 and not isNil(var_179_2) then
				if arg_176_1.var_.characterEffect10001_tpose and not isNil(var_179_2) then
					arg_176_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_176_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_3)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_3 and arg_176_1.time_ < 0 + var_179_3 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.characterEffect10001_tpose then
				arg_176_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_176_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_179_4 = arg_176_1.actors_["1019ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1019ui_story = var_179_4.localPosition
			end

			local var_179_5 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_5 then
				var_179_4.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_176_1.time_ - 0) / var_179_5)
				var_179_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_4.position).x, (manager.ui.mainCamera.transform.position - var_179_4.position).y, (manager.ui.mainCamera.transform.position - var_179_4.position).z)
				var_179_4.localEulerAngles.z = 0
				var_179_4.localEulerAngles.x = 0
				var_179_4.localEulerAngles = var_179_4.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_5 and arg_176_1.time_ < 0 + var_179_5 + arg_179_0 then
				var_179_4.localPosition = Vector3.New(0, 100, 0)
				var_179_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_4.position).x, (manager.ui.mainCamera.transform.position - var_179_4.position).y, (manager.ui.mainCamera.transform.position - var_179_4.position).z)
				var_179_4.localEulerAngles.z = 0
				var_179_4.localEulerAngles.x = 0
				var_179_4.localEulerAngles = var_179_4.localEulerAngles
			end

			local var_179_6 = arg_176_1.actors_["1036ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1036ui_story = var_179_6.localPosition
			end

			local var_179_7 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				var_179_6.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_176_1.time_ - 0) / var_179_7)
				var_179_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_6.position).x, (manager.ui.mainCamera.transform.position - var_179_6.position).y, (manager.ui.mainCamera.transform.position - var_179_6.position).z)
				var_179_6.localEulerAngles.z = 0
				var_179_6.localEulerAngles.x = 0
				var_179_6.localEulerAngles = var_179_6.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				var_179_6.localPosition = Vector3.New(0, -1.09, -5.78)
				var_179_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_6.position).x, (manager.ui.mainCamera.transform.position - var_179_6.position).y, (manager.ui.mainCamera.transform.position - var_179_6.position).z)
				var_179_6.localEulerAngles.z = 0
				var_179_6.localEulerAngles.x = 0
				var_179_6.localEulerAngles = var_179_6.localEulerAngles
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_179_8 = 0
			local var_179_9 = 1.025

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_10 = arg_176_1:GetWordFromCfg(105121042)
				local var_179_11 = arg_176_1:FormatText(var_179_10.content)

				arg_176_1.text_.text = var_179_11

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_13 = 40 <= 0 and var_179_9 or var_179_9 * (utf8.len(var_179_11) / 40)

				if (40 <= 0 and var_179_9 or var_179_9 * (utf8.len(var_179_11) / 40)) > 0 and var_179_9 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_8
					end
				end

				arg_176_1.text_.text = var_179_11
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121042", "story_v_out_105121.awb") ~= 0 then
					local var_179_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121042", "story_v_out_105121.awb") / 1000

					if var_179_14 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_14 + var_179_8
					end

					if var_179_10.prefab_name ~= "" and arg_176_1.actors_[var_179_10.prefab_name] ~= nil then
						local var_179_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_10.prefab_name].transform, "story_v_out_105121", "105121042", "story_v_out_105121.awb")

						arg_176_1:RecordAudio("105121042", var_179_15)
						arg_176_1:RecordAudio("105121042", var_179_15)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_105121", "105121042", "story_v_out_105121.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_105121", "105121042", "story_v_out_105121.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_9, arg_176_1.talkMaxDuration)

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_8) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_8 + var_179_16 and arg_176_1.time_ < var_179_8 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play105121043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 105121043
		arg_180_1.duration_ = 8.5

		local var_180_0 = {
			ja = 7.533,
			ko = 7.833,
			zh = 8.5,
			en = 7.666
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play105121044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if arg_180_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_183_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_180_1.stage_.transform)

				var_183_0.name = "1027ui_story"
				var_183_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_180_1.actors_["1027ui_story"] = var_183_0

				local var_183_1 = var_183_0:GetComponentInChildren(typeof(CharacterEffect))

				var_183_1.enabled = true

				local var_183_2 = GameObjectTools.GetOrAddComponent(var_183_0, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(false)
				end

				arg_180_1:ShowWeapon(var_183_1.transform, false)

				arg_180_1.var_["1027ui_story" .. "Animator"] = var_183_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_180_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_180_1.var_["1027ui_story" .. "LipSync"] = var_183_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_183_3 = arg_180_1.actors_["1027ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect1027ui_story == nil then
				arg_180_1.var_.characterEffect1027ui_story = var_183_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_4 = 0.1

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 and not isNil(var_183_3) then
				if arg_180_1.var_.characterEffect1027ui_story and not isNil(var_183_3) then
					arg_180_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect1027ui_story then
				arg_180_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_183_6 = arg_180_1.actors_["1036ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_6) and arg_180_1.var_.characterEffect1036ui_story == nil then
				arg_180_1.var_.characterEffect1036ui_story = var_183_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_7 = 0.1

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 and not isNil(var_183_6) then
				if arg_180_1.var_.characterEffect1036ui_story and not isNil(var_183_6) then
					arg_180_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_7)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 and not isNil(var_183_6) and arg_180_1.var_.characterEffect1036ui_story then
				arg_180_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_183_8 = arg_180_1.actors_["1036ui_story"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1036ui_story = var_183_8.localPosition
			end

			local var_183_9 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_9 then
				var_183_8.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_180_1.time_ - 0) / var_183_9)
				var_183_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_8.position).x, (manager.ui.mainCamera.transform.position - var_183_8.position).y, (manager.ui.mainCamera.transform.position - var_183_8.position).z)
				var_183_8.localEulerAngles.z = 0
				var_183_8.localEulerAngles.x = 0
				var_183_8.localEulerAngles = var_183_8.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_9 and arg_180_1.time_ < 0 + var_183_9 + arg_183_0 then
				var_183_8.localPosition = Vector3.New(0, -1.09, -5.78)
				var_183_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_8.position).x, (manager.ui.mainCamera.transform.position - var_183_8.position).y, (manager.ui.mainCamera.transform.position - var_183_8.position).z)
				var_183_8.localEulerAngles.z = 0
				var_183_8.localEulerAngles.x = 0
				var_183_8.localEulerAngles = var_183_8.localEulerAngles
			end

			local var_183_10 = arg_180_1.actors_["1036ui_story"].transform

			if 0.033 < arg_180_1.time_ and arg_180_1.time_ <= 0.033 + arg_183_0 then
				arg_180_1.var_.moveOldPos1036ui_story = var_183_10.localPosition
			end

			local var_183_11 = 0.5

			if 0.033 <= arg_180_1.time_ and arg_180_1.time_ < 0.033 + var_183_11 then
				var_183_10.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1036ui_story, Vector3.New(0.7, -1.09, -5.78), (arg_180_1.time_ - 0.033) / var_183_11)
				var_183_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_10.position).x, (manager.ui.mainCamera.transform.position - var_183_10.position).y, (manager.ui.mainCamera.transform.position - var_183_10.position).z)
				var_183_10.localEulerAngles.z = 0
				var_183_10.localEulerAngles.x = 0
				var_183_10.localEulerAngles = var_183_10.localEulerAngles
			end

			if arg_180_1.time_ >= 0.033 + var_183_11 and arg_180_1.time_ < 0.033 + var_183_11 + arg_183_0 then
				var_183_10.localPosition = Vector3.New(0.7, -1.09, -5.78)
				var_183_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_10.position).x, (manager.ui.mainCamera.transform.position - var_183_10.position).y, (manager.ui.mainCamera.transform.position - var_183_10.position).z)
				var_183_10.localEulerAngles.z = 0
				var_183_10.localEulerAngles.x = 0
				var_183_10.localEulerAngles = var_183_10.localEulerAngles
			end

			local var_183_12 = arg_180_1.actors_["1027ui_story"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1027ui_story = var_183_12.localPosition
			end

			local var_183_13 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_13 then
				var_183_12.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_180_1.time_ - 0) / var_183_13)
				var_183_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_12.position).x, (manager.ui.mainCamera.transform.position - var_183_12.position).y, (manager.ui.mainCamera.transform.position - var_183_12.position).z)
				var_183_12.localEulerAngles.z = 0
				var_183_12.localEulerAngles.x = 0
				var_183_12.localEulerAngles = var_183_12.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_13 and arg_180_1.time_ < 0 + var_183_13 + arg_183_0 then
				var_183_12.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_183_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_12.position).x, (manager.ui.mainCamera.transform.position - var_183_12.position).y, (manager.ui.mainCamera.transform.position - var_183_12.position).z)
				var_183_12.localEulerAngles.z = 0
				var_183_12.localEulerAngles.x = 0
				var_183_12.localEulerAngles = var_183_12.localEulerAngles
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_183_14 = 0
			local var_183_15 = 0.925

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_16 = arg_180_1:GetWordFromCfg(105121043)
				local var_183_17 = arg_180_1:FormatText(var_183_16.content)

				arg_180_1.text_.text = var_183_17

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_19 = 37 <= 0 and var_183_15 or var_183_15 * (utf8.len(var_183_17) / 37)

				if (37 <= 0 and var_183_15 or var_183_15 * (utf8.len(var_183_17) / 37)) > 0 and var_183_15 < var_183_19 then
					arg_180_1.talkMaxDuration = var_183_19

					if var_183_19 + var_183_14 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_19 + var_183_14
					end
				end

				arg_180_1.text_.text = var_183_17
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121043", "story_v_out_105121.awb") ~= 0 then
					local var_183_20 = manager.audio:GetVoiceLength("story_v_out_105121", "105121043", "story_v_out_105121.awb") / 1000

					if var_183_20 + var_183_14 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_20 + var_183_14
					end

					if var_183_16.prefab_name ~= "" and arg_180_1.actors_[var_183_16.prefab_name] ~= nil then
						local var_183_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_16.prefab_name].transform, "story_v_out_105121", "105121043", "story_v_out_105121.awb")

						arg_180_1:RecordAudio("105121043", var_183_21)
						arg_180_1:RecordAudio("105121043", var_183_21)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_105121", "105121043", "story_v_out_105121.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_105121", "105121043", "story_v_out_105121.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_22 = math.max(var_183_15, arg_180_1.talkMaxDuration)

			if var_183_14 <= arg_180_1.time_ and arg_180_1.time_ < var_183_14 + var_183_22 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_14) / var_183_22

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_14 + var_183_22 and arg_180_1.time_ < var_183_14 + var_183_22 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play105121044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 105121044
		arg_184_1.duration_ = 7.1

		local var_184_0 = {
			ja = 7.1,
			ko = 3.7,
			zh = 3.366,
			en = 3.033
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play105121045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1148ui_story"]) and arg_184_1.var_.characterEffect1148ui_story == nil then
				arg_184_1.var_.characterEffect1148ui_story = arg_184_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.1

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1148ui_story"]) then
				if arg_184_1.var_.characterEffect1148ui_story and not isNil(arg_184_1.actors_["1148ui_story"]) then
					arg_184_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1148ui_story"]) and arg_184_1.var_.characterEffect1148ui_story then
				arg_184_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_187_2 = arg_184_1.actors_["1027ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.characterEffect1027ui_story == nil then
				arg_184_1.var_.characterEffect1027ui_story = var_187_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_3 = 0.1

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 and not isNil(var_187_2) then
				if arg_184_1.var_.characterEffect1027ui_story and not isNil(var_187_2) then
					arg_184_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_3)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.characterEffect1027ui_story then
				arg_184_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_187_4 = arg_184_1.actors_["1036ui_story"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1036ui_story = var_187_4.localPosition
			end

			local var_187_5 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_5 then
				var_187_4.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_184_1.time_ - 0) / var_187_5)
				var_187_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_4.position).x, (manager.ui.mainCamera.transform.position - var_187_4.position).y, (manager.ui.mainCamera.transform.position - var_187_4.position).z)
				var_187_4.localEulerAngles.z = 0
				var_187_4.localEulerAngles.x = 0
				var_187_4.localEulerAngles = var_187_4.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_5 and arg_184_1.time_ < 0 + var_187_5 + arg_187_0 then
				var_187_4.localPosition = Vector3.New(0, 100, 0)
				var_187_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_4.position).x, (manager.ui.mainCamera.transform.position - var_187_4.position).y, (manager.ui.mainCamera.transform.position - var_187_4.position).z)
				var_187_4.localEulerAngles.z = 0
				var_187_4.localEulerAngles.x = 0
				var_187_4.localEulerAngles = var_187_4.localEulerAngles
			end

			local var_187_6 = arg_184_1.actors_["1148ui_story"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1148ui_story = var_187_6.localPosition
			end

			local var_187_7 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				var_187_6.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_184_1.time_ - 0) / var_187_7)
				var_187_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_6.position).x, (manager.ui.mainCamera.transform.position - var_187_6.position).y, (manager.ui.mainCamera.transform.position - var_187_6.position).z)
				var_187_6.localEulerAngles.z = 0
				var_187_6.localEulerAngles.x = 0
				var_187_6.localEulerAngles = var_187_6.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				var_187_6.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_187_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_6.position).x, (manager.ui.mainCamera.transform.position - var_187_6.position).y, (manager.ui.mainCamera.transform.position - var_187_6.position).z)
				var_187_6.localEulerAngles.z = 0
				var_187_6.localEulerAngles.x = 0
				var_187_6.localEulerAngles = var_187_6.localEulerAngles
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_187_8 = 0
			local var_187_9 = 0.4

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_10 = arg_184_1:GetWordFromCfg(105121044)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_13 = 16 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 16)

				if (16 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 16)) > 0 and var_187_9 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_8
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121044", "story_v_out_105121.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121044", "story_v_out_105121.awb") / 1000

					if var_187_14 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_8
					end

					if var_187_10.prefab_name ~= "" and arg_184_1.actors_[var_187_10.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_10.prefab_name].transform, "story_v_out_105121", "105121044", "story_v_out_105121.awb")

						arg_184_1:RecordAudio("105121044", var_187_15)
						arg_184_1:RecordAudio("105121044", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_105121", "105121044", "story_v_out_105121.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_105121", "105121044", "story_v_out_105121.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_9, arg_184_1.talkMaxDuration)

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_8) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_8 + var_187_16 and arg_184_1.time_ < var_187_8 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play105121045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 105121045
		arg_188_1.duration_ = 7.9

		local var_188_0 = {
			ja = 7.9,
			ko = 4.366,
			zh = 4.166,
			en = 4.966
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
				arg_188_0:Play105121046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1027ui_story"]) and arg_188_1.var_.characterEffect1027ui_story == nil then
				arg_188_1.var_.characterEffect1027ui_story = arg_188_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.1

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1027ui_story"]) then
				if arg_188_1.var_.characterEffect1027ui_story and not isNil(arg_188_1.actors_["1027ui_story"]) then
					arg_188_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1027ui_story"]) and arg_188_1.var_.characterEffect1027ui_story then
				arg_188_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_191_2 = arg_188_1.actors_["1148ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.characterEffect1148ui_story == nil then
				arg_188_1.var_.characterEffect1148ui_story = var_191_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_3 = 0.1

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.characterEffect1148ui_story and not isNil(var_191_2) then
					arg_188_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_3)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.characterEffect1148ui_story then
				arg_188_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action472")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_191_4 = 0
			local var_191_5 = 0.475

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_6 = arg_188_1:GetWordFromCfg(105121045)
				local var_191_7 = arg_188_1:FormatText(var_191_6.content)

				arg_188_1.text_.text = var_191_7

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_9 = 19 <= 0 and var_191_5 or var_191_5 * (utf8.len(var_191_7) / 19)

				if (19 <= 0 and var_191_5 or var_191_5 * (utf8.len(var_191_7) / 19)) > 0 and var_191_5 < var_191_9 then
					arg_188_1.talkMaxDuration = var_191_9

					if var_191_9 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_4
					end
				end

				arg_188_1.text_.text = var_191_7
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121045", "story_v_out_105121.awb") ~= 0 then
					local var_191_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121045", "story_v_out_105121.awb") / 1000

					if var_191_10 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_4
					end

					if var_191_6.prefab_name ~= "" and arg_188_1.actors_[var_191_6.prefab_name] ~= nil then
						local var_191_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_6.prefab_name].transform, "story_v_out_105121", "105121045", "story_v_out_105121.awb")

						arg_188_1:RecordAudio("105121045", var_191_11)
						arg_188_1:RecordAudio("105121045", var_191_11)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_105121", "105121045", "story_v_out_105121.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_105121", "105121045", "story_v_out_105121.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_12 = math.max(var_191_5, arg_188_1.talkMaxDuration)

			if var_191_4 <= arg_188_1.time_ and arg_188_1.time_ < var_191_4 + var_191_12 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_4) / var_191_12

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_4 + var_191_12 and arg_188_1.time_ < var_191_4 + var_191_12 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play105121046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 105121046
		arg_192_1.duration_ = 9.27

		local var_192_0 = {
			ja = 9.266,
			ko = 8.266,
			zh = 7.666,
			en = 8.133
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
				arg_192_0:Play105121047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1148ui_story"]) and arg_192_1.var_.characterEffect1148ui_story == nil then
				arg_192_1.var_.characterEffect1148ui_story = arg_192_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.1

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1148ui_story"]) then
				if arg_192_1.var_.characterEffect1148ui_story and not isNil(arg_192_1.actors_["1148ui_story"]) then
					arg_192_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1148ui_story"]) and arg_192_1.var_.characterEffect1148ui_story then
				arg_192_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_195_2 = arg_192_1.actors_["1027ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect1027ui_story == nil then
				arg_192_1.var_.characterEffect1027ui_story = var_195_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_3 = 0.1

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.characterEffect1027ui_story and not isNil(var_195_2) then
					arg_192_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_3)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect1027ui_story then
				arg_192_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action426")
			end

			local var_195_4 = 0
			local var_195_5 = 0.875

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:GetWordFromCfg(105121046)
				local var_195_7 = arg_192_1:FormatText(var_195_6.content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 35 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 35)

				if (35 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 35)) > 0 and var_195_5 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121046", "story_v_out_105121.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121046", "story_v_out_105121.awb") / 1000

					if var_195_10 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_4
					end

					if var_195_6.prefab_name ~= "" and arg_192_1.actors_[var_195_6.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_6.prefab_name].transform, "story_v_out_105121", "105121046", "story_v_out_105121.awb")

						arg_192_1:RecordAudio("105121046", var_195_11)
						arg_192_1:RecordAudio("105121046", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_105121", "105121046", "story_v_out_105121.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_105121", "105121046", "story_v_out_105121.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_12 = math.max(var_195_5, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_12 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_4) / var_195_12

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_12 and arg_192_1.time_ < var_195_4 + var_195_12 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play105121047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 105121047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play105121048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1148ui_story"]) and arg_196_1.var_.characterEffect1148ui_story == nil then
				arg_196_1.var_.characterEffect1148ui_story = arg_196_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.1

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1148ui_story"]) then
				if arg_196_1.var_.characterEffect1148ui_story and not isNil(arg_196_1.actors_["1148ui_story"]) then
					arg_196_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_0)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1148ui_story"]) and arg_196_1.var_.characterEffect1148ui_story then
				arg_196_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_199_1 = 0
			local var_199_2 = 0.05

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_3 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(105121047).content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 2 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_3) / 2)

				if (2 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_3) / 2)) > 0 and var_199_2 < var_199_5 then
					arg_196_1.talkMaxDuration = var_199_5

					if var_199_5 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + var_199_1
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_6 = math.max(var_199_2, arg_196_1.talkMaxDuration)

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_6 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_1) / var_199_6

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_1 + var_199_6 and arg_196_1.time_ < var_199_1 + var_199_6 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play105121048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 105121048
		arg_200_1.duration_ = 6.87

		local var_200_0 = {
			ja = 6.866,
			ko = 4.566,
			zh = 5.033,
			en = 6.066
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
				arg_200_0:Play105121049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1019ui_story"]) and arg_200_1.var_.characterEffect1019ui_story == nil then
				arg_200_1.var_.characterEffect1019ui_story = arg_200_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.1

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1019ui_story"]) then
				if arg_200_1.var_.characterEffect1019ui_story and not isNil(arg_200_1.actors_["1019ui_story"]) then
					arg_200_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1019ui_story"]) and arg_200_1.var_.characterEffect1019ui_story then
				arg_200_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_203_2 = arg_200_1.actors_["1148ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1148ui_story = var_203_2.localPosition
			end

			local var_203_3 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 then
				var_203_2.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_200_1.time_ - 0) / var_203_3)
				var_203_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_2.position).x, (manager.ui.mainCamera.transform.position - var_203_2.position).y, (manager.ui.mainCamera.transform.position - var_203_2.position).z)
				var_203_2.localEulerAngles.z = 0
				var_203_2.localEulerAngles.x = 0
				var_203_2.localEulerAngles = var_203_2.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 then
				var_203_2.localPosition = Vector3.New(0, 100, 0)
				var_203_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_2.position).x, (manager.ui.mainCamera.transform.position - var_203_2.position).y, (manager.ui.mainCamera.transform.position - var_203_2.position).z)
				var_203_2.localEulerAngles.z = 0
				var_203_2.localEulerAngles.x = 0
				var_203_2.localEulerAngles = var_203_2.localEulerAngles
			end

			local var_203_4 = arg_200_1.actors_["1027ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1027ui_story = var_203_4.localPosition
			end

			local var_203_5 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_5 then
				var_203_4.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_200_1.time_ - 0) / var_203_5)
				var_203_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_4.position).x, (manager.ui.mainCamera.transform.position - var_203_4.position).y, (manager.ui.mainCamera.transform.position - var_203_4.position).z)
				var_203_4.localEulerAngles.z = 0
				var_203_4.localEulerAngles.x = 0
				var_203_4.localEulerAngles = var_203_4.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_5 and arg_200_1.time_ < 0 + var_203_5 + arg_203_0 then
				var_203_4.localPosition = Vector3.New(0, 100, 0)
				var_203_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_4.position).x, (manager.ui.mainCamera.transform.position - var_203_4.position).y, (manager.ui.mainCamera.transform.position - var_203_4.position).z)
				var_203_4.localEulerAngles.z = 0
				var_203_4.localEulerAngles.x = 0
				var_203_4.localEulerAngles = var_203_4.localEulerAngles
			end

			local var_203_6 = arg_200_1.actors_["1019ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1019ui_story = var_203_6.localPosition
			end

			local var_203_7 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				var_203_6.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_200_1.time_ - 0) / var_203_7)
				var_203_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_6.position).x, (manager.ui.mainCamera.transform.position - var_203_6.position).y, (manager.ui.mainCamera.transform.position - var_203_6.position).z)
				var_203_6.localEulerAngles.z = 0
				var_203_6.localEulerAngles.x = 0
				var_203_6.localEulerAngles = var_203_6.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				var_203_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_203_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_6.position).x, (manager.ui.mainCamera.transform.position - var_203_6.position).y, (manager.ui.mainCamera.transform.position - var_203_6.position).z)
				var_203_6.localEulerAngles.z = 0
				var_203_6.localEulerAngles.x = 0
				var_203_6.localEulerAngles = var_203_6.localEulerAngles
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_203_8 = 0
			local var_203_9 = 0.6

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_10 = arg_200_1:GetWordFromCfg(105121048)
				local var_203_11 = arg_200_1:FormatText(var_203_10.content)

				arg_200_1.text_.text = var_203_11

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_13 = 24 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_11) / 24)

				if (24 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_11) / 24)) > 0 and var_203_9 < var_203_13 then
					arg_200_1.talkMaxDuration = var_203_13

					if var_203_13 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_13 + var_203_8
					end
				end

				arg_200_1.text_.text = var_203_11
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121048", "story_v_out_105121.awb") ~= 0 then
					local var_203_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121048", "story_v_out_105121.awb") / 1000

					if var_203_14 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_8
					end

					if var_203_10.prefab_name ~= "" and arg_200_1.actors_[var_203_10.prefab_name] ~= nil then
						local var_203_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_10.prefab_name].transform, "story_v_out_105121", "105121048", "story_v_out_105121.awb")

						arg_200_1:RecordAudio("105121048", var_203_15)
						arg_200_1:RecordAudio("105121048", var_203_15)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_105121", "105121048", "story_v_out_105121.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_105121", "105121048", "story_v_out_105121.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_9, arg_200_1.talkMaxDuration)

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_8) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_8 + var_203_16 and arg_200_1.time_ < var_203_8 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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

		arg_200_1:InitPlayNodeList()
	end,
	Play105121049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 105121049
		arg_204_1.duration_ = 3.27

		local var_204_0 = {
			ja = 3.266,
			ko = 2,
			zh = 2.066,
			en = 2.3
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play105121050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) and arg_204_1.var_.characterEffect1019ui_story == nil then
				arg_204_1.var_.characterEffect1019ui_story = arg_204_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.1

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) then
				if arg_204_1.var_.characterEffect1019ui_story and not isNil(arg_204_1.actors_["1019ui_story"]) then
					arg_204_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_0)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1019ui_story"]) and arg_204_1.var_.characterEffect1019ui_story then
				arg_204_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_207_1 = arg_204_1.actors_["1019ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1019ui_story = var_207_1.localPosition
			end

			local var_207_2 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_2 then
				var_207_1.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_204_1.time_ - 0) / var_207_2)
				var_207_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_1.position).x, (manager.ui.mainCamera.transform.position - var_207_1.position).y, (manager.ui.mainCamera.transform.position - var_207_1.position).z)
				var_207_1.localEulerAngles.z = 0
				var_207_1.localEulerAngles.x = 0
				var_207_1.localEulerAngles = var_207_1.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_2 and arg_204_1.time_ < 0 + var_207_2 + arg_207_0 then
				var_207_1.localPosition = Vector3.New(0, 100, 0)
				var_207_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_1.position).x, (manager.ui.mainCamera.transform.position - var_207_1.position).y, (manager.ui.mainCamera.transform.position - var_207_1.position).z)
				var_207_1.localEulerAngles.z = 0
				var_207_1.localEulerAngles.x = 0
				var_207_1.localEulerAngles = var_207_1.localEulerAngles
			end

			local var_207_3 = 0
			local var_207_4 = 0.175

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_3 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_5 = arg_204_1:GetWordFromCfg(105121049)
				local var_207_6 = arg_204_1:FormatText(var_207_5.content)

				arg_204_1.text_.text = var_207_6

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_8 = 7 <= 0 and var_207_4 or var_207_4 * (utf8.len(var_207_6) / 7)

				if (7 <= 0 and var_207_4 or var_207_4 * (utf8.len(var_207_6) / 7)) > 0 and var_207_4 < var_207_8 then
					arg_204_1.talkMaxDuration = var_207_8

					if var_207_8 + var_207_3 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_3
					end
				end

				arg_204_1.text_.text = var_207_6
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121049", "story_v_out_105121.awb") ~= 0 then
					local var_207_9 = manager.audio:GetVoiceLength("story_v_out_105121", "105121049", "story_v_out_105121.awb") / 1000

					if var_207_9 + var_207_3 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_3
					end

					if var_207_5.prefab_name ~= "" and arg_204_1.actors_[var_207_5.prefab_name] ~= nil then
						local var_207_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_5.prefab_name].transform, "story_v_out_105121", "105121049", "story_v_out_105121.awb")

						arg_204_1:RecordAudio("105121049", var_207_10)
						arg_204_1:RecordAudio("105121049", var_207_10)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_105121", "105121049", "story_v_out_105121.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_105121", "105121049", "story_v_out_105121.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_11 = math.max(var_207_4, arg_204_1.talkMaxDuration)

			if var_207_3 <= arg_204_1.time_ and arg_204_1.time_ < var_207_3 + var_207_11 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_3) / var_207_11

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_3 + var_207_11 and arg_204_1.time_ < var_207_3 + var_207_11 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play105121050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 105121050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play105121051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 1.425

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(105121050).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 56 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 56)

				if (56 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 56)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play105121051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 105121051
		arg_212_1.duration_ = 5.43

		local var_212_0 = {
			ja = 5.433,
			ko = 4,
			zh = 4.1,
			en = 4.066
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play105121052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if arg_212_1.actors_["1013ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1013ui_story"))) then
				local var_215_0 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_212_1.stage_.transform)

				var_215_0.name = "1013ui_story"
				var_215_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["1013ui_story"] = var_215_0

				local var_215_1 = var_215_0:GetComponentInChildren(typeof(CharacterEffect))

				var_215_1.enabled = true

				local var_215_2 = GameObjectTools.GetOrAddComponent(var_215_0, typeof(DynamicBoneHelper))

				if var_215_2 then
					var_215_2:EnableDynamicBone(false)
				end

				arg_212_1:ShowWeapon(var_215_1.transform, false)

				arg_212_1.var_["1013ui_story" .. "Animator"] = var_215_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_212_1.var_["1013ui_story" .. "Animator"].applyRootMotion = true
				arg_212_1.var_["1013ui_story" .. "LipSync"] = var_215_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_215_3 = arg_212_1.actors_["1013ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_3) and arg_212_1.var_.characterEffect1013ui_story == nil then
				arg_212_1.var_.characterEffect1013ui_story = var_215_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_4 = 0.1

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 and not isNil(var_215_3) then
				if arg_212_1.var_.characterEffect1013ui_story and not isNil(var_215_3) then
					arg_212_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 and not isNil(var_215_3) and arg_212_1.var_.characterEffect1013ui_story then
				arg_212_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_215_6 = arg_212_1.actors_["1013ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1013ui_story = var_215_6.localPosition
			end

			local var_215_7 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				var_215_6.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1013ui_story, Vector3.New(-0.7, -0.66, -6.15), (arg_212_1.time_ - 0) / var_215_7)
				var_215_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_6.position).x, (manager.ui.mainCamera.transform.position - var_215_6.position).y, (manager.ui.mainCamera.transform.position - var_215_6.position).z)
				var_215_6.localEulerAngles.z = 0
				var_215_6.localEulerAngles.x = 0
				var_215_6.localEulerAngles = var_215_6.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				var_215_6.localPosition = Vector3.New(-0.7, -0.66, -6.15)
				var_215_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_6.position).x, (manager.ui.mainCamera.transform.position - var_215_6.position).y, (manager.ui.mainCamera.transform.position - var_215_6.position).z)
				var_215_6.localEulerAngles.z = 0
				var_215_6.localEulerAngles.x = 0
				var_215_6.localEulerAngles = var_215_6.localEulerAngles
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action10_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_215_8 = 0
			local var_215_9 = 0.525

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(105121051)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 21 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 21)

				if (21 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 21)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121051", "story_v_out_105121.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_105121", "105121051", "story_v_out_105121.awb") / 1000

					if var_215_14 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_8
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_105121", "105121051", "story_v_out_105121.awb")

						arg_212_1:RecordAudio("105121051", var_215_15)
						arg_212_1:RecordAudio("105121051", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_105121", "105121051", "story_v_out_105121.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_105121", "105121051", "story_v_out_105121.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_8) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_8 + var_215_16 and arg_212_1.time_ < var_215_8 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play105121052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 105121052
		arg_216_1.duration_ = 2

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play105121053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1084ui_story"]) and arg_216_1.var_.characterEffect1084ui_story == nil then
				arg_216_1.var_.characterEffect1084ui_story = arg_216_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.1

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1084ui_story"]) then
				if arg_216_1.var_.characterEffect1084ui_story and not isNil(arg_216_1.actors_["1084ui_story"]) then
					arg_216_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1084ui_story"]) and arg_216_1.var_.characterEffect1084ui_story then
				arg_216_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_219_2 = arg_216_1.actors_["1013ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect1013ui_story == nil then
				arg_216_1.var_.characterEffect1013ui_story = var_219_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_3 = 0.1

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 and not isNil(var_219_2) then
				if arg_216_1.var_.characterEffect1013ui_story and not isNil(var_219_2) then
					arg_216_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_3)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect1013ui_story then
				arg_216_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_219_4 = arg_216_1.actors_["1084ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1084ui_story = var_219_4.localPosition
			end

			local var_219_5 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_5 then
				var_219_4.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_216_1.time_ - 0) / var_219_5)
				var_219_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_4.position).x, (manager.ui.mainCamera.transform.position - var_219_4.position).y, (manager.ui.mainCamera.transform.position - var_219_4.position).z)
				var_219_4.localEulerAngles.z = 0
				var_219_4.localEulerAngles.x = 0
				var_219_4.localEulerAngles = var_219_4.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_5 and arg_216_1.time_ < 0 + var_219_5 + arg_219_0 then
				var_219_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_219_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_4.position).x, (manager.ui.mainCamera.transform.position - var_219_4.position).y, (manager.ui.mainCamera.transform.position - var_219_4.position).z)
				var_219_4.localEulerAngles.z = 0
				var_219_4.localEulerAngles.x = 0
				var_219_4.localEulerAngles = var_219_4.localEulerAngles
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_219_6 = 0
			local var_219_7 = 0.125

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_8 = arg_216_1:GetWordFromCfg(105121052)
				local var_219_9 = arg_216_1:FormatText(var_219_8.content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 5 <= 0 and var_219_7 or var_219_7 * (utf8.len(var_219_9) / 5)

				if (5 <= 0 and var_219_7 or var_219_7 * (utf8.len(var_219_9) / 5)) > 0 and var_219_7 < var_219_11 then
					arg_216_1.talkMaxDuration = var_219_11

					if var_219_11 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_11 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121052", "story_v_out_105121.awb") ~= 0 then
					local var_219_12 = manager.audio:GetVoiceLength("story_v_out_105121", "105121052", "story_v_out_105121.awb") / 1000

					if var_219_12 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_6
					end

					if var_219_8.prefab_name ~= "" and arg_216_1.actors_[var_219_8.prefab_name] ~= nil then
						local var_219_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_8.prefab_name].transform, "story_v_out_105121", "105121052", "story_v_out_105121.awb")

						arg_216_1:RecordAudio("105121052", var_219_13)
						arg_216_1:RecordAudio("105121052", var_219_13)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_105121", "105121052", "story_v_out_105121.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_105121", "105121052", "story_v_out_105121.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_14 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_14 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_14

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_14 and arg_216_1.time_ < var_219_6 + var_219_14 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play105121053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 105121053
		arg_220_1.duration_ = 11.73

		local var_220_0 = {
			ja = 9.266,
			ko = 8.6,
			zh = 7.833,
			en = 11.733
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play105121054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if arg_220_1.actors_["10002ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10002ui_story"))) then
				local var_223_0 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_220_1.stage_.transform)

				var_223_0.name = "10002ui_story"
				var_223_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.actors_["10002ui_story"] = var_223_0

				local var_223_1 = var_223_0:GetComponentInChildren(typeof(CharacterEffect))

				var_223_1.enabled = true

				local var_223_2 = GameObjectTools.GetOrAddComponent(var_223_0, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(false)
				end

				arg_220_1:ShowWeapon(var_223_1.transform, false)

				arg_220_1.var_["10002ui_story" .. "Animator"] = var_223_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_220_1.var_["10002ui_story" .. "Animator"].applyRootMotion = true
				arg_220_1.var_["10002ui_story" .. "LipSync"] = var_223_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_223_3 = arg_220_1.actors_["10002ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect10002ui_story == nil then
				arg_220_1.var_.characterEffect10002ui_story = var_223_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_4 = 0.1

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 and not isNil(var_223_3) then
				if arg_220_1.var_.characterEffect10002ui_story and not isNil(var_223_3) then
					arg_220_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect10002ui_story then
				arg_220_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_223_6 = arg_220_1.actors_["1084ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_6) and arg_220_1.var_.characterEffect1084ui_story == nil then
				arg_220_1.var_.characterEffect1084ui_story = var_223_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_7 = 0.1

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 and not isNil(var_223_6) then
				if arg_220_1.var_.characterEffect1084ui_story and not isNil(var_223_6) then
					arg_220_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_7)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 and not isNil(var_223_6) and arg_220_1.var_.characterEffect1084ui_story then
				arg_220_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_223_8 = arg_220_1.actors_["1013ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1013ui_story = var_223_8.localPosition
			end

			local var_223_9 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_9 then
				var_223_8.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1013ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 0) / var_223_9)
				var_223_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_8.position).x, (manager.ui.mainCamera.transform.position - var_223_8.position).y, (manager.ui.mainCamera.transform.position - var_223_8.position).z)
				var_223_8.localEulerAngles.z = 0
				var_223_8.localEulerAngles.x = 0
				var_223_8.localEulerAngles = var_223_8.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_9 and arg_220_1.time_ < 0 + var_223_9 + arg_223_0 then
				var_223_8.localPosition = Vector3.New(0, 100, 0)
				var_223_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_8.position).x, (manager.ui.mainCamera.transform.position - var_223_8.position).y, (manager.ui.mainCamera.transform.position - var_223_8.position).z)
				var_223_8.localEulerAngles.z = 0
				var_223_8.localEulerAngles.x = 0
				var_223_8.localEulerAngles = var_223_8.localEulerAngles
			end

			local var_223_10 = arg_220_1.actors_["10002ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos10002ui_story = var_223_10.localPosition
			end

			local var_223_11 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_11 then
				var_223_10.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10002ui_story, Vector3.New(-0.7, -1.2, -5.8), (arg_220_1.time_ - 0) / var_223_11)
				var_223_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_10.position).x, (manager.ui.mainCamera.transform.position - var_223_10.position).y, (manager.ui.mainCamera.transform.position - var_223_10.position).z)
				var_223_10.localEulerAngles.z = 0
				var_223_10.localEulerAngles.x = 0
				var_223_10.localEulerAngles = var_223_10.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_11 and arg_220_1.time_ < 0 + var_223_11 + arg_223_0 then
				var_223_10.localPosition = Vector3.New(-0.7, -1.2, -5.8)
				var_223_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_10.position).x, (manager.ui.mainCamera.transform.position - var_223_10.position).y, (manager.ui.mainCamera.transform.position - var_223_10.position).z)
				var_223_10.localEulerAngles.z = 0
				var_223_10.localEulerAngles.x = 0
				var_223_10.localEulerAngles = var_223_10.localEulerAngles
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_12 = 0
			local var_223_13 = 0.75

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[72].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_14 = arg_220_1:GetWordFromCfg(105121053)
				local var_223_15 = arg_220_1:FormatText(var_223_14.content)

				arg_220_1.text_.text = var_223_15

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_17 = 30 <= 0 and var_223_13 or var_223_13 * (utf8.len(var_223_15) / 30)

				if (30 <= 0 and var_223_13 or var_223_13 * (utf8.len(var_223_15) / 30)) > 0 and var_223_13 < var_223_17 then
					arg_220_1.talkMaxDuration = var_223_17

					if var_223_17 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_17 + var_223_12
					end
				end

				arg_220_1.text_.text = var_223_15
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121053", "story_v_out_105121.awb") ~= 0 then
					local var_223_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121053", "story_v_out_105121.awb") / 1000

					if var_223_18 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_18 + var_223_12
					end

					if var_223_14.prefab_name ~= "" and arg_220_1.actors_[var_223_14.prefab_name] ~= nil then
						local var_223_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_14.prefab_name].transform, "story_v_out_105121", "105121053", "story_v_out_105121.awb")

						arg_220_1:RecordAudio("105121053", var_223_19)
						arg_220_1:RecordAudio("105121053", var_223_19)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_105121", "105121053", "story_v_out_105121.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_105121", "105121053", "story_v_out_105121.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_20 = math.max(var_223_13, arg_220_1.talkMaxDuration)

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_20 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_12) / var_223_20

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_12 + var_223_20 and arg_220_1.time_ < var_223_12 + var_223_20 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play105121054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 105121054
		arg_224_1.duration_ = 2.5

		local var_224_0 = {
			ja = 2.5,
			ko = 2.5,
			zh = 2.066,
			en = 2.033
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play105121055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1084ui_story"]) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = arg_224_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.1

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1084ui_story"]) then
				if arg_224_1.var_.characterEffect1084ui_story and not isNil(arg_224_1.actors_["1084ui_story"]) then
					arg_224_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1084ui_story"]) and arg_224_1.var_.characterEffect1084ui_story then
				arg_224_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_227_2 = arg_224_1.actors_["10002ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect10002ui_story == nil then
				arg_224_1.var_.characterEffect10002ui_story = var_227_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_3 = 0.1

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.characterEffect10002ui_story and not isNil(var_227_2) then
					arg_224_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_224_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_3)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.characterEffect10002ui_story then
				arg_224_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_224_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_227_4 = 0
			local var_227_5 = 0.225

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(105121054)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 9 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 9)

				if (9 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 9)) > 0 and var_227_5 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121054", "story_v_out_105121.awb") ~= 0 then
					local var_227_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121054", "story_v_out_105121.awb") / 1000

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end

					if var_227_6.prefab_name ~= "" and arg_224_1.actors_[var_227_6.prefab_name] ~= nil then
						local var_227_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_6.prefab_name].transform, "story_v_out_105121", "105121054", "story_v_out_105121.awb")

						arg_224_1:RecordAudio("105121054", var_227_11)
						arg_224_1:RecordAudio("105121054", var_227_11)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_105121", "105121054", "story_v_out_105121.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_105121", "105121054", "story_v_out_105121.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_12 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_12 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_12

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_12 and arg_224_1.time_ < var_227_4 + var_227_12 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play105121055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 105121055
		arg_228_1.duration_ = 7.5

		local var_228_0 = {
			ja = 6.033,
			ko = 5.3,
			zh = 5.2,
			en = 7.5
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play105121056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["10002ui_story"]) and arg_228_1.var_.characterEffect10002ui_story == nil then
				arg_228_1.var_.characterEffect10002ui_story = arg_228_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.1

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["10002ui_story"]) then
				if arg_228_1.var_.characterEffect10002ui_story and not isNil(arg_228_1.actors_["10002ui_story"]) then
					arg_228_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["10002ui_story"]) and arg_228_1.var_.characterEffect10002ui_story then
				arg_228_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_231_2 = arg_228_1.actors_["1084ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1084ui_story == nil then
				arg_228_1.var_.characterEffect1084ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.1

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect1084ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1084ui_story then
				arg_228_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_231_4 = 0
			local var_231_5 = 0.45

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[72].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(105121055)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 18 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 18)

				if (18 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 18)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121055", "story_v_out_105121.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121055", "story_v_out_105121.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_105121", "105121055", "story_v_out_105121.awb")

						arg_228_1:RecordAudio("105121055", var_231_11)
						arg_228_1:RecordAudio("105121055", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_105121", "105121055", "story_v_out_105121.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_105121", "105121055", "story_v_out_105121.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play105121056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 105121056
		arg_232_1.duration_ = 4.1

		local var_232_0 = {
			ja = 4.1,
			ko = 2.5,
			zh = 2.2,
			en = 1.999999999999
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play105121057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_235_0 = 0
			local var_235_1 = 0.15

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[72].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_2 = arg_232_1:GetWordFromCfg(105121056)
				local var_235_3 = arg_232_1:FormatText(var_235_2.content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 6 <= 0 and var_235_1 or var_235_1 * (utf8.len(var_235_3) / 6)

				if (6 <= 0 and var_235_1 or var_235_1 * (utf8.len(var_235_3) / 6)) > 0 and var_235_1 < var_235_5 then
					arg_232_1.talkMaxDuration = var_235_5

					if var_235_5 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121056", "story_v_out_105121.awb") ~= 0 then
					local var_235_6 = manager.audio:GetVoiceLength("story_v_out_105121", "105121056", "story_v_out_105121.awb") / 1000

					if var_235_6 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_0
					end

					if var_235_2.prefab_name ~= "" and arg_232_1.actors_[var_235_2.prefab_name] ~= nil then
						local var_235_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_2.prefab_name].transform, "story_v_out_105121", "105121056", "story_v_out_105121.awb")

						arg_232_1:RecordAudio("105121056", var_235_7)
						arg_232_1:RecordAudio("105121056", var_235_7)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_105121", "105121056", "story_v_out_105121.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_105121", "105121056", "story_v_out_105121.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_8 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_8 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_8

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_8 and arg_232_1.time_ < var_235_0 + var_235_8 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play105121057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 105121057
		arg_236_1.duration_ = 7.5

		local var_236_0 = {
			ja = 7.5,
			ko = 3.7,
			zh = 3.766,
			en = 4.833
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play105121058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["10001_tpose"]) and arg_236_1.var_.characterEffect10001_tpose == nil then
				arg_236_1.var_.characterEffect10001_tpose = arg_236_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_0 = 0.1

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["10001_tpose"]) then
				if arg_236_1.var_.characterEffect10001_tpose and not isNil(arg_236_1.actors_["10001_tpose"]) then
					arg_236_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["10001_tpose"]) and arg_236_1.var_.characterEffect10001_tpose then
				arg_236_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_239_2 = arg_236_1.actors_["10002ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.characterEffect10002ui_story == nil then
				arg_236_1.var_.characterEffect10002ui_story = var_239_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_3 = 0.1

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_3 and not isNil(var_239_2) then
				if arg_236_1.var_.characterEffect10002ui_story and not isNil(var_239_2) then
					arg_236_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_3)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_3 and arg_236_1.time_ < 0 + var_239_3 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.characterEffect10002ui_story then
				arg_236_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_239_4 = arg_236_1.actors_["1084ui_story"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1084ui_story = var_239_4.localPosition
			end

			local var_239_5 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_5 then
				var_239_4.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_5)
				var_239_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_4.position).x, (manager.ui.mainCamera.transform.position - var_239_4.position).y, (manager.ui.mainCamera.transform.position - var_239_4.position).z)
				var_239_4.localEulerAngles.z = 0
				var_239_4.localEulerAngles.x = 0
				var_239_4.localEulerAngles = var_239_4.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_5 and arg_236_1.time_ < 0 + var_239_5 + arg_239_0 then
				var_239_4.localPosition = Vector3.New(0, 100, 0)
				var_239_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_4.position).x, (manager.ui.mainCamera.transform.position - var_239_4.position).y, (manager.ui.mainCamera.transform.position - var_239_4.position).z)
				var_239_4.localEulerAngles.z = 0
				var_239_4.localEulerAngles.x = 0
				var_239_4.localEulerAngles = var_239_4.localEulerAngles
			end

			local var_239_6 = arg_236_1.actors_["10002ui_story"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10002ui_story = var_239_6.localPosition
			end

			local var_239_7 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				var_239_6.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_7)
				var_239_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_6.position).x, (manager.ui.mainCamera.transform.position - var_239_6.position).y, (manager.ui.mainCamera.transform.position - var_239_6.position).z)
				var_239_6.localEulerAngles.z = 0
				var_239_6.localEulerAngles.x = 0
				var_239_6.localEulerAngles = var_239_6.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				var_239_6.localPosition = Vector3.New(0, 100, 0)
				var_239_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_6.position).x, (manager.ui.mainCamera.transform.position - var_239_6.position).y, (manager.ui.mainCamera.transform.position - var_239_6.position).z)
				var_239_6.localEulerAngles.z = 0
				var_239_6.localEulerAngles.x = 0
				var_239_6.localEulerAngles = var_239_6.localEulerAngles
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action1_1")
			end

			local var_239_8 = arg_236_1.actors_["10001_tpose"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10001_tpose = var_239_8.localPosition

				local var_239_9 = GameObjectTools.GetOrAddComponent(var_239_8.gameObject, typeof(DynamicBoneHelper))

				if var_239_9 then
					var_239_9:EnableDynamicBone(false)
				end
			end

			local var_239_10 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_10 then
				var_239_8.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_236_1.time_ - 0) / var_239_10)
				var_239_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_8.position).x, (manager.ui.mainCamera.transform.position - var_239_8.position).y, (manager.ui.mainCamera.transform.position - var_239_8.position).z)
				var_239_8.localEulerAngles.z = 0
				var_239_8.localEulerAngles.x = 0
				var_239_8.localEulerAngles = var_239_8.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_10 and arg_236_1.time_ < 0 + var_239_10 + arg_239_0 then
				var_239_8.localPosition = Vector3.New(0, -1.23, -5.8)
				var_239_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_8.position).x, (manager.ui.mainCamera.transform.position - var_239_8.position).y, (manager.ui.mainCamera.transform.position - var_239_8.position).z)
				var_239_8.localEulerAngles.z = 0
				var_239_8.localEulerAngles.x = 0
				var_239_8.localEulerAngles = var_239_8.localEulerAngles

				local var_239_11 = GameObjectTools.GetOrAddComponent(var_239_8.gameObject, typeof(DynamicBoneHelper))

				if var_239_11 then
					var_239_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_239_12 = 0
			local var_239_13 = 0.225

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_12 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_14 = arg_236_1:GetWordFromCfg(105121057)
				local var_239_15 = arg_236_1:FormatText(var_239_14.content)

				arg_236_1.text_.text = var_239_15

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_17 = 9 <= 0 and var_239_13 or var_239_13 * (utf8.len(var_239_15) / 9)

				if (9 <= 0 and var_239_13 or var_239_13 * (utf8.len(var_239_15) / 9)) > 0 and var_239_13 < var_239_17 then
					arg_236_1.talkMaxDuration = var_239_17

					if var_239_17 + var_239_12 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_17 + var_239_12
					end
				end

				arg_236_1.text_.text = var_239_15
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121057", "story_v_out_105121.awb") ~= 0 then
					local var_239_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121057", "story_v_out_105121.awb") / 1000

					if var_239_18 + var_239_12 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_18 + var_239_12
					end

					if var_239_14.prefab_name ~= "" and arg_236_1.actors_[var_239_14.prefab_name] ~= nil then
						local var_239_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_14.prefab_name].transform, "story_v_out_105121", "105121057", "story_v_out_105121.awb")

						arg_236_1:RecordAudio("105121057", var_239_19)
						arg_236_1:RecordAudio("105121057", var_239_19)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_105121", "105121057", "story_v_out_105121.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_105121", "105121057", "story_v_out_105121.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_20 = math.max(var_239_13, arg_236_1.talkMaxDuration)

			if var_239_12 <= arg_236_1.time_ and arg_236_1.time_ < var_239_12 + var_239_20 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_12) / var_239_20

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_12 + var_239_20 and arg_236_1.time_ < var_239_12 + var_239_20 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play105121058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 105121058
		arg_240_1.duration_ = 1.33

		local var_240_0 = {
			ja = 0.766,
			ko = 1.266,
			zh = 1,
			en = 1.333
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play105121059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["1084ui_story"]) and arg_240_1.var_.characterEffect1084ui_story == nil then
				arg_240_1.var_.characterEffect1084ui_story = arg_240_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.1

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["1084ui_story"]) then
				if arg_240_1.var_.characterEffect1084ui_story and not isNil(arg_240_1.actors_["1084ui_story"]) then
					arg_240_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["1084ui_story"]) and arg_240_1.var_.characterEffect1084ui_story then
				arg_240_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_243_2 = arg_240_1.actors_["10001_tpose"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.characterEffect10001_tpose == nil then
				arg_240_1.var_.characterEffect10001_tpose = var_243_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_3 = 0.1

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_3 and not isNil(var_243_2) then
				if arg_240_1.var_.characterEffect10001_tpose and not isNil(var_243_2) then
					arg_240_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_240_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_3)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_3 and arg_240_1.time_ < 0 + var_243_3 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.characterEffect10001_tpose then
				arg_240_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_240_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_243_4 = 0
			local var_243_5 = 0.05

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_6 = arg_240_1:GetWordFromCfg(105121058)
				local var_243_7 = arg_240_1:FormatText(var_243_6.content)

				arg_240_1.text_.text = var_243_7

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 2 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 2)

				if (2 <= 0 and var_243_5 or var_243_5 * (utf8.len(var_243_7) / 2)) > 0 and var_243_5 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_4
					end
				end

				arg_240_1.text_.text = var_243_7
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121058", "story_v_out_105121.awb") ~= 0 then
					local var_243_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121058", "story_v_out_105121.awb") / 1000

					if var_243_10 + var_243_4 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_4
					end

					if var_243_6.prefab_name ~= "" and arg_240_1.actors_[var_243_6.prefab_name] ~= nil then
						local var_243_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_6.prefab_name].transform, "story_v_out_105121", "105121058", "story_v_out_105121.awb")

						arg_240_1:RecordAudio("105121058", var_243_11)
						arg_240_1:RecordAudio("105121058", var_243_11)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_105121", "105121058", "story_v_out_105121.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_105121", "105121058", "story_v_out_105121.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_12 = math.max(var_243_5, arg_240_1.talkMaxDuration)

			if var_243_4 <= arg_240_1.time_ and arg_240_1.time_ < var_243_4 + var_243_12 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_4) / var_243_12

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_4 + var_243_12 and arg_240_1.time_ < var_243_4 + var_243_12 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play105121059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 105121059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play105121060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1019ui_story"]) and arg_244_1.var_.characterEffect1019ui_story == nil then
				arg_244_1.var_.characterEffect1019ui_story = arg_244_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.1

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1019ui_story"]) then
				if arg_244_1.var_.characterEffect1019ui_story and not isNil(arg_244_1.actors_["1019ui_story"]) then
					arg_244_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1019ui_story"]) and arg_244_1.var_.characterEffect1019ui_story then
				arg_244_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_247_2 = arg_244_1.actors_["1084ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.characterEffect1084ui_story == nil then
				arg_244_1.var_.characterEffect1084ui_story = var_247_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_3 = 0.1

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.characterEffect1084ui_story and not isNil(var_247_2) then
					arg_244_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_3)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.characterEffect1084ui_story then
				arg_244_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_247_4 = 0
			local var_247_5 = 0.075

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_6 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(105121059).content)

				arg_244_1.text_.text = var_247_6

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_8 = 3 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_6) / 3)

				if (3 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_6) / 3)) > 0 and var_247_5 < var_247_8 then
					arg_244_1.talkMaxDuration = var_247_8

					if var_247_8 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_6
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_9 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_9 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_9

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_9 and arg_244_1.time_ < var_247_4 + var_247_9 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play105121060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 105121060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play105121061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.25

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(105121060).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 10 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 10)

				if (10 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 10)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play105121061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 105121061
		arg_252_1.duration_ = 1.77

		local var_252_0 = {
			ja = 0.933,
			ko = 1.766,
			zh = 0.9,
			en = 0.933
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play105121062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_0 = 0.5

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				local var_255_1 = Color.New(1, 1, 1)

				var_255_1.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.mask_.color = var_255_1
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				local var_255_2 = Color.New(1, 1, 1)

				arg_252_1.mask_.enabled = false
				var_255_2.a = 0
				arg_252_1.mask_.color = var_255_2
			end

			local var_255_3 = manager.ui.mainCamera.transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.shakeOldPosMainCamera = var_255_3.localPosition
			end

			local var_255_4 = 0.600000023841858

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				local var_255_5, var_255_6 = math.modf((arg_252_1.time_ - 0) / 0.066)

				var_255_3.localPosition = Vector3.New(var_255_6 * 0.13, var_255_6 * 0.13, var_255_6 * 0.13) + arg_252_1.var_.shakeOldPosMainCamera
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				var_255_3.localPosition = arg_252_1.var_.shakeOldPosMainCamera
			end

			local var_255_7 = 0
			local var_255_8 = 0.075

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_7 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_9 = arg_252_1:GetWordFromCfg(105121061)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_12 = 3 <= 0 and var_255_8 or var_255_8 * (utf8.len(var_255_10) / 3)

				if (3 <= 0 and var_255_8 or var_255_8 * (utf8.len(var_255_10) / 3)) > 0 and var_255_8 < var_255_12 then
					arg_252_1.talkMaxDuration = var_255_12

					if var_255_12 + var_255_7 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_7
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121061", "story_v_out_105121.awb") ~= 0 then
					local var_255_13 = manager.audio:GetVoiceLength("story_v_out_105121", "105121061", "story_v_out_105121.awb") / 1000

					if var_255_13 + var_255_7 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_7
					end

					if var_255_9.prefab_name ~= "" and arg_252_1.actors_[var_255_9.prefab_name] ~= nil then
						local var_255_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_9.prefab_name].transform, "story_v_out_105121", "105121061", "story_v_out_105121.awb")

						arg_252_1:RecordAudio("105121061", var_255_14)
						arg_252_1:RecordAudio("105121061", var_255_14)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_105121", "105121061", "story_v_out_105121.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_105121", "105121061", "story_v_out_105121.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_15 = math.max(var_255_8, arg_252_1.talkMaxDuration)

			if var_255_7 <= arg_252_1.time_ and arg_252_1.time_ < var_255_7 + var_255_15 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_7) / var_255_15

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_7 + var_255_15 and arg_252_1.time_ < var_255_7 + var_255_15 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play105121062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 105121062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play105121063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos10001_tpose = arg_256_1.actors_["10001_tpose"].transform.localPosition

				local var_259_0 = GameObjectTools.GetOrAddComponent(arg_256_1.actors_["10001_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_259_0 then
					var_259_0:EnableDynamicBone(false)
				end
			end

			local var_259_1 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_1 then
				arg_256_1.actors_["10001_tpose"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_256_1.time_ - 0) / var_259_1)
				arg_256_1.actors_["10001_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["10001_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10001_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10001_tpose"].transform.position).z)
				arg_256_1.actors_["10001_tpose"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["10001_tpose"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["10001_tpose"].transform.localEulerAngles = arg_256_1.actors_["10001_tpose"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_1 and arg_256_1.time_ < 0 + var_259_1 + arg_259_0 then
				arg_256_1.actors_["10001_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.actors_["10001_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["10001_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10001_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["10001_tpose"].transform.position).z)
				arg_256_1.actors_["10001_tpose"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["10001_tpose"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["10001_tpose"].transform.localEulerAngles = arg_256_1.actors_["10001_tpose"].transform.localEulerAngles

				local var_259_2 = GameObjectTools.GetOrAddComponent(arg_256_1.actors_["10001_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(true)
				end
			end

			local var_259_3 = 0
			local var_259_4 = 1.55

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_3 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_5 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(105121062).content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 62 <= 0 and var_259_4 or var_259_4 * (utf8.len(var_259_5) / 62)

				if (62 <= 0 and var_259_4 or var_259_4 * (utf8.len(var_259_5) / 62)) > 0 and var_259_4 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_3 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_3
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_8 = math.max(var_259_4, arg_256_1.talkMaxDuration)

			if var_259_3 <= arg_256_1.time_ and arg_256_1.time_ < var_259_3 + var_259_8 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_3) / var_259_8

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_3 + var_259_8 and arg_256_1.time_ < var_259_3 + var_259_8 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play105121063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 105121063
		arg_260_1.duration_ = 2.57

		local var_260_0 = {
			ja = 1.233,
			ko = 2.4,
			zh = 2.566,
			en = 1.5
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play105121064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1019ui_story"]) and arg_260_1.var_.characterEffect1019ui_story == nil then
				arg_260_1.var_.characterEffect1019ui_story = arg_260_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.1

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1019ui_story"]) then
				if arg_260_1.var_.characterEffect1019ui_story and not isNil(arg_260_1.actors_["1019ui_story"]) then
					arg_260_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_0)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1019ui_story"]) and arg_260_1.var_.characterEffect1019ui_story then
				arg_260_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_263_1 = 0
			local var_263_2 = 0.225

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_3 = arg_260_1:GetWordFromCfg(105121063)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_6 = 9 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_4) / 9)

				if (9 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_4) / 9)) > 0 and var_263_2 < var_263_6 then
					arg_260_1.talkMaxDuration = var_263_6

					if var_263_6 + var_263_1 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_6 + var_263_1
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121063", "story_v_out_105121.awb") ~= 0 then
					local var_263_7 = manager.audio:GetVoiceLength("story_v_out_105121", "105121063", "story_v_out_105121.awb") / 1000

					if var_263_7 + var_263_1 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_1
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_105121", "105121063", "story_v_out_105121.awb")

						arg_260_1:RecordAudio("105121063", var_263_8)
						arg_260_1:RecordAudio("105121063", var_263_8)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_105121", "105121063", "story_v_out_105121.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_105121", "105121063", "story_v_out_105121.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_9 = math.max(var_263_2, arg_260_1.talkMaxDuration)

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_9 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_1) / var_263_9

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_1 + var_263_9 and arg_260_1.time_ < var_263_1 + var_263_9 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play105121064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 105121064
		arg_264_1.duration_ = 3.67

		local var_264_0 = {
			ja = 3.466,
			ko = 3.233,
			zh = 3.666,
			en = 3.266
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play105121065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if arg_264_1.bgs_.S0504 == nil then
				local var_267_0 = Object.Instantiate(arg_264_1.paintGo_)

				var_267_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0504")
				var_267_0.name = "S0504"
				var_267_0.transform.parent = arg_264_1.stage_.transform
				var_267_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_264_1.bgs_.S0504 = var_267_0
			end

			if 1.5 < arg_264_1.time_ and arg_264_1.time_ <= 1.5 + arg_267_0 then
				local var_267_1 = arg_264_1.bgs_.S0504

				arg_264_1.bgs_.S0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_267_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_2 = var_267_1:GetComponent("SpriteRenderer")

				if var_267_2 and var_267_2.sprite then
					local var_267_3 = 2 * (var_267_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_267_1.transform.localScale = Vector3.New(var_267_3 / var_267_2.sprite.bounds.size.y < var_267_3 * manager.ui.mainCameraCom_.aspect / var_267_2.sprite.bounds.size.x and var_267_3 * manager.ui.mainCameraCom_.aspect / var_267_2.sprite.bounds.size.x or var_267_3 / var_267_2.sprite.bounds.size.y, var_267_3 / var_267_2.sprite.bounds.size.y < var_267_3 * manager.ui.mainCameraCom_.aspect / var_267_2.sprite.bounds.size.x and var_267_3 * manager.ui.mainCameraCom_.aspect / var_267_2.sprite.bounds.size.x or var_267_3 / var_267_2.sprite.bounds.size.y, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "S0504" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_4 = arg_264_1.bgs_.B01a.transform

			if 1.5 < arg_264_1.time_ and arg_264_1.time_ <= 1.5 + arg_267_0 then
				arg_264_1.var_.moveOldPosB01a = var_267_4.localPosition
			end

			local var_267_5 = 0.001

			if 1.5 <= arg_264_1.time_ and arg_264_1.time_ < 1.5 + var_267_5 then
				var_267_4.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPosB01a, Vector3.New(0, -100, 10), (arg_264_1.time_ - 1.5) / var_267_5)
			end

			if arg_264_1.time_ >= 1.5 + var_267_5 and arg_264_1.time_ < 1.5 + var_267_5 + arg_267_0 then
				var_267_4.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				local var_267_6 = arg_264_1.bgs_.B01a:GetComponent("SpriteRenderer")

				if var_267_6 then
					arg_264_1.var_.alphaOldValueB01a = var_267_6.color.a
					arg_264_1.var_.alphaMatValueB01a = var_267_6
				end

				arg_264_1.var_.alphaOldValueB01a = 1
			end

			local var_267_7 = 1.5

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				if arg_264_1.var_.alphaMatValueB01a then
					arg_264_1.var_.alphaMatValueB01a.color.a = Mathf.Lerp(arg_264_1.var_.alphaOldValueB01a, 0, (arg_264_1.time_ - 0) / var_267_7)
					arg_264_1.var_.alphaMatValueB01a.color = arg_264_1.var_.alphaMatValueB01a.color
				end
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 and arg_264_1.var_.alphaMatValueB01a then
				arg_264_1.var_.alphaMatValueB01a.color.a = 0
				arg_264_1.var_.alphaMatValueB01a.color = arg_264_1.var_.alphaMatValueB01a.color
			end

			if 1.5 < arg_264_1.time_ and arg_264_1.time_ <= 1.5 + arg_267_0 then
				local var_267_8 = arg_264_1.bgs_.S0504:GetComponent("SpriteRenderer")

				if var_267_8 then
					arg_264_1.var_.alphaOldValueS0504 = var_267_8.color.a
					arg_264_1.var_.alphaMatValueS0504 = var_267_8
				end

				arg_264_1.var_.alphaOldValueS0504 = 0
			end

			local var_267_9 = 1.5

			if 1.5 <= arg_264_1.time_ and arg_264_1.time_ < 1.5 + var_267_9 then
				if arg_264_1.var_.alphaMatValueS0504 then
					arg_264_1.var_.alphaMatValueS0504.color.a = Mathf.Lerp(arg_264_1.var_.alphaOldValueS0504, 1, (arg_264_1.time_ - 1.5) / var_267_9)
					arg_264_1.var_.alphaMatValueS0504.color = arg_264_1.var_.alphaMatValueS0504.color
				end
			end

			if arg_264_1.time_ >= 1.5 + var_267_9 and arg_264_1.time_ < 1.5 + var_267_9 + arg_267_0 and arg_264_1.var_.alphaMatValueS0504 then
				arg_264_1.var_.alphaMatValueS0504.color.a = 1
				arg_264_1.var_.alphaMatValueS0504.color = arg_264_1.var_.alphaMatValueS0504.color
			end

			local var_267_10 = 0

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_10 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			if arg_264_1.time_ >= var_267_10 + 1.5 and arg_264_1.time_ < var_267_10 + 1.5 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_11 = 2
			local var_267_12 = 0.15

			if 2 < arg_264_1.time_ and arg_264_1.time_ <= var_267_11 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_13 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_13:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_14 = arg_264_1:GetWordFromCfg(105121064)
				local var_267_15 = arg_264_1:FormatText(var_267_14.content)

				arg_264_1.text_.text = var_267_15

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_17 = 6 <= 0 and var_267_12 or var_267_12 * (utf8.len(var_267_15) / 6)

				if (6 <= 0 and var_267_12 or var_267_12 * (utf8.len(var_267_15) / 6)) > 0 and var_267_12 < var_267_17 then
					arg_264_1.talkMaxDuration = var_267_17
					var_267_11 = var_267_11 + 0.3

					if var_267_17 + var_267_11 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_17 + var_267_11
					end
				end

				arg_264_1.text_.text = var_267_15
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121064", "story_v_out_105121.awb") ~= 0 then
					local var_267_18 = manager.audio:GetVoiceLength("story_v_out_105121", "105121064", "story_v_out_105121.awb") / 1000

					if var_267_18 + var_267_11 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_18 + var_267_11
					end

					if var_267_14.prefab_name ~= "" and arg_264_1.actors_[var_267_14.prefab_name] ~= nil then
						local var_267_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_14.prefab_name].transform, "story_v_out_105121", "105121064", "story_v_out_105121.awb")

						arg_264_1:RecordAudio("105121064", var_267_19)
						arg_264_1:RecordAudio("105121064", var_267_19)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_105121", "105121064", "story_v_out_105121.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_105121", "105121064", "story_v_out_105121.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_20 = var_267_11 + 0.3
			local var_267_21 = math.max(var_267_12, arg_264_1.talkMaxDuration)

			if var_267_11 + 0.3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_20 + var_267_21 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_20) / var_267_21

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_20 + var_267_21 and arg_264_1.time_ < var_267_20 + var_267_21 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B01a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play105121065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 105121065
		arg_270_1.duration_ = 1.9

		local var_270_0 = {
			ja = 1.5,
			ko = 1.9,
			zh = 1.433,
			en = 1.3
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play105121066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.175

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:GetWordFromCfg(105121065)
				local var_273_2 = arg_270_1:FormatText(var_273_1.content)

				arg_270_1.text_.text = var_273_2

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 7 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 7)

				if (7 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 7)) > 0 and var_273_0 < var_273_4 then
					arg_270_1.talkMaxDuration = var_273_4

					if var_273_4 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_4 + 0
					end
				end

				arg_270_1.text_.text = var_273_2
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121065", "story_v_out_105121.awb") ~= 0 then
					local var_273_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121065", "story_v_out_105121.awb") / 1000

					if var_273_5 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + 0
					end

					if var_273_1.prefab_name ~= "" and arg_270_1.actors_[var_273_1.prefab_name] ~= nil then
						local var_273_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_1.prefab_name].transform, "story_v_out_105121", "105121065", "story_v_out_105121.awb")

						arg_270_1:RecordAudio("105121065", var_273_6)
						arg_270_1:RecordAudio("105121065", var_273_6)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_105121", "105121065", "story_v_out_105121.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_105121", "105121065", "story_v_out_105121.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play105121066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 105121066
		arg_274_1.duration_ = 2.43

		local var_274_0 = {
			ja = 1.533,
			ko = 1.333,
			zh = 1.233,
			en = 2.433
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play105121067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if arg_274_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_277_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_274_1.stage_.transform)

				var_277_0.name = "1080ui_story"
				var_277_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_["1080ui_story"] = var_277_0

				local var_277_1 = var_277_0:GetComponentInChildren(typeof(CharacterEffect))

				var_277_1.enabled = true

				local var_277_2 = GameObjectTools.GetOrAddComponent(var_277_0, typeof(DynamicBoneHelper))

				if var_277_2 then
					var_277_2:EnableDynamicBone(false)
				end

				arg_274_1:ShowWeapon(var_277_1.transform, false)

				arg_274_1.var_["1080ui_story" .. "Animator"] = var_277_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_274_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_274_1.var_["1080ui_story" .. "LipSync"] = var_277_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_277_3 = arg_274_1.actors_["1080ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_3) and arg_274_1.var_.characterEffect1080ui_story == nil then
				arg_274_1.var_.characterEffect1080ui_story = var_277_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_4 = 0.1

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 and not isNil(var_277_3) then
				if arg_274_1.var_.characterEffect1080ui_story and not isNil(var_277_3) then
					arg_274_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 and not isNil(var_277_3) and arg_274_1.var_.characterEffect1080ui_story then
				arg_274_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_277_6 = 0
			local var_277_7 = 0.25

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_8 = arg_274_1:GetWordFromCfg(105121066)
				local var_277_9 = arg_274_1:FormatText(var_277_8.content)

				arg_274_1.text_.text = var_277_9

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 6 <= 0 and var_277_7 or var_277_7 * (utf8.len(var_277_9) / 6)

				if (6 <= 0 and var_277_7 or var_277_7 * (utf8.len(var_277_9) / 6)) > 0 and var_277_7 < var_277_11 then
					arg_274_1.talkMaxDuration = var_277_11

					if var_277_11 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_11 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_9
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121066", "story_v_out_105121.awb") ~= 0 then
					local var_277_12 = manager.audio:GetVoiceLength("story_v_out_105121", "105121066", "story_v_out_105121.awb") / 1000

					if var_277_12 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_6
					end

					if var_277_8.prefab_name ~= "" and arg_274_1.actors_[var_277_8.prefab_name] ~= nil then
						local var_277_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_8.prefab_name].transform, "story_v_out_105121", "105121066", "story_v_out_105121.awb")

						arg_274_1:RecordAudio("105121066", var_277_13)
						arg_274_1:RecordAudio("105121066", var_277_13)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_105121", "105121066", "story_v_out_105121.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_105121", "105121066", "story_v_out_105121.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_14 and arg_274_1.time_ < var_277_6 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play105121067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 105121067
		arg_278_1.duration_ = 4.83

		local var_278_0 = {
			ja = 2.8,
			ko = 4.233,
			zh = 4.566,
			en = 4.833
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play105121068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.475

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:GetWordFromCfg(105121067)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 19 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 19)

				if (19 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 19)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121067", "story_v_out_105121.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121067", "story_v_out_105121.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_out_105121", "105121067", "story_v_out_105121.awb")

						arg_278_1:RecordAudio("105121067", var_281_6)
						arg_278_1:RecordAudio("105121067", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_105121", "105121067", "story_v_out_105121.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_105121", "105121067", "story_v_out_105121.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play105121068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 105121068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play105121069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1080ui_story"]) and arg_282_1.var_.characterEffect1080ui_story == nil then
				arg_282_1.var_.characterEffect1080ui_story = arg_282_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.1

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1080ui_story"]) then
				if arg_282_1.var_.characterEffect1080ui_story and not isNil(arg_282_1.actors_["1080ui_story"]) then
					arg_282_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_0)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1080ui_story"]) and arg_282_1.var_.characterEffect1080ui_story then
				arg_282_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_285_1 = 0
			local var_285_2 = 0.2

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(105121068).content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 8 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 8)

				if (8 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 8)) > 0 and var_285_2 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_6 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_6 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_6

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_6 and arg_282_1.time_ < var_285_1 + var_285_6 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play105121069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 105121069
		arg_286_1.duration_ = 7.83

		local var_286_0 = {
			ja = 5.6,
			ko = 7.833,
			zh = 6.2,
			en = 7.366
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play105121070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.575

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[72].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jolin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:GetWordFromCfg(105121069)
				local var_289_2 = arg_286_1:FormatText(var_289_1.content)

				arg_286_1.text_.text = var_289_2

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 25 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 25)

				if (25 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 25)) > 0 and var_289_0 < var_289_4 then
					arg_286_1.talkMaxDuration = var_289_4

					if var_289_4 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_4 + 0
					end
				end

				arg_286_1.text_.text = var_289_2
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121069", "story_v_out_105121.awb") ~= 0 then
					local var_289_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121069", "story_v_out_105121.awb") / 1000

					if var_289_5 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + 0
					end

					if var_289_1.prefab_name ~= "" and arg_286_1.actors_[var_289_1.prefab_name] ~= nil then
						local var_289_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_1.prefab_name].transform, "story_v_out_105121", "105121069", "story_v_out_105121.awb")

						arg_286_1:RecordAudio("105121069", var_289_6)
						arg_286_1:RecordAudio("105121069", var_289_6)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_105121", "105121069", "story_v_out_105121.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_105121", "105121069", "story_v_out_105121.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play105121070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 105121070
		arg_290_1.duration_ = 3.83

		local var_290_0 = {
			ja = 3.833,
			ko = 1.833,
			zh = 1.866,
			en = 1.666
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play105121071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.15

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_1 = arg_290_1:GetWordFromCfg(105121070)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.text_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 6 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 6)

				if (6 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 6)) > 0 and var_293_0 < var_293_4 then
					arg_290_1.talkMaxDuration = var_293_4

					if var_293_4 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_4 + 0
					end
				end

				arg_290_1.text_.text = var_293_2
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121070", "story_v_out_105121.awb") ~= 0 then
					local var_293_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121070", "story_v_out_105121.awb") / 1000

					if var_293_5 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + 0
					end

					if var_293_1.prefab_name ~= "" and arg_290_1.actors_[var_293_1.prefab_name] ~= nil then
						local var_293_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_1.prefab_name].transform, "story_v_out_105121", "105121070", "story_v_out_105121.awb")

						arg_290_1:RecordAudio("105121070", var_293_6)
						arg_290_1:RecordAudio("105121070", var_293_6)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_105121", "105121070", "story_v_out_105121.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_105121", "105121070", "story_v_out_105121.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play105121071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 105121071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play105121072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["10001_tpose"]) and arg_294_1.var_.characterEffect10001_tpose == nil then
				arg_294_1.var_.characterEffect10001_tpose = arg_294_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.1

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["10001_tpose"]) then
				if arg_294_1.var_.characterEffect10001_tpose and not isNil(arg_294_1.actors_["10001_tpose"]) then
					arg_294_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_294_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_0)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["10001_tpose"]) and arg_294_1.var_.characterEffect10001_tpose then
				arg_294_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_294_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_297_1 = 0
			local var_297_2 = 1.25

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(105121071).content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 50 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 50)

				if (50 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 50)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_6 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_6 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_6

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_6 and arg_294_1.time_ < var_297_1 + var_297_6 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play105121072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 105121072
		arg_298_1.duration_ = 7

		local var_298_0 = {
			ja = 5.8,
			ko = 3.5,
			zh = 7,
			en = 5.5
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play105121073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["10001_tpose"]) and arg_298_1.var_.characterEffect10001_tpose == nil then
				arg_298_1.var_.characterEffect10001_tpose = arg_298_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_0 = 0.1

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["10001_tpose"]) then
				if arg_298_1.var_.characterEffect10001_tpose and not isNil(arg_298_1.actors_["10001_tpose"]) then
					arg_298_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["10001_tpose"]) and arg_298_1.var_.characterEffect10001_tpose then
				arg_298_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_301_2 = arg_298_1.actors_["1084ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.characterEffect1084ui_story == nil then
				arg_298_1.var_.characterEffect1084ui_story = var_301_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_3 = 0.1

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_3 and not isNil(var_301_2) then
				if arg_298_1.var_.characterEffect1084ui_story and not isNil(var_301_2) then
					arg_298_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_3)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_3 and arg_298_1.time_ < 0 + var_301_3 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.characterEffect1084ui_story then
				arg_298_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_301_4 = 0
			local var_301_5 = 0.375

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_6 = arg_298_1:GetWordFromCfg(105121072)
				local var_301_7 = arg_298_1:FormatText(var_301_6.content)

				arg_298_1.text_.text = var_301_7

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_9 = 15 <= 0 and var_301_5 or var_301_5 * (utf8.len(var_301_7) / 15)

				if (15 <= 0 and var_301_5 or var_301_5 * (utf8.len(var_301_7) / 15)) > 0 and var_301_5 < var_301_9 then
					arg_298_1.talkMaxDuration = var_301_9

					if var_301_9 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_9 + var_301_4
					end
				end

				arg_298_1.text_.text = var_301_7
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121072", "story_v_out_105121.awb") ~= 0 then
					local var_301_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121072", "story_v_out_105121.awb") / 1000

					if var_301_10 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_10 + var_301_4
					end

					if var_301_6.prefab_name ~= "" and arg_298_1.actors_[var_301_6.prefab_name] ~= nil then
						local var_301_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_6.prefab_name].transform, "story_v_out_105121", "105121072", "story_v_out_105121.awb")

						arg_298_1:RecordAudio("105121072", var_301_11)
						arg_298_1:RecordAudio("105121072", var_301_11)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_105121", "105121072", "story_v_out_105121.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_105121", "105121072", "story_v_out_105121.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_12 = math.max(var_301_5, arg_298_1.talkMaxDuration)

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_12 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_4) / var_301_12

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_4 + var_301_12 and arg_298_1.time_ < var_301_4 + var_301_12 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play105121073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 105121073
		arg_302_1.duration_ = 9.97

		local var_302_0 = {
			ja = 9.966,
			ko = 4.766,
			zh = 5.366,
			en = 3.8
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
				arg_302_0:Play105121074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.525

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_1 = arg_302_1:GetWordFromCfg(105121073)
				local var_305_2 = arg_302_1:FormatText(var_305_1.content)

				arg_302_1.text_.text = var_305_2

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_4 = 21 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_2) / 21)

				if (21 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_2) / 21)) > 0 and var_305_0 < var_305_4 then
					arg_302_1.talkMaxDuration = var_305_4

					if var_305_4 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_4 + 0
					end
				end

				arg_302_1.text_.text = var_305_2
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121073", "story_v_out_105121.awb") ~= 0 then
					local var_305_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121073", "story_v_out_105121.awb") / 1000

					if var_305_5 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_5 + 0
					end

					if var_305_1.prefab_name ~= "" and arg_302_1.actors_[var_305_1.prefab_name] ~= nil then
						local var_305_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_1.prefab_name].transform, "story_v_out_105121", "105121073", "story_v_out_105121.awb")

						arg_302_1:RecordAudio("105121073", var_305_6)
						arg_302_1:RecordAudio("105121073", var_305_6)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_105121", "105121073", "story_v_out_105121.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_105121", "105121073", "story_v_out_105121.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_7 and arg_302_1.time_ < 0 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play105121074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 105121074
		arg_306_1.duration_ = 10.4

		local var_306_0 = {
			ja = 5.2,
			ko = 5.433,
			zh = 8.466,
			en = 10.4
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play105121075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.775

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_1 = arg_306_1:GetWordFromCfg(105121074)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 31 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 31)

				if (31 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 31)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121074", "story_v_out_105121.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121074", "story_v_out_105121.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_105121", "105121074", "story_v_out_105121.awb")

						arg_306_1:RecordAudio("105121074", var_309_6)
						arg_306_1:RecordAudio("105121074", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_105121", "105121074", "story_v_out_105121.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_105121", "105121074", "story_v_out_105121.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play105121075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 105121075
		arg_310_1.duration_ = 6.2

		local var_310_0 = {
			ja = 6.2,
			ko = 5.666,
			zh = 4.866,
			en = 3.7
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
				arg_310_0:Play105121076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1037ui_story"]) and arg_310_1.var_.characterEffect1037ui_story == nil then
				arg_310_1.var_.characterEffect1037ui_story = arg_310_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.1

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1037ui_story"]) then
				if arg_310_1.var_.characterEffect1037ui_story and not isNil(arg_310_1.actors_["1037ui_story"]) then
					arg_310_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1037ui_story"]) and arg_310_1.var_.characterEffect1037ui_story then
				arg_310_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_313_2 = arg_310_1.actors_["10001_tpose"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.characterEffect10001_tpose == nil then
				arg_310_1.var_.characterEffect10001_tpose = var_313_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_3 = 0.1

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.characterEffect10001_tpose and not isNil(var_313_2) then
					arg_310_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_310_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_3)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.characterEffect10001_tpose then
				arg_310_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_310_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_313_4 = 0
			local var_313_5 = 0.425

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_6 = arg_310_1:GetWordFromCfg(105121075)
				local var_313_7 = arg_310_1:FormatText(var_313_6.content)

				arg_310_1.text_.text = var_313_7

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 17 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 17)

				if (17 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 17)) > 0 and var_313_5 < var_313_9 then
					arg_310_1.talkMaxDuration = var_313_9

					if var_313_9 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_9 + var_313_4
					end
				end

				arg_310_1.text_.text = var_313_7
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121075", "story_v_out_105121.awb") ~= 0 then
					local var_313_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121075", "story_v_out_105121.awb") / 1000

					if var_313_10 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_4
					end

					if var_313_6.prefab_name ~= "" and arg_310_1.actors_[var_313_6.prefab_name] ~= nil then
						local var_313_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_6.prefab_name].transform, "story_v_out_105121", "105121075", "story_v_out_105121.awb")

						arg_310_1:RecordAudio("105121075", var_313_11)
						arg_310_1:RecordAudio("105121075", var_313_11)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_105121", "105121075", "story_v_out_105121.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_105121", "105121075", "story_v_out_105121.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_12 = math.max(var_313_5, arg_310_1.talkMaxDuration)

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_12 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_4) / var_313_12

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_4 + var_313_12 and arg_310_1.time_ < var_313_4 + var_313_12 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play105121076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 105121076
		arg_314_1.duration_ = 4.87

		local var_314_0 = {
			ja = 3.6,
			ko = 3.266,
			zh = 4.866,
			en = 4.366
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play105121077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1036ui_story"]) and arg_314_1.var_.characterEffect1036ui_story == nil then
				arg_314_1.var_.characterEffect1036ui_story = arg_314_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.1

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1036ui_story"]) then
				if arg_314_1.var_.characterEffect1036ui_story and not isNil(arg_314_1.actors_["1036ui_story"]) then
					arg_314_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1036ui_story"]) and arg_314_1.var_.characterEffect1036ui_story then
				arg_314_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_317_2 = arg_314_1.actors_["1037ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.characterEffect1037ui_story == nil then
				arg_314_1.var_.characterEffect1037ui_story = var_317_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_3 = 0.1

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_3 and not isNil(var_317_2) then
				if arg_314_1.var_.characterEffect1037ui_story and not isNil(var_317_2) then
					arg_314_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_3)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_3 and arg_314_1.time_ < 0 + var_317_3 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.characterEffect1037ui_story then
				arg_314_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_317_4 = 0
			local var_317_5 = 0.25

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_6 = arg_314_1:GetWordFromCfg(105121076)
				local var_317_7 = arg_314_1:FormatText(var_317_6.content)

				arg_314_1.text_.text = var_317_7

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 10 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 10)

				if (10 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 10)) > 0 and var_317_5 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_4
					end
				end

				arg_314_1.text_.text = var_317_7
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121076", "story_v_out_105121.awb") ~= 0 then
					local var_317_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121076", "story_v_out_105121.awb") / 1000

					if var_317_10 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_4
					end

					if var_317_6.prefab_name ~= "" and arg_314_1.actors_[var_317_6.prefab_name] ~= nil then
						local var_317_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_6.prefab_name].transform, "story_v_out_105121", "105121076", "story_v_out_105121.awb")

						arg_314_1:RecordAudio("105121076", var_317_11)
						arg_314_1:RecordAudio("105121076", var_317_11)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_105121", "105121076", "story_v_out_105121.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_105121", "105121076", "story_v_out_105121.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_12 = math.max(var_317_5, arg_314_1.talkMaxDuration)

			if var_317_4 <= arg_314_1.time_ and arg_314_1.time_ < var_317_4 + var_317_12 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_4) / var_317_12

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_4 + var_317_12 and arg_314_1.time_ < var_317_4 + var_317_12 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play105121077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 105121077
		arg_318_1.duration_ = 6.27

		local var_318_0 = {
			ja = 4.866,
			ko = 5.233,
			zh = 5.7,
			en = 6.266
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
				arg_318_0:Play105121078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1019ui_story"]) and arg_318_1.var_.characterEffect1019ui_story == nil then
				arg_318_1.var_.characterEffect1019ui_story = arg_318_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.1

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1019ui_story"]) then
				if arg_318_1.var_.characterEffect1019ui_story and not isNil(arg_318_1.actors_["1019ui_story"]) then
					arg_318_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1019ui_story"]) and arg_318_1.var_.characterEffect1019ui_story then
				arg_318_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_321_2 = arg_318_1.actors_["1036ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1036ui_story == nil then
				arg_318_1.var_.characterEffect1036ui_story = var_321_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_3 = 0.1

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.characterEffect1036ui_story and not isNil(var_321_2) then
					arg_318_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_3)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1036ui_story then
				arg_318_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_321_4 = 0
			local var_321_5 = 0.6

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_6 = arg_318_1:GetWordFromCfg(105121077)
				local var_321_7 = arg_318_1:FormatText(var_321_6.content)

				arg_318_1.text_.text = var_321_7

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_9 = 25 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 25)

				if (25 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 25)) > 0 and var_321_5 < var_321_9 then
					arg_318_1.talkMaxDuration = var_321_9

					if var_321_9 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_9 + var_321_4
					end
				end

				arg_318_1.text_.text = var_321_7
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121077", "story_v_out_105121.awb") ~= 0 then
					local var_321_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121077", "story_v_out_105121.awb") / 1000

					if var_321_10 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_4
					end

					if var_321_6.prefab_name ~= "" and arg_318_1.actors_[var_321_6.prefab_name] ~= nil then
						local var_321_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_6.prefab_name].transform, "story_v_out_105121", "105121077", "story_v_out_105121.awb")

						arg_318_1:RecordAudio("105121077", var_321_11)
						arg_318_1:RecordAudio("105121077", var_321_11)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_105121", "105121077", "story_v_out_105121.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_105121", "105121077", "story_v_out_105121.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_12 = math.max(var_321_5, arg_318_1.talkMaxDuration)

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_12 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_4) / var_321_12

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_4 + var_321_12 and arg_318_1.time_ < var_321_4 + var_321_12 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play105121078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 105121078
		arg_322_1.duration_ = 11.37

		local var_322_0 = {
			ja = 11.366,
			ko = 3.233,
			zh = 5.833,
			en = 7.866
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play105121079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["10001_tpose"]) and arg_322_1.var_.characterEffect10001_tpose == nil then
				arg_322_1.var_.characterEffect10001_tpose = arg_322_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.1

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["10001_tpose"]) then
				if arg_322_1.var_.characterEffect10001_tpose and not isNil(arg_322_1.actors_["10001_tpose"]) then
					arg_322_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["10001_tpose"]) and arg_322_1.var_.characterEffect10001_tpose then
				arg_322_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_325_2 = arg_322_1.actors_["1019ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.characterEffect1019ui_story == nil then
				arg_322_1.var_.characterEffect1019ui_story = var_325_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_3 = 0.1

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_3 and not isNil(var_325_2) then
				if arg_322_1.var_.characterEffect1019ui_story and not isNil(var_325_2) then
					arg_322_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_3)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_3 and arg_322_1.time_ < 0 + var_325_3 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.characterEffect1019ui_story then
				arg_322_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_325_4 = 0
			local var_325_5 = 0.525

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_6 = arg_322_1:GetWordFromCfg(105121078)
				local var_325_7 = arg_322_1:FormatText(var_325_6.content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 21 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 21)

				if (21 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 21)) > 0 and var_325_5 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_4
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121078", "story_v_out_105121.awb") ~= 0 then
					local var_325_10 = manager.audio:GetVoiceLength("story_v_out_105121", "105121078", "story_v_out_105121.awb") / 1000

					if var_325_10 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_4
					end

					if var_325_6.prefab_name ~= "" and arg_322_1.actors_[var_325_6.prefab_name] ~= nil then
						local var_325_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_6.prefab_name].transform, "story_v_out_105121", "105121078", "story_v_out_105121.awb")

						arg_322_1:RecordAudio("105121078", var_325_11)
						arg_322_1:RecordAudio("105121078", var_325_11)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_105121", "105121078", "story_v_out_105121.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_105121", "105121078", "story_v_out_105121.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_12 = math.max(var_325_5, arg_322_1.talkMaxDuration)

			if var_325_4 <= arg_322_1.time_ and arg_322_1.time_ < var_325_4 + var_325_12 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_4) / var_325_12

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_4 + var_325_12 and arg_322_1.time_ < var_325_4 + var_325_12 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play105121079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 105121079
		arg_326_1.duration_ = 0.1

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"

			SetActive(arg_326_1.choicesGo_, true)

			for iter_327_0, iter_327_1 in ipairs(arg_326_1.choices_) do
				SetActive(iter_327_1.go, iter_327_0 <= 1)
			end

			arg_326_1.choices_[1].txt.text = arg_326_1:FormatText(StoryChoiceCfg[35].name)
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play105121080(arg_326_1)
			end

			arg_326_1:RecordChoiceLog(105121079, 35)
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			return
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play105121080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 105121080
		arg_330_1.duration_ = 1.7

		local var_330_0 = {
			ja = 1.7,
			ko = 0.966,
			zh = 1.633,
			en = 1.2
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
				arg_330_0:Play105121081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["10001_tpose"]) and arg_330_1.var_.characterEffect10001_tpose == nil then
				arg_330_1.var_.characterEffect10001_tpose = arg_330_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.1

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["10001_tpose"]) then
				if arg_330_1.var_.characterEffect10001_tpose and not isNil(arg_330_1.actors_["10001_tpose"]) then
					arg_330_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_330_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["10001_tpose"]) and arg_330_1.var_.characterEffect10001_tpose then
				arg_330_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_330_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_333_1 = 0
			local var_333_2 = 0.125

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(105121080)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_6 = 5 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_4) / 5)

				if (5 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_4) / 5)) > 0 and var_333_2 < var_333_6 then
					arg_330_1.talkMaxDuration = var_333_6

					if var_333_6 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121080", "story_v_out_105121.awb") ~= 0 then
					local var_333_7 = manager.audio:GetVoiceLength("story_v_out_105121", "105121080", "story_v_out_105121.awb") / 1000

					if var_333_7 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_1
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_105121", "105121080", "story_v_out_105121.awb")

						arg_330_1:RecordAudio("105121080", var_333_8)
						arg_330_1:RecordAudio("105121080", var_333_8)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_105121", "105121080", "story_v_out_105121.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_105121", "105121080", "story_v_out_105121.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_9 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_9 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_9

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_9 and arg_330_1.time_ < var_333_1 + var_333_9 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play105121081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 105121081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play105121082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.95

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(105121081).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 38 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 38)

				if (38 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 38)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play105121082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 105121082
		arg_338_1.duration_ = 3.5

		local var_338_0 = {
			ja = 2.7,
			ko = 2.2,
			zh = 3.5,
			en = 1.6
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
				arg_338_0:Play105121083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.25

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_1 = arg_338_1:GetWordFromCfg(105121082)
				local var_341_2 = arg_338_1:FormatText(var_341_1.content)

				arg_338_1.text_.text = var_341_2

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 10 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 10)

				if (10 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 10)) > 0 and var_341_0 < var_341_4 then
					arg_338_1.talkMaxDuration = var_341_4

					if var_341_4 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_4 + 0
					end
				end

				arg_338_1.text_.text = var_341_2
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121082", "story_v_out_105121.awb") ~= 0 then
					local var_341_5 = manager.audio:GetVoiceLength("story_v_out_105121", "105121082", "story_v_out_105121.awb") / 1000

					if var_341_5 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + 0
					end

					if var_341_1.prefab_name ~= "" and arg_338_1.actors_[var_341_1.prefab_name] ~= nil then
						local var_341_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_1.prefab_name].transform, "story_v_out_105121", "105121082", "story_v_out_105121.awb")

						arg_338_1:RecordAudio("105121082", var_341_6)
						arg_338_1:RecordAudio("105121082", var_341_6)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_105121", "105121082", "story_v_out_105121.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_105121", "105121082", "story_v_out_105121.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play105121083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 105121083
		arg_342_1.duration_ = 4

		local var_342_0 = {
			ja = 4,
			ko = 3.433,
			zh = 3.533,
			en = 3.866
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
			arg_342_1.auto_ = false
		end

		function arg_342_1.playNext_(arg_344_0)
			arg_342_1.onStoryFinished_()
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1084ui_story"]) and arg_342_1.var_.characterEffect1084ui_story == nil then
				arg_342_1.var_.characterEffect1084ui_story = arg_342_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.1

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1084ui_story"]) then
				if arg_342_1.var_.characterEffect1084ui_story and not isNil(arg_342_1.actors_["1084ui_story"]) then
					arg_342_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1084ui_story"]) and arg_342_1.var_.characterEffect1084ui_story then
				arg_342_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_345_2 = 0
			local var_345_3 = 0.45

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_4 = arg_342_1:GetWordFromCfg(105121083)
				local var_345_5 = arg_342_1:FormatText(var_345_4.content)

				arg_342_1.text_.text = var_345_5

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_7 = 18 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_5) / 18)

				if (18 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_5) / 18)) > 0 and var_345_3 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_2
					end
				end

				arg_342_1.text_.text = var_345_5
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105121", "105121083", "story_v_out_105121.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_out_105121", "105121083", "story_v_out_105121.awb") / 1000

					if var_345_8 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_2
					end

					if var_345_4.prefab_name ~= "" and arg_342_1.actors_[var_345_4.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_4.prefab_name].transform, "story_v_out_105121", "105121083", "story_v_out_105121.awb")

						arg_342_1:RecordAudio("105121083", var_345_9)
						arg_342_1:RecordAudio("105121083", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_105121", "105121083", "story_v_out_105121.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_105121", "105121083", "story_v_out_105121.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_3, arg_342_1.talkMaxDuration)

			if var_345_2 <= arg_342_1.time_ and arg_342_1.time_ < var_345_2 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_2) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_2 + var_345_10 and arg_342_1.time_ < var_345_2 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B12a",
		"TextureConfig/Background/S0505",
		"TextureConfig/Background/B01a",
		"TextureConfig/Background/S0504"
	},
	voices = {
		"story_v_out_105121.awb"
	}
}
