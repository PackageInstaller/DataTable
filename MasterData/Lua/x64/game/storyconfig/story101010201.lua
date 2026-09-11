return {
	Play101021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			local var_4_3 = "B10a"

			if arg_1_1.bgs_.B10a == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.B10a:GetComponent("SpriteRenderer")

				if var_4_5 then
					arg_1_1.var_.alphaOldValueB10a = var_4_5.color.a
					arg_1_1.var_.alphaMatValueB10a = var_4_5
				end

				arg_1_1.var_.alphaOldValueB10a = 0
			end

			local var_4_6 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 then
				if arg_1_1.var_.alphaMatValueB10a then
					arg_1_1.var_.alphaMatValueB10a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB10a, 1, (arg_1_1.time_ - 0) / var_4_6)
					arg_1_1.var_.alphaMatValueB10a.color = arg_1_1.var_.alphaMatValueB10a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and arg_1_1.var_.alphaMatValueB10a then
				arg_1_1.var_.alphaMatValueB10a.color.a = 1
				arg_1_1.var_.alphaMatValueB10a.color = arg_1_1.var_.alphaMatValueB10a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.B10a

				arg_1_1.bgs_.B10a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = 2 * (var_4_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_7.transform.localScale = Vector3.New(var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_10 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_10 + 2 and arg_1_1.time_ < var_4_10 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.525

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(101021001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 20 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 20)

				if (20 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 20)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play101021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101021002
		arg_8_1.duration_ = 10.4

		local var_8_0 = {
			ja = 9.866,
			ko = 10.2,
			zh = 7.733,
			en = 10.4
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
				arg_8_0:Play101021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_1", "se_story_1_protest", "")
			end

			local var_11_2 = manager.ui.mainCamera.transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.shakeOldPosMainCamera = var_11_2.localPosition
			end

			local var_11_3 = 0.600000023841858

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 then
				local var_11_4, var_11_5 = math.modf((arg_8_1.time_ - 0) / 0.066)

				var_11_2.localPosition = Vector3.New(var_11_5 * 0.13, var_11_5 * 0.13, var_11_5 * 0.13) + arg_8_1.var_.shakeOldPosMainCamera
			end

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 then
				var_11_2.localPosition = arg_8_1.var_.shakeOldPosMainCamera
			end

			local var_11_6 = 0
			local var_11_7 = 0.75

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[16].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_8 = arg_8_1:GetWordFromCfg(101021002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 30 <= 0 and var_11_7 or var_11_7 * (utf8.len(var_11_9) / 30)

				if (30 <= 0 and var_11_7 or var_11_7 * (utf8.len(var_11_9) / 30)) > 0 and var_11_7 < var_11_11 then
					arg_8_1.talkMaxDuration = var_11_11

					if var_11_11 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_11 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_9
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021002", "story_v_out_101021.awb") ~= 0 then
					local var_11_12 = manager.audio:GetVoiceLength("story_v_out_101021", "101021002", "story_v_out_101021.awb") / 1000

					if var_11_12 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_6
					end

					if var_11_8.prefab_name ~= "" and arg_8_1.actors_[var_11_8.prefab_name] ~= nil then
						local var_11_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_8.prefab_name].transform, "story_v_out_101021", "101021002", "story_v_out_101021.awb")

						arg_8_1:RecordAudio("101021002", var_11_13)
						arg_8_1:RecordAudio("101021002", var_11_13)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101021", "101021002", "story_v_out_101021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101021", "101021002", "story_v_out_101021.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_14 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_14 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_14

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_14 and arg_8_1.time_ < var_11_6 + var_11_14 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play101021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101021003
		arg_12_1.duration_ = 3.6

		local var_12_0 = {
			ja = 2.566,
			ko = 3.6,
			zh = 2.733,
			en = 2.2
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
				arg_12_0:Play101021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.25

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[17].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(101021003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 10 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 10)

				if (10 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 10)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021003", "story_v_out_101021.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_101021", "101021003", "story_v_out_101021.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_101021", "101021003", "story_v_out_101021.awb")

						arg_12_1:RecordAudio("101021003", var_15_6)
						arg_12_1:RecordAudio("101021003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101021", "101021003", "story_v_out_101021.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101021", "101021003", "story_v_out_101021.awb")
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
	Play101021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101021004
		arg_16_1.duration_ = 7.23

		local var_16_0 = {
			ja = 7.1,
			ko = 4.966,
			zh = 4.333,
			en = 7.233
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
				arg_16_0:Play101021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.55

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[18].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(101021004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 22 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 22)

				if (22 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 22)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021004", "story_v_out_101021.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_101021", "101021004", "story_v_out_101021.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_101021", "101021004", "story_v_out_101021.awb")

						arg_16_1:RecordAudio("101021004", var_19_6)
						arg_16_1:RecordAudio("101021004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101021", "101021004", "story_v_out_101021.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101021", "101021004", "story_v_out_101021.awb")
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
	Play101021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101021005
		arg_20_1.duration_ = 4.5

		local var_20_0 = {
			ja = 3.233,
			ko = 2.166,
			zh = 4.5,
			en = 4.466
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
				arg_20_0:Play101021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["2020_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2020_tpose"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_20_1.stage_.transform)

				var_23_0.name = "2020_tpose"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["2020_tpose"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["2020_tpose" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["2020_tpose" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["2020_tpose" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["2020_tpose"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect2020_tpose == nil then
				arg_20_1.var_.characterEffect2020_tpose = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect2020_tpose and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect2020_tpose then
				arg_20_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_23_6 = arg_20_1.actors_["2020_tpose"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos2020_tpose = var_23_6.localPosition

				local var_23_7 = GameObjectTools.GetOrAddComponent(var_23_6.gameObject, typeof(DynamicBoneHelper))

				if var_23_7 then
					var_23_7:EnableDynamicBone(false)
				end
			end

			local var_23_8 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos2020_tpose, Vector3.New(-0.7, -1.2, -4.1), (arg_20_1.time_ - 0) / var_23_8)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(-0.7, -1.2, -4.1)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles

				local var_23_9 = GameObjectTools.GetOrAddComponent(var_23_6.gameObject, typeof(DynamicBoneHelper))

				if var_23_9 then
					var_23_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_23_10 = 0
			local var_23_11 = 0.375

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(101021005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 15 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 15)

				if (15 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 15)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021005", "story_v_out_101021.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_101021", "101021005", "story_v_out_101021.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_101021", "101021005", "story_v_out_101021.awb")

						arg_20_1:RecordAudio("101021005", var_23_17)
						arg_20_1:RecordAudio("101021005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101021", "101021005", "story_v_out_101021.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101021", "101021005", "story_v_out_101021.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play101021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101021006
		arg_24_1.duration_ = 8

		local var_24_0 = {
			ja = 8,
			ko = 6.9,
			zh = 7.2,
			en = 6.7
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
				arg_24_0:Play101021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "3008ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["3008ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["3008ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["3008ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["3008ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect3008ui_story and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect3008ui_story then
				arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_27_6 = arg_24_1.actors_["2020_tpose"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect2020_tpose == nil then
				arg_24_1.var_.characterEffect2020_tpose = var_27_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 and not isNil(var_27_6) then
				if arg_24_1.var_.characterEffect2020_tpose and not isNil(var_27_6) then
					arg_24_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_24_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_7)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect2020_tpose then
				arg_24_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_24_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_27_8 = arg_24_1.actors_["3008ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos3008ui_story = var_27_8.localPosition
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3008ui_story, Vector3.New(0.7, -1.51, -4.3), (arg_24_1.time_ - 0) / var_27_9)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0.7, -1.51, -4.3)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_10 = 0
			local var_27_11 = 0.8

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:GetWordFromCfg(101021006)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 32 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 32)

				if (32 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 32)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021006", "story_v_out_101021.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_101021", "101021006", "story_v_out_101021.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_101021", "101021006", "story_v_out_101021.awb")

						arg_24_1:RecordAudio("101021006", var_27_17)
						arg_24_1:RecordAudio("101021006", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101021", "101021006", "story_v_out_101021.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101021", "101021006", "story_v_out_101021.awb")
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
				actorName = "3008ui_story",
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
	Play101021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101021007
		arg_28_1.duration_ = 5.97

		local var_28_0 = {
			ja = 5.966,
			ko = 4.033,
			zh = 4.533,
			en = 3.033
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
				arg_28_0:Play101021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["2020_tpose"]) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = arg_28_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["2020_tpose"]) then
				if arg_28_1.var_.characterEffect2020_tpose and not isNil(arg_28_1.actors_["2020_tpose"]) then
					arg_28_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["2020_tpose"]) and arg_28_1.var_.characterEffect2020_tpose then
				arg_28_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["3008ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect3008ui_story then
				arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_31_4 = 0
			local var_31_5 = 0.425

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(101021007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 15 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 15)

				if (15 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 15)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021007", "story_v_out_101021.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021007", "story_v_out_101021.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_101021", "101021007", "story_v_out_101021.awb")

						arg_28_1:RecordAudio("101021007", var_31_11)
						arg_28_1:RecordAudio("101021007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101021", "101021007", "story_v_out_101021.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101021", "101021007", "story_v_out_101021.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101021008
		arg_32_1.duration_ = 6.5

		local var_32_0 = {
			ja = 4.7,
			ko = 6.5,
			zh = 5.5,
			en = 5.1
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
				arg_32_0:Play101021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["3008ui_story"]) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = arg_32_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["3008ui_story"]) then
				if arg_32_1.var_.characterEffect3008ui_story and not isNil(arg_32_1.actors_["3008ui_story"]) then
					arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["3008ui_story"]) and arg_32_1.var_.characterEffect3008ui_story then
				arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["2020_tpose"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect2020_tpose == nil then
				arg_32_1.var_.characterEffect2020_tpose = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect2020_tpose and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_32_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect2020_tpose then
				arg_32_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_32_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_35_4 = 0
			local var_35_5 = 0.6

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(101021008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 24 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 24)

				if (24 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 24)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021008", "story_v_out_101021.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021008", "story_v_out_101021.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_101021", "101021008", "story_v_out_101021.awb")

						arg_32_1:RecordAudio("101021008", var_35_11)
						arg_32_1:RecordAudio("101021008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_101021", "101021008", "story_v_out_101021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_101021", "101021008", "story_v_out_101021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play101021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101021009
		arg_36_1.duration_ = 8.5

		local var_36_0 = {
			ja = 8.5,
			ko = 6.6,
			zh = 6.266,
			en = 7.566
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
				arg_36_0:Play101021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["2020_tpose"]) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = arg_36_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["2020_tpose"]) then
				if arg_36_1.var_.characterEffect2020_tpose and not isNil(arg_36_1.actors_["2020_tpose"]) then
					arg_36_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["2020_tpose"]) and arg_36_1.var_.characterEffect2020_tpose then
				arg_36_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["3008ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect3008ui_story == nil then
				arg_36_1.var_.characterEffect3008ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect3008ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_36_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect3008ui_story then
				arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_36_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_39_4 = 0
			local var_39_5 = 0.675

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(101021009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 27 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 27)

				if (27 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 27)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021009", "story_v_out_101021.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021009", "story_v_out_101021.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_101021", "101021009", "story_v_out_101021.awb")

						arg_36_1:RecordAudio("101021009", var_39_11)
						arg_36_1:RecordAudio("101021009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101021", "101021009", "story_v_out_101021.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101021", "101021009", "story_v_out_101021.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play101021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101021010
		arg_40_1.duration_ = 3.53

		local var_40_0 = {
			ja = 3.433,
			ko = 2.333,
			zh = 3.533,
			en = 2.4
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
				arg_40_0:Play101021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["3008ui_story"]) and arg_40_1.var_.characterEffect3008ui_story == nil then
				arg_40_1.var_.characterEffect3008ui_story = arg_40_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["3008ui_story"]) then
				if arg_40_1.var_.characterEffect3008ui_story and not isNil(arg_40_1.actors_["3008ui_story"]) then
					arg_40_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["3008ui_story"]) and arg_40_1.var_.characterEffect3008ui_story then
				arg_40_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["2020_tpose"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect2020_tpose == nil then
				arg_40_1.var_.characterEffect2020_tpose = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect2020_tpose and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_40_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect2020_tpose then
				arg_40_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_40_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_1")
			end

			local var_43_4 = 0
			local var_43_5 = 0.3

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(101021010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 12 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 12)

				if (12 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 12)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021010", "story_v_out_101021.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021010", "story_v_out_101021.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_101021", "101021010", "story_v_out_101021.awb")

						arg_40_1:RecordAudio("101021010", var_43_11)
						arg_40_1:RecordAudio("101021010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101021", "101021010", "story_v_out_101021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101021", "101021010", "story_v_out_101021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101021011
		arg_44_1.duration_ = 8.07

		local var_44_0 = {
			ja = 8.066,
			ko = 4.7,
			zh = 4.766,
			en = 5.366
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
				arg_44_0:Play101021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:AudioAction("stop", "effect", "se_story_1", "se_story_1_protest", "")
			end

			local var_47_1 = arg_44_1.actors_["3008ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect3008ui_story == nil then
				arg_44_1.var_.characterEffect3008ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect3008ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_44_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_2)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect3008ui_story then
				arg_44_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_44_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_47_3 = manager.ui.mainCamera.transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.shakeOldPosMainCamera = var_47_3.localPosition
			end

			local var_47_4 = 0.600000023841858

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				local var_47_5, var_47_6 = math.modf((arg_44_1.time_ - 0) / 0.066)

				var_47_3.localPosition = Vector3.New(var_47_6 * 0.13, var_47_6 * 0.13, var_47_6 * 0.13) + arg_44_1.var_.shakeOldPosMainCamera
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				var_47_3.localPosition = arg_44_1.var_.shakeOldPosMainCamera
			end

			local var_47_7 = arg_44_1.actors_["2020_tpose"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos2020_tpose = var_47_7.localPosition

				local var_47_8 = GameObjectTools.GetOrAddComponent(var_47_7.gameObject, typeof(DynamicBoneHelper))

				if var_47_8 then
					var_47_8:EnableDynamicBone(false)
				end
			end

			local var_47_9 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_9 then
				var_47_7.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_9)
				var_47_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_7.position).x, (manager.ui.mainCamera.transform.position - var_47_7.position).y, (manager.ui.mainCamera.transform.position - var_47_7.position).z)
				var_47_7.localEulerAngles.z = 0
				var_47_7.localEulerAngles.x = 0
				var_47_7.localEulerAngles = var_47_7.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_9 and arg_44_1.time_ < 0 + var_47_9 + arg_47_0 then
				var_47_7.localPosition = Vector3.New(0, 100, 0)
				var_47_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_7.position).x, (manager.ui.mainCamera.transform.position - var_47_7.position).y, (manager.ui.mainCamera.transform.position - var_47_7.position).z)
				var_47_7.localEulerAngles.z = 0
				var_47_7.localEulerAngles.x = 0
				var_47_7.localEulerAngles = var_47_7.localEulerAngles

				local var_47_10 = GameObjectTools.GetOrAddComponent(var_47_7.gameObject, typeof(DynamicBoneHelper))

				if var_47_10 then
					var_47_10:EnableDynamicBone(true)
				end
			end

			local var_47_11 = arg_44_1.actors_["3008ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos3008ui_story = var_47_11.localPosition
			end

			local var_47_12 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_12 then
				var_47_11.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_12)
				var_47_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_11.position).x, (manager.ui.mainCamera.transform.position - var_47_11.position).y, (manager.ui.mainCamera.transform.position - var_47_11.position).z)
				var_47_11.localEulerAngles.z = 0
				var_47_11.localEulerAngles.x = 0
				var_47_11.localEulerAngles = var_47_11.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_12 and arg_44_1.time_ < 0 + var_47_12 + arg_47_0 then
				var_47_11.localPosition = Vector3.New(0, 100, 0)
				var_47_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_11.position).x, (manager.ui.mainCamera.transform.position - var_47_11.position).y, (manager.ui.mainCamera.transform.position - var_47_11.position).z)
				var_47_11.localEulerAngles.z = 0
				var_47_11.localEulerAngles.x = 0
				var_47_11.localEulerAngles = var_47_11.localEulerAngles
			end

			local var_47_13 = "1035ui_story"

			if arg_44_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_47_14 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_44_1.stage_.transform)

				var_47_14.name = var_47_13
				var_47_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_[var_47_13] = var_47_14

				local var_47_15 = var_47_14:GetComponentInChildren(typeof(CharacterEffect))

				var_47_15.enabled = true

				local var_47_16 = GameObjectTools.GetOrAddComponent(var_47_14, typeof(DynamicBoneHelper))

				if var_47_16 then
					var_47_16:EnableDynamicBone(false)
				end

				arg_44_1:ShowWeapon(var_47_15.transform, false)

				arg_44_1.var_[var_47_13 .. "Animator"] = var_47_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_44_1.var_[var_47_13 .. "Animator"].applyRootMotion = true
				arg_44_1.var_[var_47_13 .. "LipSync"] = var_47_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_47_17 = arg_44_1.actors_["1035ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1035ui_story = var_47_17.localPosition
			end

			local var_47_18 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_18 then
				var_47_17.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_44_1.time_ - 0) / var_47_18)
				var_47_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_17.position).x, (manager.ui.mainCamera.transform.position - var_47_17.position).y, (manager.ui.mainCamera.transform.position - var_47_17.position).z)
				var_47_17.localEulerAngles.z = 0
				var_47_17.localEulerAngles.x = 0
				var_47_17.localEulerAngles = var_47_17.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_18 and arg_44_1.time_ < 0 + var_47_18 + arg_47_0 then
				var_47_17.localPosition = Vector3.New(0, -1.05, -5.6)
				var_47_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_17.position).x, (manager.ui.mainCamera.transform.position - var_47_17.position).y, (manager.ui.mainCamera.transform.position - var_47_17.position).z)
				var_47_17.localEulerAngles.z = 0
				var_47_17.localEulerAngles.x = 0
				var_47_17.localEulerAngles = var_47_17.localEulerAngles
			end

			local var_47_19 = arg_44_1.actors_["1035ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_19) and arg_44_1.var_.characterEffect1035ui_story == nil then
				arg_44_1.var_.characterEffect1035ui_story = var_47_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_20 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_20 and not isNil(var_47_19) then
				if arg_44_1.var_.characterEffect1035ui_story and not isNil(var_47_19) then
					arg_44_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_20 and arg_44_1.time_ < 0 + var_47_20 + arg_47_0 and not isNil(var_47_19) and arg_44_1.var_.characterEffect1035ui_story then
				arg_44_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action7_1")
			end

			local var_47_22 = 0
			local var_47_23 = 0.5

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_22 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_24 = arg_44_1:GetWordFromCfg(101021011)
				local var_47_25 = arg_44_1:FormatText(var_47_24.content)

				arg_44_1.text_.text = var_47_25

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_27 = 20 <= 0 and var_47_23 or var_47_23 * (utf8.len(var_47_25) / 20)

				if (20 <= 0 and var_47_23 or var_47_23 * (utf8.len(var_47_25) / 20)) > 0 and var_47_23 < var_47_27 then
					arg_44_1.talkMaxDuration = var_47_27

					if var_47_27 + var_47_22 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_27 + var_47_22
					end
				end

				arg_44_1.text_.text = var_47_25
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021011", "story_v_out_101021.awb") ~= 0 then
					local var_47_28 = manager.audio:GetVoiceLength("story_v_out_101021", "101021011", "story_v_out_101021.awb") / 1000

					if var_47_28 + var_47_22 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_28 + var_47_22
					end

					if var_47_24.prefab_name ~= "" and arg_44_1.actors_[var_47_24.prefab_name] ~= nil then
						local var_47_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_24.prefab_name].transform, "story_v_out_101021", "101021011", "story_v_out_101021.awb")

						arg_44_1:RecordAudio("101021011", var_47_29)
						arg_44_1:RecordAudio("101021011", var_47_29)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101021", "101021011", "story_v_out_101021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101021", "101021011", "story_v_out_101021.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_30 = math.max(var_47_23, arg_44_1.talkMaxDuration)

			if var_47_22 <= arg_44_1.time_ and arg_44_1.time_ < var_47_22 + var_47_30 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_22) / var_47_30

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_22 + var_47_30 and arg_44_1.time_ < var_47_22 + var_47_30 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
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
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play101021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101021012
		arg_48_1.duration_ = 5.47

		local var_48_0 = {
			ja = 3.1,
			ko = 5.466,
			zh = 3.9,
			en = 3.7
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
				arg_48_0:Play101021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1035ui_story = arg_48_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1035ui_story"].transform.position).z)
				arg_48_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1035ui_story"].transform.localEulerAngles = arg_48_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1035ui_story"].transform.position).z)
				arg_48_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1035ui_story"].transform.localEulerAngles = arg_48_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_51_1 = 0
			local var_51_2 = 0.475

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[16].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(101021012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 17 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 17)

				if (17 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 17)) > 0 and var_51_2 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021012", "story_v_out_101021.awb") ~= 0 then
					local var_51_7 = manager.audio:GetVoiceLength("story_v_out_101021", "101021012", "story_v_out_101021.awb") / 1000

					if var_51_7 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_1
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_101021", "101021012", "story_v_out_101021.awb")

						arg_48_1:RecordAudio("101021012", var_51_8)
						arg_48_1:RecordAudio("101021012", var_51_8)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101021", "101021012", "story_v_out_101021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101021", "101021012", "story_v_out_101021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_9 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_9 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_9

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_9 and arg_48_1.time_ < var_51_1 + var_51_9 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play101021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101021013
		arg_52_1.duration_ = 5.77

		local var_52_0 = {
			ja = 5.766,
			ko = 3.1,
			zh = 3.2,
			en = 4.733
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
				arg_52_0:Play101021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.35

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[17].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:GetWordFromCfg(101021013)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 14 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 14)

				if (14 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 14)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021013", "story_v_out_101021.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_101021", "101021013", "story_v_out_101021.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_101021", "101021013", "story_v_out_101021.awb")

						arg_52_1:RecordAudio("101021013", var_55_6)
						arg_52_1:RecordAudio("101021013", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101021", "101021013", "story_v_out_101021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101021", "101021013", "story_v_out_101021.awb")
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
	Play101021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101021014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play101021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.675

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_2 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_2:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(101021014).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 27 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 27)

				if (27 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 27)) > 0 and var_59_1 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5
					var_59_0 = var_59_0 + 0.3

					if var_59_5 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_6 = var_59_0 + 0.3
			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_7 and arg_56_1.time_ < var_59_6 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101021015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 101021015
		arg_62_1.duration_ = 7.73

		local var_62_0 = {
			ja = 6.166,
			ko = 7.1,
			zh = 7,
			en = 7.733
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
				arg_62_0:Play101021016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["3008ui_story"]) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = arg_62_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["3008ui_story"]) then
				if arg_62_1.var_.characterEffect3008ui_story and not isNil(arg_62_1.actors_["3008ui_story"]) then
					arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["3008ui_story"]) and arg_62_1.var_.characterEffect3008ui_story then
				arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_65_2 = arg_62_1.actors_["3008ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos3008ui_story = var_65_2.localPosition
			end

			local var_65_3 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 then
				var_65_2.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos3008ui_story, Vector3.New(-0.7, -1.51, -4.3), (arg_62_1.time_ - 0) / var_65_3)
				var_65_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_2.position).x, (manager.ui.mainCamera.transform.position - var_65_2.position).y, (manager.ui.mainCamera.transform.position - var_65_2.position).z)
				var_65_2.localEulerAngles.z = 0
				var_65_2.localEulerAngles.x = 0
				var_65_2.localEulerAngles = var_65_2.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 then
				var_65_2.localPosition = Vector3.New(-0.7, -1.51, -4.3)
				var_65_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_2.position).x, (manager.ui.mainCamera.transform.position - var_65_2.position).y, (manager.ui.mainCamera.transform.position - var_65_2.position).z)
				var_65_2.localEulerAngles.z = 0
				var_65_2.localEulerAngles.x = 0
				var_65_2.localEulerAngles = var_65_2.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_65_4 = 0
			local var_65_5 = 0.85

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(101021015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 33 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 33)

				if (33 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 33)) > 0 and var_65_5 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021015", "story_v_out_101021.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021015", "story_v_out_101021.awb") / 1000

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end

					if var_65_6.prefab_name ~= "" and arg_62_1.actors_[var_65_6.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_6.prefab_name].transform, "story_v_out_101021", "101021015", "story_v_out_101021.awb")

						arg_62_1:RecordAudio("101021015", var_65_11)
						arg_62_1:RecordAudio("101021015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_101021", "101021015", "story_v_out_101021.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_101021", "101021015", "story_v_out_101021.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_12 and arg_62_1.time_ < var_65_4 + var_65_12 + arg_65_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play101021016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 101021016
		arg_66_1.duration_ = 4.93

		local var_66_0 = {
			ja = 4.933,
			ko = 4.8,
			zh = 4.5,
			en = 4.566
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
				arg_66_0:Play101021017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = arg_66_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) then
				if arg_66_1.var_.characterEffect3008ui_story and not isNil(arg_66_1.actors_["3008ui_story"]) then
					arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_66_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) and arg_66_1.var_.characterEffect3008ui_story then
				arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_66_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_69_1 = arg_66_1.actors_["1035ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1035ui_story = var_69_1.localPosition
			end

			local var_69_2 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_2 then
				var_69_1.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_66_1.time_ - 0) / var_69_2)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_2 and arg_66_1.time_ < 0 + var_69_2 + arg_69_0 then
				var_69_1.localPosition = Vector3.New(0.7, -1.05, -5.6)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action11_1")
			end

			local var_69_3 = 0
			local var_69_4 = 0.475

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_5 = arg_66_1:GetWordFromCfg(101021016)
				local var_69_6 = arg_66_1:FormatText(var_69_5.content)

				arg_66_1.text_.text = var_69_6

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_8 = 19 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_6) / 19)

				if (19 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_6) / 19)) > 0 and var_69_4 < var_69_8 then
					arg_66_1.talkMaxDuration = var_69_8

					if var_69_8 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_3
					end
				end

				arg_66_1.text_.text = var_69_6
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021016", "story_v_out_101021.awb") ~= 0 then
					local var_69_9 = manager.audio:GetVoiceLength("story_v_out_101021", "101021016", "story_v_out_101021.awb") / 1000

					if var_69_9 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_3
					end

					if var_69_5.prefab_name ~= "" and arg_66_1.actors_[var_69_5.prefab_name] ~= nil then
						local var_69_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_5.prefab_name].transform, "story_v_out_101021", "101021016", "story_v_out_101021.awb")

						arg_66_1:RecordAudio("101021016", var_69_10)
						arg_66_1:RecordAudio("101021016", var_69_10)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_101021", "101021016", "story_v_out_101021.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_101021", "101021016", "story_v_out_101021.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_11 = math.max(var_69_4, arg_66_1.talkMaxDuration)

			if var_69_3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_3 + var_69_11 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_3) / var_69_11

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_3 + var_69_11 and arg_66_1.time_ < var_69_3 + var_69_11 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play101021017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 101021017
		arg_70_1.duration_ = 3.07

		local var_70_0 = {
			ja = 3,
			ko = 2.6,
			zh = 3.066,
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
				arg_70_0:Play101021018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["3008ui_story"]) and arg_70_1.var_.characterEffect3008ui_story == nil then
				arg_70_1.var_.characterEffect3008ui_story = arg_70_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["3008ui_story"]) then
				if arg_70_1.var_.characterEffect3008ui_story and not isNil(arg_70_1.actors_["3008ui_story"]) then
					arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["3008ui_story"]) and arg_70_1.var_.characterEffect3008ui_story then
				arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["1035ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1035ui_story == nil then
				arg_70_1.var_.characterEffect1035ui_story = var_73_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_3 = 0.100000001490116

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.characterEffect1035ui_story and not isNil(var_73_2) then
					arg_70_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_3)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1035ui_story then
				arg_70_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_73_4 = 0
			local var_73_5 = 0.25

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(101021017)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 10 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 10)

				if (10 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 10)) > 0 and var_73_5 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021017", "story_v_out_101021.awb") ~= 0 then
					local var_73_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021017", "story_v_out_101021.awb") / 1000

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end

					if var_73_6.prefab_name ~= "" and arg_70_1.actors_[var_73_6.prefab_name] ~= nil then
						local var_73_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_6.prefab_name].transform, "story_v_out_101021", "101021017", "story_v_out_101021.awb")

						arg_70_1:RecordAudio("101021017", var_73_11)
						arg_70_1:RecordAudio("101021017", var_73_11)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_101021", "101021017", "story_v_out_101021.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_101021", "101021017", "story_v_out_101021.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_12 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_12 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_12

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_12 and arg_70_1.time_ < var_73_4 + var_73_12 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play101021018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 101021018
		arg_74_1.duration_ = 7.7

		local var_74_0 = {
			ja = 7.7,
			ko = 2.533,
			zh = 4.066,
			en = 5.233
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
				arg_74_0:Play101021019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_77_0 = 0
			local var_77_1 = 0.525

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(101021018)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 21 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 21)

				if (21 <= 0 and var_77_1 or var_77_1 * (utf8.len(var_77_3) / 21)) > 0 and var_77_1 < var_77_5 then
					arg_74_1.talkMaxDuration = var_77_5

					if var_77_5 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021018", "story_v_out_101021.awb") ~= 0 then
					local var_77_6 = manager.audio:GetVoiceLength("story_v_out_101021", "101021018", "story_v_out_101021.awb") / 1000

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end

					if var_77_2.prefab_name ~= "" and arg_74_1.actors_[var_77_2.prefab_name] ~= nil then
						local var_77_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_2.prefab_name].transform, "story_v_out_101021", "101021018", "story_v_out_101021.awb")

						arg_74_1:RecordAudio("101021018", var_77_7)
						arg_74_1:RecordAudio("101021018", var_77_7)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_101021", "101021018", "story_v_out_101021.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_101021", "101021018", "story_v_out_101021.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play101021019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 101021019
		arg_78_1.duration_ = 6.97

		local var_78_0 = {
			ja = 6.966,
			ko = 2.466,
			zh = 5.066,
			en = 5
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
				arg_78_0:Play101021020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["3008ui_story"]) and arg_78_1.var_.characterEffect3008ui_story == nil then
				arg_78_1.var_.characterEffect3008ui_story = arg_78_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["3008ui_story"]) then
				if arg_78_1.var_.characterEffect3008ui_story and not isNil(arg_78_1.actors_["3008ui_story"]) then
					arg_78_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_78_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["3008ui_story"]) and arg_78_1.var_.characterEffect3008ui_story then
				arg_78_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_78_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_81_1 = arg_78_1.actors_["1035ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1035ui_story == nil then
				arg_78_1.var_.characterEffect1035ui_story = var_81_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 and not isNil(var_81_1) then
				if arg_78_1.var_.characterEffect1035ui_story and not isNil(var_81_1) then
					arg_78_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1035ui_story then
				arg_78_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action11_2")
			end

			local var_81_4 = 0
			local var_81_5 = 0.65

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(101021019)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 26 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 26)

				if (26 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 26)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021019", "story_v_out_101021.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021019", "story_v_out_101021.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_101021", "101021019", "story_v_out_101021.awb")

						arg_78_1:RecordAudio("101021019", var_81_11)
						arg_78_1:RecordAudio("101021019", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_101021", "101021019", "story_v_out_101021.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_101021", "101021019", "story_v_out_101021.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play101021020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 101021020
		arg_82_1.duration_ = 8.6

		local var_82_0 = {
			ja = 8.6,
			ko = 6.133,
			zh = 4.1,
			en = 4.533
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
				arg_82_0:Play101021021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["3008ui_story"]) and arg_82_1.var_.characterEffect3008ui_story == nil then
				arg_82_1.var_.characterEffect3008ui_story = arg_82_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["3008ui_story"]) then
				if arg_82_1.var_.characterEffect3008ui_story and not isNil(arg_82_1.actors_["3008ui_story"]) then
					arg_82_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["3008ui_story"]) and arg_82_1.var_.characterEffect3008ui_story then
				arg_82_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_85_2 = arg_82_1.actors_["1035ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1035ui_story == nil then
				arg_82_1.var_.characterEffect1035ui_story = var_85_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_3 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.characterEffect1035ui_story and not isNil(var_85_2) then
					arg_82_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_3)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1035ui_story then
				arg_82_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_1")
			end

			local var_85_4 = 0
			local var_85_5 = 0.475

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:GetWordFromCfg(101021020)
				local var_85_7 = arg_82_1:FormatText(var_85_6.content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 19 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 19)

				if (19 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 19)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021020", "story_v_out_101021.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021020", "story_v_out_101021.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_101021", "101021020", "story_v_out_101021.awb")

						arg_82_1:RecordAudio("101021020", var_85_11)
						arg_82_1:RecordAudio("101021020", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_101021", "101021020", "story_v_out_101021.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_101021", "101021020", "story_v_out_101021.awb")
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
	Play101021021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 101021021
		arg_86_1.duration_ = 9

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play101021022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_0 = 2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				local var_89_1 = Color.New(0, 0, 0)

				var_89_1.a = Mathf.Lerp(0, 1, (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.mask_.color = var_89_1
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				local var_89_2 = Color.New(0, 0, 0)

				var_89_2.a = 1
				arg_86_1.mask_.color = var_89_2
			end

			local var_89_3 = 2

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_4 = 2

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_4 then
				local var_89_5 = Color.New(0, 0, 0)

				var_89_5.a = Mathf.Lerp(1, 0, (arg_86_1.time_ - var_89_3) / var_89_4)
				arg_86_1.mask_.color = var_89_5
			end

			if arg_86_1.time_ >= var_89_3 + var_89_4 and arg_86_1.time_ < var_89_3 + var_89_4 + arg_89_0 then
				local var_89_6 = Color.New(0, 0, 0)

				arg_86_1.mask_.enabled = false
				var_89_6.a = 0
				arg_86_1.mask_.color = var_89_6
			end

			local var_89_7 = "B10f"

			if arg_86_1.bgs_.B10f == nil then
				local var_89_8 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_89_7)
				var_89_8.name = var_89_7
				var_89_8.transform.parent = arg_86_1.stage_.transform
				var_89_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_[var_89_7] = var_89_8
			end

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= 2 + arg_89_0 then
				local var_89_9 = arg_86_1.bgs_.B10f

				arg_86_1.bgs_.B10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_89_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_10 = var_89_9:GetComponent("SpriteRenderer")

				if var_89_10 and var_89_10.sprite then
					local var_89_11 = 2 * (var_89_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_89_9.transform.localScale = Vector3.New(var_89_11 / var_89_10.sprite.bounds.size.y < var_89_11 * manager.ui.mainCameraCom_.aspect / var_89_10.sprite.bounds.size.x and var_89_11 * manager.ui.mainCameraCom_.aspect / var_89_10.sprite.bounds.size.x or var_89_11 / var_89_10.sprite.bounds.size.y, var_89_11 / var_89_10.sprite.bounds.size.y < var_89_11 * manager.ui.mainCameraCom_.aspect / var_89_10.sprite.bounds.size.x and var_89_11 * manager.ui.mainCameraCom_.aspect / var_89_10.sprite.bounds.size.x or var_89_11 / var_89_10.sprite.bounds.size.y, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "B10f" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_12 = arg_86_1.actors_["3008ui_story"].transform

			if 1.967 < arg_86_1.time_ and arg_86_1.time_ <= 1.967 + arg_89_0 then
				arg_86_1.var_.moveOldPos3008ui_story = var_89_12.localPosition
			end

			local var_89_13 = 0.001

			if 1.967 <= arg_86_1.time_ and arg_86_1.time_ < 1.967 + var_89_13 then
				var_89_12.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 1.967) / var_89_13)
				var_89_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_12.position).x, (manager.ui.mainCamera.transform.position - var_89_12.position).y, (manager.ui.mainCamera.transform.position - var_89_12.position).z)
				var_89_12.localEulerAngles.z = 0
				var_89_12.localEulerAngles.x = 0
				var_89_12.localEulerAngles = var_89_12.localEulerAngles
			end

			if arg_86_1.time_ >= 1.967 + var_89_13 and arg_86_1.time_ < 1.967 + var_89_13 + arg_89_0 then
				var_89_12.localPosition = Vector3.New(0, 100, 0)
				var_89_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_12.position).x, (manager.ui.mainCamera.transform.position - var_89_12.position).y, (manager.ui.mainCamera.transform.position - var_89_12.position).z)
				var_89_12.localEulerAngles.z = 0
				var_89_12.localEulerAngles.x = 0
				var_89_12.localEulerAngles = var_89_12.localEulerAngles
			end

			local var_89_14 = arg_86_1.actors_["1035ui_story"].transform

			if 1.967 < arg_86_1.time_ and arg_86_1.time_ <= 1.967 + arg_89_0 then
				arg_86_1.var_.moveOldPos1035ui_story = var_89_14.localPosition
			end

			local var_89_15 = 0.001

			if 1.967 <= arg_86_1.time_ and arg_86_1.time_ < 1.967 + var_89_15 then
				var_89_14.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 1.967) / var_89_15)
				var_89_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_14.position).x, (manager.ui.mainCamera.transform.position - var_89_14.position).y, (manager.ui.mainCamera.transform.position - var_89_14.position).z)
				var_89_14.localEulerAngles.z = 0
				var_89_14.localEulerAngles.x = 0
				var_89_14.localEulerAngles = var_89_14.localEulerAngles
			end

			if arg_86_1.time_ >= 1.967 + var_89_15 and arg_86_1.time_ < 1.967 + var_89_15 + arg_89_0 then
				var_89_14.localPosition = Vector3.New(0, 100, 0)
				var_89_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_14.position).x, (manager.ui.mainCamera.transform.position - var_89_14.position).y, (manager.ui.mainCamera.transform.position - var_89_14.position).z)
				var_89_14.localEulerAngles.z = 0
				var_89_14.localEulerAngles.x = 0
				var_89_14.localEulerAngles = var_89_14.localEulerAngles
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_16 = 4
			local var_89_17 = 0.625

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_18 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_18:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_86_1.dialogCg_.alpha = arg_90_0
				end))
				var_89_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_19 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(101021021).content)

				arg_86_1.text_.text = var_89_19

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_21 = 24 <= 0 and var_89_17 or var_89_17 * (utf8.len(var_89_19) / 24)

				if (24 <= 0 and var_89_17 or var_89_17 * (utf8.len(var_89_19) / 24)) > 0 and var_89_17 < var_89_21 then
					arg_86_1.talkMaxDuration = var_89_21
					var_89_16 = var_89_16 + 0.3

					if var_89_21 + var_89_16 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_21 + var_89_16
					end
				end

				arg_86_1.text_.text = var_89_19
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = var_89_16 + 0.3
			local var_89_23 = math.max(var_89_17, arg_86_1.talkMaxDuration)

			if var_89_16 + 0.3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_22 + var_89_23 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_22) / var_89_23

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_22 + var_89_23 and arg_86_1.time_ < var_89_22 + var_89_23 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play101021022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101021022
		arg_92_1.duration_ = 12.8

		local var_92_0 = {
			ja = 12.8,
			ko = 6.866,
			zh = 6.5,
			en = 8
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
				arg_92_0:Play101021023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if arg_92_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_95_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_92_1.stage_.transform)

				var_95_0.name = "10001_tpose"
				var_95_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["10001_tpose"] = var_95_0

				local var_95_1 = var_95_0:GetComponentInChildren(typeof(CharacterEffect))

				var_95_1.enabled = true

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end

				arg_92_1:ShowWeapon(var_95_1.transform, false)

				arg_92_1.var_["10001_tpose" .. "Animator"] = var_95_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_92_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_92_1.var_["10001_tpose" .. "LipSync"] = var_95_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_95_3 = arg_92_1.actors_["10001_tpose"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10001_tpose = var_95_3.localPosition

				local var_95_4 = GameObjectTools.GetOrAddComponent(var_95_3.gameObject, typeof(DynamicBoneHelper))

				if var_95_4 then
					var_95_4:EnableDynamicBone(false)
				end
			end

			local var_95_5 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_5 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_92_1.time_ - 0) / var_95_5)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_5 and arg_92_1.time_ < 0 + var_95_5 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(0, -1.23, -5.8)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles

				local var_95_6 = GameObjectTools.GetOrAddComponent(var_95_3.gameObject, typeof(DynamicBoneHelper))

				if var_95_6 then
					var_95_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action1_1")
			end

			local var_95_7 = 0
			local var_95_8 = 1.05

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[23].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_9 = arg_92_1:GetWordFromCfg(101021022)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_12 = 42 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_10) / 42)

				if (42 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_10) / 42)) > 0 and var_95_8 < var_95_12 then
					arg_92_1.talkMaxDuration = var_95_12

					if var_95_12 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_7
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021022", "story_v_out_101021.awb") ~= 0 then
					local var_95_13 = manager.audio:GetVoiceLength("story_v_out_101021", "101021022", "story_v_out_101021.awb") / 1000

					if var_95_13 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_7
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_101021", "101021022", "story_v_out_101021.awb")

						arg_92_1:RecordAudio("101021022", var_95_14)
						arg_92_1:RecordAudio("101021022", var_95_14)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101021", "101021022", "story_v_out_101021.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101021", "101021022", "story_v_out_101021.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_15 = math.max(var_95_8, arg_92_1.talkMaxDuration)

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_15 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_7) / var_95_15

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_7 + var_95_15 and arg_92_1.time_ < var_95_7 + var_95_15 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play101021023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101021023
		arg_96_1.duration_ = 6.9

		local var_96_0 = {
			ja = 4.266,
			ko = 3.3,
			zh = 3.866,
			en = 6.9
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
				arg_96_0:Play101021024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10001_tpose"]) and arg_96_1.var_.characterEffect10001_tpose == nil then
				arg_96_1.var_.characterEffect10001_tpose = arg_96_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10001_tpose"]) then
				if arg_96_1.var_.characterEffect10001_tpose and not isNil(arg_96_1.actors_["10001_tpose"]) then
					arg_96_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10001_tpose"]) and arg_96_1.var_.characterEffect10001_tpose then
				arg_96_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_2 = 0
			local var_99_3 = 0.425

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(101021023)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 17 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 17)

				if (17 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 17)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021023", "story_v_out_101021.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_101021", "101021023", "story_v_out_101021.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_101021", "101021023", "story_v_out_101021.awb")

						arg_96_1:RecordAudio("101021023", var_99_9)
						arg_96_1:RecordAudio("101021023", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101021", "101021023", "story_v_out_101021.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101021", "101021023", "story_v_out_101021.awb")
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
	Play101021024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 101021024
		arg_100_1.duration_ = 11.9

		local var_100_0 = {
			ja = 11.9,
			ko = 9.9,
			zh = 9.6,
			en = 11.666
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play101021025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["10001_tpose"]) and arg_100_1.var_.characterEffect10001_tpose == nil then
				arg_100_1.var_.characterEffect10001_tpose = arg_100_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["10001_tpose"]) then
				if arg_100_1.var_.characterEffect10001_tpose and not isNil(arg_100_1.actors_["10001_tpose"]) then
					arg_100_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_100_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["10001_tpose"]) and arg_100_1.var_.characterEffect10001_tpose then
				arg_100_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_100_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 1.425

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[25].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:GetWordFromCfg(101021024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_6 = 57 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 57)

				if (57 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 57)) > 0 and var_103_2 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021024", "story_v_out_101021.awb") ~= 0 then
					local var_103_7 = manager.audio:GetVoiceLength("story_v_out_101021", "101021024", "story_v_out_101021.awb") / 1000

					if var_103_7 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_1
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_101021", "101021024", "story_v_out_101021.awb")

						arg_100_1:RecordAudio("101021024", var_103_8)
						arg_100_1:RecordAudio("101021024", var_103_8)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_101021", "101021024", "story_v_out_101021.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_101021", "101021024", "story_v_out_101021.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_9 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_9 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_9

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_9 and arg_100_1.time_ < var_103_1 + var_103_9 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play101021025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 101021025
		arg_104_1.duration_ = 3.67

		local var_104_0 = {
			ja = 3.666,
			ko = 2,
			zh = 1.999999999998,
			en = 2.433
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
				arg_104_0:Play101021026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10001_tpose"]) and arg_104_1.var_.characterEffect10001_tpose == nil then
				arg_104_1.var_.characterEffect10001_tpose = arg_104_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10001_tpose"]) then
				if arg_104_1.var_.characterEffect10001_tpose and not isNil(arg_104_1.actors_["10001_tpose"]) then
					arg_104_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10001_tpose"]) and arg_104_1.var_.characterEffect10001_tpose then
				arg_104_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action424")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_107_2 = 0
			local var_107_3 = 0.125

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(101021025)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 5 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 5)

				if (5 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 5)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021025", "story_v_out_101021.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_101021", "101021025", "story_v_out_101021.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_101021", "101021025", "story_v_out_101021.awb")

						arg_104_1:RecordAudio("101021025", var_107_9)
						arg_104_1:RecordAudio("101021025", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_101021", "101021025", "story_v_out_101021.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_101021", "101021025", "story_v_out_101021.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play101021026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 101021026
		arg_108_1.duration_ = 9.97

		local var_108_0 = {
			ja = 9.966,
			ko = 4.5,
			zh = 6.3,
			en = 9.233
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
				arg_108_0:Play101021027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["10001_tpose"]) and arg_108_1.var_.characterEffect10001_tpose == nil then
				arg_108_1.var_.characterEffect10001_tpose = arg_108_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["10001_tpose"]) then
				if arg_108_1.var_.characterEffect10001_tpose and not isNil(arg_108_1.actors_["10001_tpose"]) then
					arg_108_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_108_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["10001_tpose"]) and arg_108_1.var_.characterEffect10001_tpose then
				arg_108_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_108_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.975

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[26].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(101021026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 40 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 40)

				if (40 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 40)) > 0 and var_111_2 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021026", "story_v_out_101021.awb") ~= 0 then
					local var_111_7 = manager.audio:GetVoiceLength("story_v_out_101021", "101021026", "story_v_out_101021.awb") / 1000

					if var_111_7 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_1
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_101021", "101021026", "story_v_out_101021.awb")

						arg_108_1:RecordAudio("101021026", var_111_8)
						arg_108_1:RecordAudio("101021026", var_111_8)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_101021", "101021026", "story_v_out_101021.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_101021", "101021026", "story_v_out_101021.awb")
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

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play101021027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 101021027
		arg_112_1.duration_ = 16.83

		local var_112_0 = {
			ja = 14.7,
			ko = 12.1,
			zh = 12.333,
			en = 16.833
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
				arg_112_0:Play101021028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10001_tpose"]) and arg_112_1.var_.characterEffect10001_tpose == nil then
				arg_112_1.var_.characterEffect10001_tpose = arg_112_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10001_tpose"]) then
				if arg_112_1.var_.characterEffect10001_tpose and not isNil(arg_112_1.actors_["10001_tpose"]) then
					arg_112_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10001_tpose"]) and arg_112_1.var_.characterEffect10001_tpose then
				arg_112_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_2")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_115_2 = 0
			local var_115_3 = 1.525

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(101021027)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 61 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 61)

				if (61 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 61)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021027", "story_v_out_101021.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_101021", "101021027", "story_v_out_101021.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_101021", "101021027", "story_v_out_101021.awb")

						arg_112_1:RecordAudio("101021027", var_115_9)
						arg_112_1:RecordAudio("101021027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_101021", "101021027", "story_v_out_101021.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_101021", "101021027", "story_v_out_101021.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play101021028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 101021028
		arg_116_1.duration_ = 6.87

		local var_116_0 = {
			ja = 6.866,
			ko = 4.033,
			zh = 4.533,
			en = 6.466
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
				arg_116_0:Play101021029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["10001_tpose"]) and arg_116_1.var_.characterEffect10001_tpose == nil then
				arg_116_1.var_.characterEffect10001_tpose = arg_116_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["10001_tpose"]) then
				if arg_116_1.var_.characterEffect10001_tpose and not isNil(arg_116_1.actors_["10001_tpose"]) then
					arg_116_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_116_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["10001_tpose"]) and arg_116_1.var_.characterEffect10001_tpose then
				arg_116_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_116_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.625

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[27].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(101021028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_6 = 25 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_4) / 25)

				if (25 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_4) / 25)) > 0 and var_119_2 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021028", "story_v_out_101021.awb") ~= 0 then
					local var_119_7 = manager.audio:GetVoiceLength("story_v_out_101021", "101021028", "story_v_out_101021.awb") / 1000

					if var_119_7 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_1
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_101021", "101021028", "story_v_out_101021.awb")

						arg_116_1:RecordAudio("101021028", var_119_8)
						arg_116_1:RecordAudio("101021028", var_119_8)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_101021", "101021028", "story_v_out_101021.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_101021", "101021028", "story_v_out_101021.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_9 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_9 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_9

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_9 and arg_116_1.time_ < var_119_1 + var_119_9 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play101021029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 101021029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play101021030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:AudioAction("play", "effect", "se_story_ui", "se_story_env_highcut_open", "")
			end

			local var_123_1 = arg_120_1.actors_["10001_tpose"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos10001_tpose = var_123_1.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_1.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 then
				var_123_1.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_3)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 then
				var_123_1.localPosition = Vector3.New(0, 100, 0)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles

				local var_123_4 = GameObjectTools.GetOrAddComponent(var_123_1.gameObject, typeof(DynamicBoneHelper))

				if var_123_4 then
					var_123_4:EnableDynamicBone(true)
				end
			end

			local var_123_5 = 0
			local var_123_6 = 1.3

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_7 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_7:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(101021029).content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 52 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 52)

				if (52 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 52)) > 0 and var_123_6 < var_123_10 then
					arg_120_1.talkMaxDuration = var_123_10
					var_123_5 = var_123_5 + 0.3

					if var_123_10 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_11 = var_123_5 + 0.3
			local var_123_12 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 + 0.3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_11) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_11 + var_123_12 and arg_120_1.time_ < var_123_11 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play101021030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 101021030
		arg_126_1.duration_ = 15.7

		local var_126_0 = {
			ja = 15.7,
			ko = 10.533,
			zh = 8.9,
			en = 10.666
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
				arg_126_0:Play101021031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if arg_126_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_129_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_126_1.stage_.transform)

				var_129_0.name = "1148ui_story"
				var_129_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["1148ui_story"] = var_129_0

				local var_129_1 = var_129_0:GetComponentInChildren(typeof(CharacterEffect))

				var_129_1.enabled = true

				local var_129_2 = GameObjectTools.GetOrAddComponent(var_129_0, typeof(DynamicBoneHelper))

				if var_129_2 then
					var_129_2:EnableDynamicBone(false)
				end

				arg_126_1:ShowWeapon(var_129_1.transform, false)

				arg_126_1.var_["1148ui_story" .. "Animator"] = var_129_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_126_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_126_1.var_["1148ui_story" .. "LipSync"] = var_129_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_129_3 = arg_126_1.actors_["1148ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1148ui_story == nil then
				arg_126_1.var_.characterEffect1148ui_story = var_129_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_4 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 and not isNil(var_129_3) then
				if arg_126_1.var_.characterEffect1148ui_story and not isNil(var_129_3) then
					arg_126_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1148ui_story then
				arg_126_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_129_6 = arg_126_1.actors_["1148ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1148ui_story = var_129_6.localPosition
			end

			local var_129_7 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				var_129_6.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_126_1.time_ - 0) / var_129_7)
				var_129_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_6.position).x, (manager.ui.mainCamera.transform.position - var_129_6.position).y, (manager.ui.mainCamera.transform.position - var_129_6.position).z)
				var_129_6.localEulerAngles.z = 0
				var_129_6.localEulerAngles.x = 0
				var_129_6.localEulerAngles = var_129_6.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				var_129_6.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_129_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_6.position).x, (manager.ui.mainCamera.transform.position - var_129_6.position).y, (manager.ui.mainCamera.transform.position - var_129_6.position).z)
				var_129_6.localEulerAngles.z = 0
				var_129_6.localEulerAngles.x = 0
				var_129_6.localEulerAngles = var_129_6.localEulerAngles
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_129_8 = 0
			local var_129_9 = 1.175

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_10 = arg_126_1:GetWordFromCfg(101021030)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 47 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 47)

				if (47 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 47)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021030", "story_v_out_101021.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_101021", "101021030", "story_v_out_101021.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_101021", "101021030", "story_v_out_101021.awb")

						arg_126_1:RecordAudio("101021030", var_129_15)
						arg_126_1:RecordAudio("101021030", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_101021", "101021030", "story_v_out_101021.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_101021", "101021030", "story_v_out_101021.awb")
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
				actorName = "1148ui_story",
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
	Play101021031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 101021031
		arg_130_1.duration_ = 9.17

		local var_130_0 = {
			ja = 9.166,
			ko = 5.8,
			zh = 7.433,
			en = 6.3
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
				arg_130_0:Play101021032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if arg_130_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_133_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_130_1.stage_.transform)

				var_133_0.name = "1059ui_story"
				var_133_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_["1059ui_story"] = var_133_0

				local var_133_1 = var_133_0:GetComponentInChildren(typeof(CharacterEffect))

				var_133_1.enabled = true

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end

				arg_130_1:ShowWeapon(var_133_1.transform, false)

				arg_130_1.var_["1059ui_story" .. "Animator"] = var_133_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_130_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_130_1.var_["1059ui_story" .. "LipSync"] = var_133_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_133_3 = arg_130_1.actors_["1059ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect1059ui_story == nil then
				arg_130_1.var_.characterEffect1059ui_story = var_133_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_4 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 and not isNil(var_133_3) then
				if arg_130_1.var_.characterEffect1059ui_story and not isNil(var_133_3) then
					arg_130_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect1059ui_story then
				arg_130_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_133_6 = arg_130_1.actors_["1148ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect1148ui_story == nil then
				arg_130_1.var_.characterEffect1148ui_story = var_133_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_7 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 and not isNil(var_133_6) then
				if arg_130_1.var_.characterEffect1148ui_story and not isNil(var_133_6) then
					arg_130_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_7)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect1148ui_story then
				arg_130_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_133_8 = arg_130_1.actors_["1059ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1059ui_story = var_133_8.localPosition
			end

			local var_133_9 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_9 then
				var_133_8.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_130_1.time_ - 0) / var_133_9)
				var_133_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_8.position).x, (manager.ui.mainCamera.transform.position - var_133_8.position).y, (manager.ui.mainCamera.transform.position - var_133_8.position).z)
				var_133_8.localEulerAngles.z = 0
				var_133_8.localEulerAngles.x = 0
				var_133_8.localEulerAngles = var_133_8.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_9 and arg_130_1.time_ < 0 + var_133_9 + arg_133_0 then
				var_133_8.localPosition = Vector3.New(0.7, -1.05, -6)
				var_133_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_8.position).x, (manager.ui.mainCamera.transform.position - var_133_8.position).y, (manager.ui.mainCamera.transform.position - var_133_8.position).z)
				var_133_8.localEulerAngles.z = 0
				var_133_8.localEulerAngles.x = 0
				var_133_8.localEulerAngles = var_133_8.localEulerAngles
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_133_10 = 0
			local var_133_11 = 0.675

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_12 = arg_130_1:GetWordFromCfg(101021031)
				local var_133_13 = arg_130_1:FormatText(var_133_12.content)

				arg_130_1.text_.text = var_133_13

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_15 = 27 <= 0 and var_133_11 or var_133_11 * (utf8.len(var_133_13) / 27)

				if (27 <= 0 and var_133_11 or var_133_11 * (utf8.len(var_133_13) / 27)) > 0 and var_133_11 < var_133_15 then
					arg_130_1.talkMaxDuration = var_133_15

					if var_133_15 + var_133_10 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_15 + var_133_10
					end
				end

				arg_130_1.text_.text = var_133_13
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021031", "story_v_out_101021.awb") ~= 0 then
					local var_133_16 = manager.audio:GetVoiceLength("story_v_out_101021", "101021031", "story_v_out_101021.awb") / 1000

					if var_133_16 + var_133_10 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_16 + var_133_10
					end

					if var_133_12.prefab_name ~= "" and arg_130_1.actors_[var_133_12.prefab_name] ~= nil then
						local var_133_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_12.prefab_name].transform, "story_v_out_101021", "101021031", "story_v_out_101021.awb")

						arg_130_1:RecordAudio("101021031", var_133_17)
						arg_130_1:RecordAudio("101021031", var_133_17)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_101021", "101021031", "story_v_out_101021.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_101021", "101021031", "story_v_out_101021.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_18 = math.max(var_133_11, arg_130_1.talkMaxDuration)

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_18 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_10) / var_133_18

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_10 + var_133_18 and arg_130_1.time_ < var_133_10 + var_133_18 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play101021032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 101021032
		arg_134_1.duration_ = 6.43

		local var_134_0 = {
			ja = 6.433,
			ko = 5.633,
			zh = 3.7,
			en = 2.433
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
				arg_134_0:Play101021033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1148ui_story"]) and arg_134_1.var_.characterEffect1148ui_story == nil then
				arg_134_1.var_.characterEffect1148ui_story = arg_134_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.1

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1148ui_story"]) then
				if arg_134_1.var_.characterEffect1148ui_story and not isNil(arg_134_1.actors_["1148ui_story"]) then
					arg_134_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1148ui_story"]) and arg_134_1.var_.characterEffect1148ui_story then
				arg_134_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_137_2 = arg_134_1.actors_["1059ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1059ui_story == nil then
				arg_134_1.var_.characterEffect1059ui_story = var_137_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_3 = 0.1

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.characterEffect1059ui_story and not isNil(var_137_2) then
					arg_134_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_3)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1059ui_story then
				arg_134_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action453")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_137_4 = 0
			local var_137_5 = 0.35

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(101021032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 14 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 14)

				if (14 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 14)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021032", "story_v_out_101021.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021032", "story_v_out_101021.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_101021", "101021032", "story_v_out_101021.awb")

						arg_134_1:RecordAudio("101021032", var_137_11)
						arg_134_1:RecordAudio("101021032", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_101021", "101021032", "story_v_out_101021.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_101021", "101021032", "story_v_out_101021.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play101021033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 101021033
		arg_138_1.duration_ = 6.7

		local var_138_0 = {
			ja = 6.7,
			ko = 3.3,
			zh = 3.266,
			en = 2.9
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
				arg_138_0:Play101021034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1059ui_story"]) and arg_138_1.var_.characterEffect1059ui_story == nil then
				arg_138_1.var_.characterEffect1059ui_story = arg_138_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1059ui_story"]) then
				if arg_138_1.var_.characterEffect1059ui_story and not isNil(arg_138_1.actors_["1059ui_story"]) then
					arg_138_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1059ui_story"]) and arg_138_1.var_.characterEffect1059ui_story then
				arg_138_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_141_2 = arg_138_1.actors_["1148ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1148ui_story == nil then
				arg_138_1.var_.characterEffect1148ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_3 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.characterEffect1148ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_3)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1148ui_story then
				arg_138_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action434")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_141_4 = 0
			local var_141_5 = 0.425

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_6 = arg_138_1:GetWordFromCfg(101021033)
				local var_141_7 = arg_138_1:FormatText(var_141_6.content)

				arg_138_1.text_.text = var_141_7

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_9 = 17 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 17)

				if (17 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 17)) > 0 and var_141_5 < var_141_9 then
					arg_138_1.talkMaxDuration = var_141_9

					if var_141_9 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_4
					end
				end

				arg_138_1.text_.text = var_141_7
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021033", "story_v_out_101021.awb") ~= 0 then
					local var_141_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021033", "story_v_out_101021.awb") / 1000

					if var_141_10 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_4
					end

					if var_141_6.prefab_name ~= "" and arg_138_1.actors_[var_141_6.prefab_name] ~= nil then
						local var_141_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_6.prefab_name].transform, "story_v_out_101021", "101021033", "story_v_out_101021.awb")

						arg_138_1:RecordAudio("101021033", var_141_11)
						arg_138_1:RecordAudio("101021033", var_141_11)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_101021", "101021033", "story_v_out_101021.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_101021", "101021033", "story_v_out_101021.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_12 = math.max(var_141_5, arg_138_1.talkMaxDuration)

			if var_141_4 <= arg_138_1.time_ and arg_138_1.time_ < var_141_4 + var_141_12 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_4) / var_141_12

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_4 + var_141_12 and arg_138_1.time_ < var_141_4 + var_141_12 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play101021034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 101021034
		arg_142_1.duration_ = 9.17

		local var_142_0 = {
			ja = 8.4,
			ko = 9.166,
			zh = 6.133,
			en = 7.533
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
				arg_142_0:Play101021035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action447")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_145_0 = 0
			local var_145_1 = 0.85

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(101021034)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 34 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 34)

				if (34 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 34)) > 0 and var_145_1 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021034", "story_v_out_101021.awb") ~= 0 then
					local var_145_6 = manager.audio:GetVoiceLength("story_v_out_101021", "101021034", "story_v_out_101021.awb") / 1000

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end

					if var_145_2.prefab_name ~= "" and arg_142_1.actors_[var_145_2.prefab_name] ~= nil then
						local var_145_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_2.prefab_name].transform, "story_v_out_101021", "101021034", "story_v_out_101021.awb")

						arg_142_1:RecordAudio("101021034", var_145_7)
						arg_142_1:RecordAudio("101021034", var_145_7)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_101021", "101021034", "story_v_out_101021.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_101021", "101021034", "story_v_out_101021.awb")
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
	Play101021035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 101021035
		arg_146_1.duration_ = 9.13

		local var_146_0 = {
			ja = 9.133,
			ko = 5.4,
			zh = 5.066,
			en = 6.833
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
				arg_146_0:Play101021036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1148ui_story"]) and arg_146_1.var_.characterEffect1148ui_story == nil then
				arg_146_1.var_.characterEffect1148ui_story = arg_146_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.1

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1148ui_story"]) then
				if arg_146_1.var_.characterEffect1148ui_story and not isNil(arg_146_1.actors_["1148ui_story"]) then
					arg_146_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1148ui_story"]) and arg_146_1.var_.characterEffect1148ui_story then
				arg_146_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_149_2 = arg_146_1.actors_["1059ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect1059ui_story == nil then
				arg_146_1.var_.characterEffect1059ui_story = var_149_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_3 = 0.1

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.characterEffect1059ui_story and not isNil(var_149_2) then
					arg_146_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_3)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect1059ui_story then
				arg_146_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action437")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_149_4 = 0
			local var_149_5 = 0.425

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(101021035)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 17 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 17)

				if (17 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 17)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021035", "story_v_out_101021.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021035", "story_v_out_101021.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_out_101021", "101021035", "story_v_out_101021.awb")

						arg_146_1:RecordAudio("101021035", var_149_11)
						arg_146_1:RecordAudio("101021035", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_101021", "101021035", "story_v_out_101021.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_101021", "101021035", "story_v_out_101021.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play101021036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 101021036
		arg_150_1.duration_ = 9.27

		local var_150_0 = {
			ja = 9.266,
			ko = 7.333,
			zh = 6.1,
			en = 5.1
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
				arg_150_0:Play101021037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1059ui_story"]) and arg_150_1.var_.characterEffect1059ui_story == nil then
				arg_150_1.var_.characterEffect1059ui_story = arg_150_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1059ui_story"]) then
				if arg_150_1.var_.characterEffect1059ui_story and not isNil(arg_150_1.actors_["1059ui_story"]) then
					arg_150_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1059ui_story"]) and arg_150_1.var_.characterEffect1059ui_story then
				arg_150_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_153_2 = arg_150_1.actors_["1148ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1148ui_story == nil then
				arg_150_1.var_.characterEffect1148ui_story = var_153_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_3 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.characterEffect1148ui_story and not isNil(var_153_2) then
					arg_150_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_3)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1148ui_story then
				arg_150_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action476")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_153_4 = 0
			local var_153_5 = 0.65

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_6 = arg_150_1:GetWordFromCfg(101021036)
				local var_153_7 = arg_150_1:FormatText(var_153_6.content)

				arg_150_1.text_.text = var_153_7

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 26 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 26)

				if (26 <= 0 and var_153_5 or var_153_5 * (utf8.len(var_153_7) / 26)) > 0 and var_153_5 < var_153_9 then
					arg_150_1.talkMaxDuration = var_153_9

					if var_153_9 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_4
					end
				end

				arg_150_1.text_.text = var_153_7
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021036", "story_v_out_101021.awb") ~= 0 then
					local var_153_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021036", "story_v_out_101021.awb") / 1000

					if var_153_10 + var_153_4 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_4
					end

					if var_153_6.prefab_name ~= "" and arg_150_1.actors_[var_153_6.prefab_name] ~= nil then
						local var_153_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_6.prefab_name].transform, "story_v_out_101021", "101021036", "story_v_out_101021.awb")

						arg_150_1:RecordAudio("101021036", var_153_11)
						arg_150_1:RecordAudio("101021036", var_153_11)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_101021", "101021036", "story_v_out_101021.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_101021", "101021036", "story_v_out_101021.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_12 = math.max(var_153_5, arg_150_1.talkMaxDuration)

			if var_153_4 <= arg_150_1.time_ and arg_150_1.time_ < var_153_4 + var_153_12 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_4) / var_153_12

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_4 + var_153_12 and arg_150_1.time_ < var_153_4 + var_153_12 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play101021037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 101021037
		arg_154_1.duration_ = 7.7

		local var_154_0 = {
			ja = 7.7,
			ko = 5.966,
			zh = 5.566,
			en = 5.4
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
				arg_154_0:Play101021038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:AudioAction("play", "effect", "se_story_ui", "se_story_env_highcut_close", "")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_157_2 = "2044_tpose"

			if arg_154_1.actors_["2044_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2044_tpose"))) then
				local var_157_3 = Object.Instantiate(Asset.Load("Char/" .. "2044_tpose"), arg_154_1.stage_.transform)

				var_157_3.name = var_157_2
				var_157_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_[var_157_2] = var_157_3

				local var_157_4 = var_157_3:GetComponentInChildren(typeof(CharacterEffect))

				var_157_4.enabled = true

				local var_157_5 = GameObjectTools.GetOrAddComponent(var_157_3, typeof(DynamicBoneHelper))

				if var_157_5 then
					var_157_5:EnableDynamicBone(false)
				end

				arg_154_1:ShowWeapon(var_157_4.transform, false)

				arg_154_1.var_[var_157_2 .. "Animator"] = var_157_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_154_1.var_[var_157_2 .. "Animator"].applyRootMotion = true
				arg_154_1.var_[var_157_2 .. "LipSync"] = var_157_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_157_6 = arg_154_1.actors_["2044_tpose"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_6) and arg_154_1.var_.characterEffect2044_tpose == nil then
				arg_154_1.var_.characterEffect2044_tpose = var_157_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_7 = 0.1

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 and not isNil(var_157_6) then
				if arg_154_1.var_.characterEffect2044_tpose and not isNil(var_157_6) then
					arg_154_1.var_.characterEffect2044_tpose.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 and not isNil(var_157_6) and arg_154_1.var_.characterEffect2044_tpose then
				arg_154_1.var_.characterEffect2044_tpose.fillFlat = false
			end

			local var_157_9 = arg_154_1.actors_["1059ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1059ui_story == nil then
				arg_154_1.var_.characterEffect1059ui_story = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_10 = 0.1

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_10 and not isNil(var_157_9) then
				if arg_154_1.var_.characterEffect1059ui_story and not isNil(var_157_9) then
					arg_154_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_10)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_10 and arg_154_1.time_ < 0 + var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1059ui_story then
				arg_154_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_157_11 = arg_154_1.actors_["1059ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1059ui_story = var_157_11.localPosition
			end

			local var_157_12 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_12 then
				var_157_11.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_12)
				var_157_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_11.position).x, (manager.ui.mainCamera.transform.position - var_157_11.position).y, (manager.ui.mainCamera.transform.position - var_157_11.position).z)
				var_157_11.localEulerAngles.z = 0
				var_157_11.localEulerAngles.x = 0
				var_157_11.localEulerAngles = var_157_11.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_12 and arg_154_1.time_ < 0 + var_157_12 + arg_157_0 then
				var_157_11.localPosition = Vector3.New(0, 100, 0)
				var_157_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_11.position).x, (manager.ui.mainCamera.transform.position - var_157_11.position).y, (manager.ui.mainCamera.transform.position - var_157_11.position).z)
				var_157_11.localEulerAngles.z = 0
				var_157_11.localEulerAngles.x = 0
				var_157_11.localEulerAngles = var_157_11.localEulerAngles
			end

			local var_157_13 = arg_154_1.actors_["1148ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1148ui_story = var_157_13.localPosition
			end

			local var_157_14 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_14 then
				var_157_13.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_14)
				var_157_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_13.position).x, (manager.ui.mainCamera.transform.position - var_157_13.position).y, (manager.ui.mainCamera.transform.position - var_157_13.position).z)
				var_157_13.localEulerAngles.z = 0
				var_157_13.localEulerAngles.x = 0
				var_157_13.localEulerAngles = var_157_13.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_14 and arg_154_1.time_ < 0 + var_157_14 + arg_157_0 then
				var_157_13.localPosition = Vector3.New(0, 100, 0)
				var_157_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_13.position).x, (manager.ui.mainCamera.transform.position - var_157_13.position).y, (manager.ui.mainCamera.transform.position - var_157_13.position).z)
				var_157_13.localEulerAngles.z = 0
				var_157_13.localEulerAngles.x = 0
				var_157_13.localEulerAngles = var_157_13.localEulerAngles
			end

			local var_157_15 = arg_154_1.actors_["2044_tpose"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos2044_tpose = var_157_15.localPosition

				local var_157_16 = GameObjectTools.GetOrAddComponent(var_157_15.gameObject, typeof(DynamicBoneHelper))

				if var_157_16 then
					var_157_16:EnableDynamicBone(false)
				end
			end

			local var_157_17 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_17 then
				var_157_15.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos2044_tpose, Vector3.New(0, -1.15, -2.3), (arg_154_1.time_ - 0) / var_157_17)
				var_157_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_15.position).x, (manager.ui.mainCamera.transform.position - var_157_15.position).y, (manager.ui.mainCamera.transform.position - var_157_15.position).z)
				var_157_15.localEulerAngles.z = 0
				var_157_15.localEulerAngles.x = 0
				var_157_15.localEulerAngles = var_157_15.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_17 and arg_154_1.time_ < 0 + var_157_17 + arg_157_0 then
				var_157_15.localPosition = Vector3.New(0, -1.15, -2.3)
				var_157_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_15.position).x, (manager.ui.mainCamera.transform.position - var_157_15.position).y, (manager.ui.mainCamera.transform.position - var_157_15.position).z)
				var_157_15.localEulerAngles.z = 0
				var_157_15.localEulerAngles.x = 0
				var_157_15.localEulerAngles = var_157_15.localEulerAngles

				local var_157_18 = GameObjectTools.GetOrAddComponent(var_157_15.gameObject, typeof(DynamicBoneHelper))

				if var_157_18 then
					var_157_18:EnableDynamicBone(true)
				end
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("2044_tpose", "StoryTimeline/CharAction/story2044/story2044action/2044action1_1")
			end

			local var_157_19 = 0
			local var_157_20 = 0.6

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_19 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_21 = arg_154_1:GetWordFromCfg(101021037)
				local var_157_22 = arg_154_1:FormatText(var_157_21.content)

				arg_154_1.text_.text = var_157_22

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_24 = 23 <= 0 and var_157_20 or var_157_20 * (utf8.len(var_157_22) / 23)

				if (23 <= 0 and var_157_20 or var_157_20 * (utf8.len(var_157_22) / 23)) > 0 and var_157_20 < var_157_24 then
					arg_154_1.talkMaxDuration = var_157_24

					if var_157_24 + var_157_19 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_24 + var_157_19
					end
				end

				arg_154_1.text_.text = var_157_22
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021037", "story_v_out_101021.awb") ~= 0 then
					local var_157_25 = manager.audio:GetVoiceLength("story_v_out_101021", "101021037", "story_v_out_101021.awb") / 1000

					if var_157_25 + var_157_19 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_25 + var_157_19
					end

					if var_157_21.prefab_name ~= "" and arg_154_1.actors_[var_157_21.prefab_name] ~= nil then
						local var_157_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_21.prefab_name].transform, "story_v_out_101021", "101021037", "story_v_out_101021.awb")

						arg_154_1:RecordAudio("101021037", var_157_26)
						arg_154_1:RecordAudio("101021037", var_157_26)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_101021", "101021037", "story_v_out_101021.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_101021", "101021037", "story_v_out_101021.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_27 = math.max(var_157_20, arg_154_1.talkMaxDuration)

			if var_157_19 <= arg_154_1.time_ and arg_154_1.time_ < var_157_19 + var_157_27 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_19) / var_157_27

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_19 + var_157_27 and arg_154_1.time_ < var_157_19 + var_157_27 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play101021038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 101021038
		arg_158_1.duration_ = 7.07

		local var_158_0 = {
			ja = 7.066,
			ko = 4.933,
			zh = 4.433,
			en = 5.1
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play101021039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["2044_tpose"]) and arg_158_1.var_.characterEffect2044_tpose == nil then
				arg_158_1.var_.characterEffect2044_tpose = arg_158_1.actors_["2044_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.1

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["2044_tpose"]) then
				if arg_158_1.var_.characterEffect2044_tpose and not isNil(arg_158_1.actors_["2044_tpose"]) then
					arg_158_1.var_.characterEffect2044_tpose.fillFlat = true
					arg_158_1.var_.characterEffect2044_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["2044_tpose"]) and arg_158_1.var_.characterEffect2044_tpose then
				arg_158_1.var_.characterEffect2044_tpose.fillFlat = true
				arg_158_1.var_.characterEffect2044_tpose.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 0.5

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[30].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:GetWordFromCfg(101021038)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 20 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_4) / 20)

				if (20 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_4) / 20)) > 0 and var_161_2 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021038", "story_v_out_101021.awb") ~= 0 then
					local var_161_7 = manager.audio:GetVoiceLength("story_v_out_101021", "101021038", "story_v_out_101021.awb") / 1000

					if var_161_7 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_1
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_101021", "101021038", "story_v_out_101021.awb")

						arg_158_1:RecordAudio("101021038", var_161_8)
						arg_158_1:RecordAudio("101021038", var_161_8)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_101021", "101021038", "story_v_out_101021.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_101021", "101021038", "story_v_out_101021.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_9 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_9 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_9

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_9 and arg_158_1.time_ < var_161_1 + var_161_9 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play101021039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 101021039
		arg_162_1.duration_ = 3.2

		local var_162_0 = {
			ja = 1.999999999999,
			ko = 2.8,
			zh = 1.999999999999,
			en = 3.2
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
				arg_162_0:Play101021040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["10001_tpose"]) and arg_162_1.var_.characterEffect10001_tpose == nil then
				arg_162_1.var_.characterEffect10001_tpose = arg_162_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.1

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["10001_tpose"]) then
				if arg_162_1.var_.characterEffect10001_tpose and not isNil(arg_162_1.actors_["10001_tpose"]) then
					arg_162_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["10001_tpose"]) and arg_162_1.var_.characterEffect10001_tpose then
				arg_162_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_165_2 = arg_162_1.actors_["2044_tpose"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos2044_tpose = var_165_2.localPosition

				local var_165_3 = GameObjectTools.GetOrAddComponent(var_165_2.gameObject, typeof(DynamicBoneHelper))

				if var_165_3 then
					var_165_3:EnableDynamicBone(false)
				end
			end

			local var_165_4 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				var_165_2.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos2044_tpose, Vector3.New(0, 100, 0), (arg_162_1.time_ - 0) / var_165_4)
				var_165_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_2.position).x, (manager.ui.mainCamera.transform.position - var_165_2.position).y, (manager.ui.mainCamera.transform.position - var_165_2.position).z)
				var_165_2.localEulerAngles.z = 0
				var_165_2.localEulerAngles.x = 0
				var_165_2.localEulerAngles = var_165_2.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				var_165_2.localPosition = Vector3.New(0, 100, 0)
				var_165_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_2.position).x, (manager.ui.mainCamera.transform.position - var_165_2.position).y, (manager.ui.mainCamera.transform.position - var_165_2.position).z)
				var_165_2.localEulerAngles.z = 0
				var_165_2.localEulerAngles.x = 0
				var_165_2.localEulerAngles = var_165_2.localEulerAngles

				local var_165_5 = GameObjectTools.GetOrAddComponent(var_165_2.gameObject, typeof(DynamicBoneHelper))

				if var_165_5 then
					var_165_5:EnableDynamicBone(true)
				end
			end

			local var_165_6 = arg_162_1.actors_["10001_tpose"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos10001_tpose = var_165_6.localPosition

				local var_165_7 = GameObjectTools.GetOrAddComponent(var_165_6.gameObject, typeof(DynamicBoneHelper))

				if var_165_7 then
					var_165_7:EnableDynamicBone(false)
				end
			end

			local var_165_8 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_8 then
				var_165_6.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_162_1.time_ - 0) / var_165_8)
				var_165_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_6.position).x, (manager.ui.mainCamera.transform.position - var_165_6.position).y, (manager.ui.mainCamera.transform.position - var_165_6.position).z)
				var_165_6.localEulerAngles.z = 0
				var_165_6.localEulerAngles.x = 0
				var_165_6.localEulerAngles = var_165_6.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_8 and arg_162_1.time_ < 0 + var_165_8 + arg_165_0 then
				var_165_6.localPosition = Vector3.New(0, -1.23, -5.8)
				var_165_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_6.position).x, (manager.ui.mainCamera.transform.position - var_165_6.position).y, (manager.ui.mainCamera.transform.position - var_165_6.position).z)
				var_165_6.localEulerAngles.z = 0
				var_165_6.localEulerAngles.x = 0
				var_165_6.localEulerAngles = var_165_6.localEulerAngles

				local var_165_9 = GameObjectTools.GetOrAddComponent(var_165_6.gameObject, typeof(DynamicBoneHelper))

				if var_165_9 then
					var_165_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_165_10 = 0
			local var_165_11 = 0.175

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_12 = arg_162_1:GetWordFromCfg(101021039)
				local var_165_13 = arg_162_1:FormatText(var_165_12.content)

				arg_162_1.text_.text = var_165_13

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_15 = 7 <= 0 and var_165_11 or var_165_11 * (utf8.len(var_165_13) / 7)

				if (7 <= 0 and var_165_11 or var_165_11 * (utf8.len(var_165_13) / 7)) > 0 and var_165_11 < var_165_15 then
					arg_162_1.talkMaxDuration = var_165_15

					if var_165_15 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_15 + var_165_10
					end
				end

				arg_162_1.text_.text = var_165_13
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021039", "story_v_out_101021.awb") ~= 0 then
					local var_165_16 = manager.audio:GetVoiceLength("story_v_out_101021", "101021039", "story_v_out_101021.awb") / 1000

					if var_165_16 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_16 + var_165_10
					end

					if var_165_12.prefab_name ~= "" and arg_162_1.actors_[var_165_12.prefab_name] ~= nil then
						local var_165_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_12.prefab_name].transform, "story_v_out_101021", "101021039", "story_v_out_101021.awb")

						arg_162_1:RecordAudio("101021039", var_165_17)
						arg_162_1:RecordAudio("101021039", var_165_17)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_101021", "101021039", "story_v_out_101021.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_101021", "101021039", "story_v_out_101021.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_18 = math.max(var_165_11, arg_162_1.talkMaxDuration)

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_18 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_10) / var_165_18

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_10 + var_165_18 and arg_162_1.time_ < var_165_10 + var_165_18 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2044_tpose",
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

		arg_162_1:InitPlayNodeList()
	end,
	Play101021040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 101021040
		arg_166_1.duration_ = 10.13

		local var_166_0 = {
			ja = 10.133,
			ko = 7.9,
			zh = 7.366,
			en = 8
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
				arg_166_0:Play101021041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10001_tpose"]) and arg_166_1.var_.characterEffect10001_tpose == nil then
				arg_166_1.var_.characterEffect10001_tpose = arg_166_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.1

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10001_tpose"]) then
				if arg_166_1.var_.characterEffect10001_tpose and not isNil(arg_166_1.actors_["10001_tpose"]) then
					arg_166_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_166_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_0)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10001_tpose"]) and arg_166_1.var_.characterEffect10001_tpose then
				arg_166_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_166_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_169_1 = 0
			local var_169_2 = 0.7

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[30].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_3 = arg_166_1:GetWordFromCfg(101021040)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_6 = 28 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_4) / 28)

				if (28 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_4) / 28)) > 0 and var_169_2 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021040", "story_v_out_101021.awb") ~= 0 then
					local var_169_7 = manager.audio:GetVoiceLength("story_v_out_101021", "101021040", "story_v_out_101021.awb") / 1000

					if var_169_7 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_1
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_101021", "101021040", "story_v_out_101021.awb")

						arg_166_1:RecordAudio("101021040", var_169_8)
						arg_166_1:RecordAudio("101021040", var_169_8)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_101021", "101021040", "story_v_out_101021.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_101021", "101021040", "story_v_out_101021.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_9 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_9 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_9

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_9 and arg_166_1.time_ < var_169_1 + var_169_9 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play101021041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 101021041
		arg_170_1.duration_ = 2.03

		local var_170_0 = {
			ja = 1.680999999999,
			ko = 1.680999999999,
			zh = 2.033,
			en = 1.680999999999
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play101021042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10001_tpose"]) and arg_170_1.var_.characterEffect10001_tpose == nil then
				arg_170_1.var_.characterEffect10001_tpose = arg_170_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.1

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10001_tpose"]) then
				if arg_170_1.var_.characterEffect10001_tpose and not isNil(arg_170_1.actors_["10001_tpose"]) then
					arg_170_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10001_tpose"]) and arg_170_1.var_.characterEffect10001_tpose then
				arg_170_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_2")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_173_2 = 0
			local var_173_3 = 0.175

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_4 = arg_170_1:GetWordFromCfg(101021041)
				local var_173_5 = arg_170_1:FormatText(var_173_4.content)

				arg_170_1.text_.text = var_173_5

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 7 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 7)

				if (7 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 7)) > 0 and var_173_3 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_5
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021041", "story_v_out_101021.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_101021", "101021041", "story_v_out_101021.awb") / 1000

					if var_173_8 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_2
					end

					if var_173_4.prefab_name ~= "" and arg_170_1.actors_[var_173_4.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_4.prefab_name].transform, "story_v_out_101021", "101021041", "story_v_out_101021.awb")

						arg_170_1:RecordAudio("101021041", var_173_9)
						arg_170_1:RecordAudio("101021041", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_101021", "101021041", "story_v_out_101021.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_101021", "101021041", "story_v_out_101021.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_10 and arg_170_1.time_ < var_173_2 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play101021042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 101021042
		arg_174_1.duration_ = 9.73

		local var_174_0 = {
			ja = 6.866,
			ko = 8.233,
			zh = 8.4,
			en = 9.733
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
				arg_174_0:Play101021043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_177_1 = arg_174_1.actors_["2044_tpose"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect2044_tpose == nil then
				arg_174_1.var_.characterEffect2044_tpose = var_177_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.1

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 and not isNil(var_177_1) then
				if arg_174_1.var_.characterEffect2044_tpose and not isNil(var_177_1) then
					arg_174_1.var_.characterEffect2044_tpose.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect2044_tpose then
				arg_174_1.var_.characterEffect2044_tpose.fillFlat = false
			end

			local var_177_4 = arg_174_1.actors_["10001_tpose"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect10001_tpose == nil then
				arg_174_1.var_.characterEffect10001_tpose = var_177_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_5 = 0.1

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_5 and not isNil(var_177_4) then
				if arg_174_1.var_.characterEffect10001_tpose and not isNil(var_177_4) then
					arg_174_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_174_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_5)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_5 and arg_174_1.time_ < 0 + var_177_5 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect10001_tpose then
				arg_174_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_174_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_177_6 = arg_174_1.actors_["10001_tpose"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10001_tpose = var_177_6.localPosition

				local var_177_7 = GameObjectTools.GetOrAddComponent(var_177_6.gameObject, typeof(DynamicBoneHelper))

				if var_177_7 then
					var_177_7:EnableDynamicBone(false)
				end
			end

			local var_177_8 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_8 then
				var_177_6.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_8)
				var_177_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_6.position).x, (manager.ui.mainCamera.transform.position - var_177_6.position).y, (manager.ui.mainCamera.transform.position - var_177_6.position).z)
				var_177_6.localEulerAngles.z = 0
				var_177_6.localEulerAngles.x = 0
				var_177_6.localEulerAngles = var_177_6.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_8 and arg_174_1.time_ < 0 + var_177_8 + arg_177_0 then
				var_177_6.localPosition = Vector3.New(0, 100, 0)
				var_177_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_6.position).x, (manager.ui.mainCamera.transform.position - var_177_6.position).y, (manager.ui.mainCamera.transform.position - var_177_6.position).z)
				var_177_6.localEulerAngles.z = 0
				var_177_6.localEulerAngles.x = 0
				var_177_6.localEulerAngles = var_177_6.localEulerAngles

				local var_177_9 = GameObjectTools.GetOrAddComponent(var_177_6.gameObject, typeof(DynamicBoneHelper))

				if var_177_9 then
					var_177_9:EnableDynamicBone(true)
				end
			end

			local var_177_10 = arg_174_1.actors_["2044_tpose"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos2044_tpose = var_177_10.localPosition

				local var_177_11 = GameObjectTools.GetOrAddComponent(var_177_10.gameObject, typeof(DynamicBoneHelper))

				if var_177_11 then
					var_177_11:EnableDynamicBone(false)
				end
			end

			local var_177_12 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_12 then
				var_177_10.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos2044_tpose, Vector3.New(0, -1.15, -2.3), (arg_174_1.time_ - 0) / var_177_12)
				var_177_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_10.position).x, (manager.ui.mainCamera.transform.position - var_177_10.position).y, (manager.ui.mainCamera.transform.position - var_177_10.position).z)
				var_177_10.localEulerAngles.z = 0
				var_177_10.localEulerAngles.x = 0
				var_177_10.localEulerAngles = var_177_10.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_12 and arg_174_1.time_ < 0 + var_177_12 + arg_177_0 then
				var_177_10.localPosition = Vector3.New(0, -1.15, -2.3)
				var_177_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_10.position).x, (manager.ui.mainCamera.transform.position - var_177_10.position).y, (manager.ui.mainCamera.transform.position - var_177_10.position).z)
				var_177_10.localEulerAngles.z = 0
				var_177_10.localEulerAngles.x = 0
				var_177_10.localEulerAngles = var_177_10.localEulerAngles

				local var_177_13 = GameObjectTools.GetOrAddComponent(var_177_10.gameObject, typeof(DynamicBoneHelper))

				if var_177_13 then
					var_177_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("2044_tpose", "StoryTimeline/CharAction/story2044/story2044action/2044action1_1")
			end

			local var_177_14 = 0
			local var_177_15 = 0.775

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_16 = arg_174_1:GetWordFromCfg(101021042)
				local var_177_17 = arg_174_1:FormatText(var_177_16.content)

				arg_174_1.text_.text = var_177_17

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_19 = 30 <= 0 and var_177_15 or var_177_15 * (utf8.len(var_177_17) / 30)

				if (30 <= 0 and var_177_15 or var_177_15 * (utf8.len(var_177_17) / 30)) > 0 and var_177_15 < var_177_19 then
					arg_174_1.talkMaxDuration = var_177_19

					if var_177_19 + var_177_14 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_19 + var_177_14
					end
				end

				arg_174_1.text_.text = var_177_17
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021042", "story_v_out_101021.awb") ~= 0 then
					local var_177_20 = manager.audio:GetVoiceLength("story_v_out_101021", "101021042", "story_v_out_101021.awb") / 1000

					if var_177_20 + var_177_14 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_20 + var_177_14
					end

					if var_177_16.prefab_name ~= "" and arg_174_1.actors_[var_177_16.prefab_name] ~= nil then
						local var_177_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_16.prefab_name].transform, "story_v_out_101021", "101021042", "story_v_out_101021.awb")

						arg_174_1:RecordAudio("101021042", var_177_21)
						arg_174_1:RecordAudio("101021042", var_177_21)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_101021", "101021042", "story_v_out_101021.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_101021", "101021042", "story_v_out_101021.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_22 = math.max(var_177_15, arg_174_1.talkMaxDuration)

			if var_177_14 <= arg_174_1.time_ and arg_174_1.time_ < var_177_14 + var_177_22 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_14) / var_177_22

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_14 + var_177_22 and arg_174_1.time_ < var_177_14 + var_177_22 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play101021043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 101021043
		arg_178_1.duration_ = 1

		local var_178_0 = {
			ja = 0.8,
			ko = 0.9,
			zh = 1,
			en = 0.833
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
				arg_178_0:Play101021044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["2044_tpose"]) and arg_178_1.var_.characterEffect2044_tpose == nil then
				arg_178_1.var_.characterEffect2044_tpose = arg_178_1.actors_["2044_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.1

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["2044_tpose"]) then
				if arg_178_1.var_.characterEffect2044_tpose and not isNil(arg_178_1.actors_["2044_tpose"]) then
					arg_178_1.var_.characterEffect2044_tpose.fillFlat = true
					arg_178_1.var_.characterEffect2044_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["2044_tpose"]) and arg_178_1.var_.characterEffect2044_tpose then
				arg_178_1.var_.characterEffect2044_tpose.fillFlat = true
				arg_178_1.var_.characterEffect2044_tpose.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 0.05

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[30].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:GetWordFromCfg(101021043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_6 = 2 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_4) / 2)

				if (2 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_4) / 2)) > 0 and var_181_2 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021043", "story_v_out_101021.awb") ~= 0 then
					local var_181_7 = manager.audio:GetVoiceLength("story_v_out_101021", "101021043", "story_v_out_101021.awb") / 1000

					if var_181_7 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_1
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_101021", "101021043", "story_v_out_101021.awb")

						arg_178_1:RecordAudio("101021043", var_181_8)
						arg_178_1:RecordAudio("101021043", var_181_8)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_101021", "101021043", "story_v_out_101021.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_101021", "101021043", "story_v_out_101021.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_9 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_9 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_9

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_9 and arg_178_1.time_ < var_181_1 + var_181_9 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play101021044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 101021044
		arg_182_1.duration_ = 2.87

		local var_182_0 = {
			ja = 2.866,
			ko = 1.466,
			zh = 2.2,
			en = 1.333
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play101021045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story", "se_story_robot_excited", "")
			end

			local var_185_1 = arg_182_1.actors_["2044_tpose"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect2044_tpose == nil then
				arg_182_1.var_.characterEffect2044_tpose = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.1

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect2044_tpose and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect2044_tpose.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect2044_tpose then
				arg_182_1.var_.characterEffect2044_tpose.fillFlat = false
			end

			local var_185_4 = 0

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.mask_.enabled = true
				arg_182_1.mask_.raycastTarget = true

				arg_182_1:SetGaussion(false)
			end

			local var_185_5 = 0.5

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_5 then
				local var_185_6 = Color.New(1, 1, 1)

				var_185_6.a = Mathf.Lerp(1, 0, (arg_182_1.time_ - var_185_4) / var_185_5)
				arg_182_1.mask_.color = var_185_6
			end

			if arg_182_1.time_ >= var_185_4 + var_185_5 and arg_182_1.time_ < var_185_4 + var_185_5 + arg_185_0 then
				local var_185_7 = Color.New(1, 1, 1)

				arg_182_1.mask_.enabled = false
				var_185_7.a = 0
				arg_182_1.mask_.color = var_185_7
			end

			local var_185_8 = manager.ui.mainCamera.transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.shakeOldPosMainCamera = var_185_8.localPosition
			end

			local var_185_9 = 0.600000023841858

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_9 then
				local var_185_10, var_185_11 = math.modf((arg_182_1.time_ - 0) / 0.066)

				var_185_8.localPosition = Vector3.New(var_185_11 * 0.13, var_185_11 * 0.13, var_185_11 * 0.13) + arg_182_1.var_.shakeOldPosMainCamera
			end

			if arg_182_1.time_ >= 0 + var_185_9 and arg_182_1.time_ < 0 + var_185_9 + arg_185_0 then
				var_185_8.localPosition = arg_182_1.var_.shakeOldPosMainCamera
			end

			local var_185_12 = 0
			local var_185_13 = 0.125

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_14 = arg_182_1:GetWordFromCfg(101021044)
				local var_185_15 = arg_182_1:FormatText(var_185_14.content)

				arg_182_1.text_.text = var_185_15

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_17 = 5 <= 0 and var_185_13 or var_185_13 * (utf8.len(var_185_15) / 5)

				if (5 <= 0 and var_185_13 or var_185_13 * (utf8.len(var_185_15) / 5)) > 0 and var_185_13 < var_185_17 then
					arg_182_1.talkMaxDuration = var_185_17

					if var_185_17 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_17 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_15
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021044", "story_v_out_101021.awb") ~= 0 then
					local var_185_18 = manager.audio:GetVoiceLength("story_v_out_101021", "101021044", "story_v_out_101021.awb") / 1000

					if var_185_18 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_18 + var_185_12
					end

					if var_185_14.prefab_name ~= "" and arg_182_1.actors_[var_185_14.prefab_name] ~= nil then
						local var_185_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_14.prefab_name].transform, "story_v_out_101021", "101021044", "story_v_out_101021.awb")

						arg_182_1:RecordAudio("101021044", var_185_19)
						arg_182_1:RecordAudio("101021044", var_185_19)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_101021", "101021044", "story_v_out_101021.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_101021", "101021044", "story_v_out_101021.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_20 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_20 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_12) / var_185_20

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_12 + var_185_20 and arg_182_1.time_ < var_185_12 + var_185_20 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play101021045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 101021045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play101021046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:AudioAction("play", "effect", "se_story_1", "se_story_1_apollo_bow", "")
			end

			local var_189_1 = arg_186_1.actors_["2044_tpose"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect2044_tpose == nil then
				arg_186_1.var_.characterEffect2044_tpose = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.1

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect2044_tpose and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect2044_tpose.fillFlat = true
					arg_186_1.var_.characterEffect2044_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_2)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect2044_tpose then
				arg_186_1.var_.characterEffect2044_tpose.fillFlat = true
				arg_186_1.var_.characterEffect2044_tpose.fillRatio = 0.5
			end

			local var_189_3 = 0

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_3 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_4 = 0.5

			if var_189_3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_3 + var_189_4 then
				local var_189_5 = Color.New(1, 1, 1)

				var_189_5.a = Mathf.Lerp(1, 0, (arg_186_1.time_ - var_189_3) / var_189_4)
				arg_186_1.mask_.color = var_189_5
			end

			if arg_186_1.time_ >= var_189_3 + var_189_4 and arg_186_1.time_ < var_189_3 + var_189_4 + arg_189_0 then
				local var_189_6 = Color.New(1, 1, 1)

				arg_186_1.mask_.enabled = false
				var_189_6.a = 0
				arg_186_1.mask_.color = var_189_6
			end

			local var_189_7 = arg_186_1.actors_["2044_tpose"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos2044_tpose = var_189_7.localPosition

				local var_189_8 = GameObjectTools.GetOrAddComponent(var_189_7.gameObject, typeof(DynamicBoneHelper))

				if var_189_8 then
					var_189_8:EnableDynamicBone(false)
				end
			end

			local var_189_9 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_9 then
				var_189_7.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos2044_tpose, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_9)
				var_189_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_7.position).x, (manager.ui.mainCamera.transform.position - var_189_7.position).y, (manager.ui.mainCamera.transform.position - var_189_7.position).z)
				var_189_7.localEulerAngles.z = 0
				var_189_7.localEulerAngles.x = 0
				var_189_7.localEulerAngles = var_189_7.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_9 and arg_186_1.time_ < 0 + var_189_9 + arg_189_0 then
				var_189_7.localPosition = Vector3.New(0, 100, 0)
				var_189_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_7.position).x, (manager.ui.mainCamera.transform.position - var_189_7.position).y, (manager.ui.mainCamera.transform.position - var_189_7.position).z)
				var_189_7.localEulerAngles.z = 0
				var_189_7.localEulerAngles.x = 0
				var_189_7.localEulerAngles = var_189_7.localEulerAngles

				local var_189_10 = GameObjectTools.GetOrAddComponent(var_189_7.gameObject, typeof(DynamicBoneHelper))

				if var_189_10 then
					var_189_10:EnableDynamicBone(true)
				end
			end

			local var_189_11 = manager.ui.mainCamera.transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.shakeOldPosMainCamera = var_189_11.localPosition
			end

			local var_189_12 = 0.300000011920929

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_12 then
				local var_189_13, var_189_14 = math.modf((arg_186_1.time_ - 0) / 0.066)

				var_189_11.localPosition = Vector3.New(var_189_14 * 0.13, var_189_14 * 0.13, var_189_14 * 0.13) + arg_186_1.var_.shakeOldPosMainCamera
			end

			if arg_186_1.time_ >= 0 + var_189_12 and arg_186_1.time_ < 0 + var_189_12 + arg_189_0 then
				var_189_11.localPosition = arg_186_1.var_.shakeOldPosMainCamera
			end

			local var_189_15 = 0
			local var_189_16 = 0.9

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_17 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_17:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_18 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(101021045).content)

				arg_186_1.text_.text = var_189_18

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_20 = 36 <= 0 and var_189_16 or var_189_16 * (utf8.len(var_189_18) / 36)

				if (36 <= 0 and var_189_16 or var_189_16 * (utf8.len(var_189_18) / 36)) > 0 and var_189_16 < var_189_20 then
					arg_186_1.talkMaxDuration = var_189_20
					var_189_15 = var_189_15 + 0.3

					if var_189_20 + var_189_15 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_20 + var_189_15
					end
				end

				arg_186_1.text_.text = var_189_18
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = var_189_15 + 0.3
			local var_189_22 = math.max(var_189_16, arg_186_1.talkMaxDuration)

			if var_189_15 + 0.3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_21 + var_189_22 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_21) / var_189_22

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_21 + var_189_22 and arg_186_1.time_ < var_189_21 + var_189_22 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2044_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play101021046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 101021046
		arg_192_1.duration_ = 9.37

		local var_192_0 = {
			ja = 7.733,
			ko = 9.366,
			zh = 7.6,
			en = 6.766
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
			arg_192_1.auto_ = false
		end

		function arg_192_1.playNext_(arg_194_0)
			arg_192_1.onStoryFinished_()
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1059ui_story"]) and arg_192_1.var_.characterEffect1059ui_story == nil then
				arg_192_1.var_.characterEffect1059ui_story = arg_192_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.1

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1059ui_story"]) then
				if arg_192_1.var_.characterEffect1059ui_story and not isNil(arg_192_1.actors_["1059ui_story"]) then
					arg_192_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1059ui_story"]) and arg_192_1.var_.characterEffect1059ui_story then
				arg_192_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_195_2 = arg_192_1.actors_["1059ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1059ui_story = var_195_2.localPosition
			end

			local var_195_3 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 then
				var_195_2.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_192_1.time_ - 0) / var_195_3)
				var_195_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_2.position).x, (manager.ui.mainCamera.transform.position - var_195_2.position).y, (manager.ui.mainCamera.transform.position - var_195_2.position).z)
				var_195_2.localEulerAngles.z = 0
				var_195_2.localEulerAngles.x = 0
				var_195_2.localEulerAngles = var_195_2.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 then
				var_195_2.localPosition = Vector3.New(0, -1.05, -6)
				var_195_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_2.position).x, (manager.ui.mainCamera.transform.position - var_195_2.position).y, (manager.ui.mainCamera.transform.position - var_195_2.position).z)
				var_195_2.localEulerAngles.z = 0
				var_195_2.localEulerAngles.x = 0
				var_195_2.localEulerAngles = var_195_2.localEulerAngles
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_195_4 = 0
			local var_195_5 = 0.9

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:GetWordFromCfg(101021046)
				local var_195_7 = arg_192_1:FormatText(var_195_6.content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 36 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 36)

				if (36 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 36)) > 0 and var_195_5 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101021", "101021046", "story_v_out_101021.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_out_101021", "101021046", "story_v_out_101021.awb") / 1000

					if var_195_10 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_4
					end

					if var_195_6.prefab_name ~= "" and arg_192_1.actors_[var_195_6.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_6.prefab_name].transform, "story_v_out_101021", "101021046", "story_v_out_101021.awb")

						arg_192_1:RecordAudio("101021046", var_195_11)
						arg_192_1:RecordAudio("101021046", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_101021", "101021046", "story_v_out_101021.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_101021", "101021046", "story_v_out_101021.awb")
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

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10a",
		"TextureConfig/Background/B10f"
	},
	voices = {
		"story_v_out_101021.awb"
	}
}
