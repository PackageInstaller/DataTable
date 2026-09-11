return {
	Play104062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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

			local var_4_3 = "B13"

			if arg_1_1.bgs_.B13 == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_4_5 then
					arg_1_1.var_.alphaOldValueB13 = var_4_5.color.a
					arg_1_1.var_.alphaMatValueB13 = var_4_5
				end

				arg_1_1.var_.alphaOldValueB13 = 0
			end

			local var_4_6 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 then
				if arg_1_1.var_.alphaMatValueB13 then
					arg_1_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13, 1, (arg_1_1.time_ - 0) / var_4_6)
					arg_1_1.var_.alphaMatValueB13.color = arg_1_1.var_.alphaMatValueB13.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and arg_1_1.var_.alphaMatValueB13 then
				arg_1_1.var_.alphaMatValueB13.color.a = 1
				arg_1_1.var_.alphaMatValueB13.color = arg_1_1.var_.alphaMatValueB13.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = 2 * (var_4_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_7.transform.localScale = Vector3.New(var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
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
			local var_4_12 = 0.275

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

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(104062001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 11 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 11)

				if (11 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 11)) > 0 and var_4_12 < var_4_16 then
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
	Play104062002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104062002
		arg_8_1.duration_ = 7.23

		local var_8_0 = {
			ja = 7.233,
			ko = 2.266,
			zh = 4.066,
			en = 3.166
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
				arg_8_0:Play104062003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(104062002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 14 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 14)

				if (14 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 14)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062002", "story_v_out_104062.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_104062", "104062002", "story_v_out_104062.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_104062", "104062002", "story_v_out_104062.awb")

						arg_8_1:RecordAudio("104062002", var_11_6)
						arg_8_1:RecordAudio("104062002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104062", "104062002", "story_v_out_104062.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104062", "104062002", "story_v_out_104062.awb")
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
	Play104062003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104062003
		arg_12_1.duration_ = 9.03

		local var_12_0 = {
			ja = 9.033,
			ko = 6.3,
			zh = 8.533,
			en = 8.8
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
				arg_12_0:Play104062004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.75

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:GetWordFromCfg(104062003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 29 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 29)

				if (29 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 29)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062003", "story_v_out_104062.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_104062", "104062003", "story_v_out_104062.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_104062", "104062003", "story_v_out_104062.awb")

						arg_12_1:RecordAudio("104062003", var_15_6)
						arg_12_1:RecordAudio("104062003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104062", "104062003", "story_v_out_104062.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104062", "104062003", "story_v_out_104062.awb")
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
	Play104062004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104062004
		arg_16_1.duration_ = 7.5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104062005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				local var_19_0 = arg_16_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_19_0 then
					arg_16_1.var_.alphaOldValueB13 = var_19_0.color.a
					arg_16_1.var_.alphaMatValueB13 = var_19_0
				end

				arg_16_1.var_.alphaOldValueB13 = 1
			end

			local var_19_1 = 1.5

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				if arg_16_1.var_.alphaMatValueB13 then
					arg_16_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_16_1.var_.alphaOldValueB13, 0, (arg_16_1.time_ - 0) / var_19_1)
					arg_16_1.var_.alphaMatValueB13.color = arg_16_1.var_.alphaMatValueB13.color
				end
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 and arg_16_1.var_.alphaMatValueB13 then
				arg_16_1.var_.alphaMatValueB13.color.a = 0
				arg_16_1.var_.alphaMatValueB13.color = arg_16_1.var_.alphaMatValueB13.color
			end

			local var_19_2 = arg_16_1.bgs_.B13.transform

			if 1.5 < arg_16_1.time_ and arg_16_1.time_ <= 1.5 + arg_19_0 then
				arg_16_1.var_.moveOldPosB13 = var_19_2.localPosition
			end

			local var_19_3 = 0.001

			if 1.5 <= arg_16_1.time_ and arg_16_1.time_ < 1.5 + var_19_3 then
				var_19_2.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPosB13, Vector3.New(0, -100, 10), (arg_16_1.time_ - 1.5) / var_19_3)
			end

			if arg_16_1.time_ >= 1.5 + var_19_3 and arg_16_1.time_ < 1.5 + var_19_3 + arg_19_0 then
				var_19_2.localPosition = Vector3.New(0, -100, 10)
			end

			local var_19_4 = "ST03a"

			if arg_16_1.bgs_.ST03a == nil then
				local var_19_5 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_4)
				var_19_5.name = var_19_4
				var_19_5.transform.parent = arg_16_1.stage_.transform
				var_19_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_4] = var_19_5
			end

			if 1.5 < arg_16_1.time_ and arg_16_1.time_ <= 1.5 + arg_19_0 then
				local var_19_6 = arg_16_1.bgs_.ST03a:GetComponent("SpriteRenderer")

				if var_19_6 then
					arg_16_1.var_.alphaOldValueST03a = var_19_6.color.a
					arg_16_1.var_.alphaMatValueST03a = var_19_6
				end

				arg_16_1.var_.alphaOldValueST03a = 0
			end

			local var_19_7 = 1.5

			if 1.5 <= arg_16_1.time_ and arg_16_1.time_ < 1.5 + var_19_7 then
				if arg_16_1.var_.alphaMatValueST03a then
					arg_16_1.var_.alphaMatValueST03a.color.a = Mathf.Lerp(arg_16_1.var_.alphaOldValueST03a, 1, (arg_16_1.time_ - 1.5) / var_19_7)
					arg_16_1.var_.alphaMatValueST03a.color = arg_16_1.var_.alphaMatValueST03a.color
				end
			end

			if arg_16_1.time_ >= 1.5 + var_19_7 and arg_16_1.time_ < 1.5 + var_19_7 + arg_19_0 and arg_16_1.var_.alphaMatValueST03a then
				arg_16_1.var_.alphaMatValueST03a.color.a = 1
				arg_16_1.var_.alphaMatValueST03a.color = arg_16_1.var_.alphaMatValueST03a.color
			end

			if 1.5 < arg_16_1.time_ and arg_16_1.time_ <= 1.5 + arg_19_0 then
				local var_19_8 = arg_16_1.bgs_.ST03a

				arg_16_1.bgs_.ST03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_9 = var_19_8:GetComponent("SpriteRenderer")

				if var_19_9 and var_19_9.sprite then
					local var_19_10 = 2 * (var_19_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_8.transform.localScale = Vector3.New(var_19_10 / var_19_9.sprite.bounds.size.y < var_19_10 * manager.ui.mainCameraCom_.aspect / var_19_9.sprite.bounds.size.x and var_19_10 * manager.ui.mainCameraCom_.aspect / var_19_9.sprite.bounds.size.x or var_19_10 / var_19_9.sprite.bounds.size.y, var_19_10 / var_19_9.sprite.bounds.size.y < var_19_10 * manager.ui.mainCameraCom_.aspect / var_19_9.sprite.bounds.size.x and var_19_10 * manager.ui.mainCameraCom_.aspect / var_19_9.sprite.bounds.size.x or var_19_10 / var_19_9.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "ST03a" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_11 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_11 + 1.5 and arg_16_1.time_ < var_19_11 + 1.5 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_12 = 2.5
			local var_19_13 = 0.45

			if 2.5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_14 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(104062004).content)

				arg_16_1.text_.text = var_19_14

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_16 = 18 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_14) / 18)

				if (18 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_14) / 18)) > 0 and var_19_13 < var_19_16 then
					arg_16_1.talkMaxDuration = var_19_16

					if var_19_16 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_14
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_17 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_17 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_17

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_17 and arg_16_1.time_ < var_19_12 + var_19_17 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104062005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104062005
		arg_20_1.duration_ = 10.53

		local var_20_0 = {
			ja = 10.533,
			ko = 6.833,
			zh = 9,
			en = 6.9
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
				arg_20_0:Play104062006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.875

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:GetWordFromCfg(104062005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 35 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 35)

				if (35 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 35)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062005", "story_v_out_104062.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_104062", "104062005", "story_v_out_104062.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_104062", "104062005", "story_v_out_104062.awb")

						arg_20_1:RecordAudio("104062005", var_23_6)
						arg_20_1:RecordAudio("104062005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104062", "104062005", "story_v_out_104062.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104062", "104062005", "story_v_out_104062.awb")
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
	Play104062006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104062006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play104062007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.6

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(104062006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 24 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 24)

				if (24 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 24)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play104062007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104062007
		arg_28_1.duration_ = 5.2

		local var_28_0 = {
			ja = 5.2,
			ko = 4.133,
			zh = 3.733,
			en = 3.866
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
				arg_28_0:Play104062008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_31_1 = "2070_tpose"

			if arg_28_1.actors_["2070_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2070_tpose"))) then
				local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "2070_tpose"), arg_28_1.stage_.transform)

				var_31_2.name = var_31_1
				var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_[var_31_1] = var_31_2

				local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

				var_31_3.enabled = true

				local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

				if var_31_4 then
					var_31_4:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_3.transform, false)

				arg_28_1.var_[var_31_1 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_[var_31_1 .. "Animator"].applyRootMotion = true
				arg_28_1.var_[var_31_1 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_5 = arg_28_1.actors_["2070_tpose"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect2070_tpose == nil then
				arg_28_1.var_.characterEffect2070_tpose = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.characterEffect2070_tpose and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect2070_tpose then
				arg_28_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_31_8 = 0
			local var_31_9 = 0.275

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[60].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(104062007)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 11 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 11)

				if (11 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 11)) > 0 and var_31_9 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062007", "story_v_out_104062.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_104062", "104062007", "story_v_out_104062.awb") / 1000

					if var_31_14 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_8
					end

					if var_31_10.prefab_name ~= "" and arg_28_1.actors_[var_31_10.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_10.prefab_name].transform, "story_v_out_104062", "104062007", "story_v_out_104062.awb")

						arg_28_1:RecordAudio("104062007", var_31_15)
						arg_28_1:RecordAudio("104062007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104062", "104062007", "story_v_out_104062.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104062", "104062007", "story_v_out_104062.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_16 and arg_28_1.time_ < var_31_8 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104062008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104062008
		arg_32_1.duration_ = 7

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play104062009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 2 < arg_32_1.time_ and arg_32_1.time_ <= 2 + arg_35_0 and not isNil(arg_32_1.actors_["2070_tpose"]) and arg_32_1.var_.characterEffect2070_tpose == nil then
				arg_32_1.var_.characterEffect2070_tpose = arg_32_1.actors_["2070_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 2 <= arg_32_1.time_ and arg_32_1.time_ < 2 + var_35_0 and not isNil(arg_32_1.actors_["2070_tpose"]) then
				if arg_32_1.var_.characterEffect2070_tpose and not isNil(arg_32_1.actors_["2070_tpose"]) then
					arg_32_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_32_1.var_.characterEffect2070_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 2) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 2 + var_35_0 and arg_32_1.time_ < 2 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["2070_tpose"]) and arg_32_1.var_.characterEffect2070_tpose then
				arg_32_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_32_1.var_.characterEffect2070_tpose.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				local var_35_1 = arg_32_1.bgs_.ST03a:GetComponent("SpriteRenderer")

				if var_35_1 then
					arg_32_1.var_.alphaOldValueST03a = var_35_1.color.a
					arg_32_1.var_.alphaMatValueST03a = var_35_1
				end

				arg_32_1.var_.alphaOldValueST03a = 1
			end

			local var_35_2 = 1.5

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 then
				if arg_32_1.var_.alphaMatValueST03a then
					arg_32_1.var_.alphaMatValueST03a.color.a = Mathf.Lerp(arg_32_1.var_.alphaOldValueST03a, 0, (arg_32_1.time_ - 0) / var_35_2)
					arg_32_1.var_.alphaMatValueST03a.color = arg_32_1.var_.alphaMatValueST03a.color
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and arg_32_1.var_.alphaMatValueST03a then
				arg_32_1.var_.alphaMatValueST03a.color.a = 0
				arg_32_1.var_.alphaMatValueST03a.color = arg_32_1.var_.alphaMatValueST03a.color
			end

			local var_35_3 = arg_32_1.bgs_.ST03a.transform

			if 1.5 < arg_32_1.time_ and arg_32_1.time_ <= 1.5 + arg_35_0 then
				arg_32_1.var_.moveOldPosST03a = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 1.5 <= arg_32_1.time_ and arg_32_1.time_ < 1.5 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPosST03a, Vector3.New(0, -100, 10), (arg_32_1.time_ - 1.5) / var_35_4)
			end

			if arg_32_1.time_ >= 1.5 + var_35_4 and arg_32_1.time_ < 1.5 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0, -100, 10)
			end

			if 1.5 < arg_32_1.time_ and arg_32_1.time_ <= 1.5 + arg_35_0 then
				local var_35_5 = arg_32_1.bgs_.B13:GetComponent("SpriteRenderer")

				if var_35_5 then
					arg_32_1.var_.alphaOldValueB13 = var_35_5.color.a
					arg_32_1.var_.alphaMatValueB13 = var_35_5
				end

				arg_32_1.var_.alphaOldValueB13 = 0
			end

			local var_35_6 = 1.5

			if 1.5 <= arg_32_1.time_ and arg_32_1.time_ < 1.5 + var_35_6 then
				if arg_32_1.var_.alphaMatValueB13 then
					arg_32_1.var_.alphaMatValueB13.color.a = Mathf.Lerp(arg_32_1.var_.alphaOldValueB13, 1, (arg_32_1.time_ - 1.5) / var_35_6)
					arg_32_1.var_.alphaMatValueB13.color = arg_32_1.var_.alphaMatValueB13.color
				end
			end

			if arg_32_1.time_ >= 1.5 + var_35_6 and arg_32_1.time_ < 1.5 + var_35_6 + arg_35_0 and arg_32_1.var_.alphaMatValueB13 then
				arg_32_1.var_.alphaMatValueB13.color.a = 1
				arg_32_1.var_.alphaMatValueB13.color = arg_32_1.var_.alphaMatValueB13.color
			end

			if 1.5 < arg_32_1.time_ and arg_32_1.time_ <= 1.5 + arg_35_0 then
				local var_35_7 = arg_32_1.bgs_.B13

				arg_32_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_8 = var_35_7:GetComponent("SpriteRenderer")

				if var_35_8 and var_35_8.sprite then
					local var_35_9 = 2 * (var_35_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_7.transform.localScale = Vector3.New(var_35_9 / var_35_8.sprite.bounds.size.y < var_35_9 * manager.ui.mainCameraCom_.aspect / var_35_8.sprite.bounds.size.x and var_35_9 * manager.ui.mainCameraCom_.aspect / var_35_8.sprite.bounds.size.x or var_35_9 / var_35_8.sprite.bounds.size.y, var_35_9 / var_35_8.sprite.bounds.size.y < var_35_9 * manager.ui.mainCameraCom_.aspect / var_35_8.sprite.bounds.size.x and var_35_9 * manager.ui.mainCameraCom_.aspect / var_35_8.sprite.bounds.size.x or var_35_9 / var_35_8.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "B13" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_10 = arg_32_1.actors_["2070_tpose"].transform

			if 1.79999995231628 < arg_32_1.time_ and arg_32_1.time_ <= 1.79999995231628 + arg_35_0 then
				arg_32_1.var_.moveOldPos2070_tpose = var_35_10.localPosition

				local var_35_11 = GameObjectTools.GetOrAddComponent(var_35_10.gameObject, typeof(DynamicBoneHelper))

				if var_35_11 then
					var_35_11:EnableDynamicBone(false)
				end
			end

			local var_35_12 = 0.001

			if 1.79999995231628 <= arg_32_1.time_ and arg_32_1.time_ < 1.79999995231628 + var_35_12 then
				var_35_10.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos2070_tpose, Vector3.New(0, -0.49, -3.1), (arg_32_1.time_ - 1.79999995231628) / var_35_12)
				var_35_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_10.position).x, (manager.ui.mainCamera.transform.position - var_35_10.position).y, (manager.ui.mainCamera.transform.position - var_35_10.position).z)
				var_35_10.localEulerAngles.z = 0
				var_35_10.localEulerAngles.x = 0
				var_35_10.localEulerAngles = var_35_10.localEulerAngles
			end

			if arg_32_1.time_ >= 1.79999995231628 + var_35_12 and arg_32_1.time_ < 1.79999995231628 + var_35_12 + arg_35_0 then
				var_35_10.localPosition = Vector3.New(0, -0.49, -3.1)
				var_35_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_10.position).x, (manager.ui.mainCamera.transform.position - var_35_10.position).y, (manager.ui.mainCamera.transform.position - var_35_10.position).z)
				var_35_10.localEulerAngles.z = 0
				var_35_10.localEulerAngles.x = 0
				var_35_10.localEulerAngles = var_35_10.localEulerAngles

				local var_35_13 = GameObjectTools.GetOrAddComponent(var_35_10.gameObject, typeof(DynamicBoneHelper))

				if var_35_13 then
					var_35_13:EnableDynamicBone(true)
				end
			end

			local var_35_14 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= var_35_14 + 2 and arg_32_1.time_ < var_35_14 + 2 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_15 = 2
			local var_35_16 = 0.7

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_17 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_17:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(104062008).content)

				arg_32_1.text_.text = var_35_18

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 28 <= 0 and var_35_16 or var_35_16 * (utf8.len(var_35_18) / 28)

				if (28 <= 0 and var_35_16 or var_35_16 * (utf8.len(var_35_18) / 28)) > 0 and var_35_16 < var_35_20 then
					arg_32_1.talkMaxDuration = var_35_20
					var_35_15 = var_35_15 + 0.3

					if var_35_20 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_18
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_21 = var_35_15 + 0.3
			local var_35_22 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_21) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play104062009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 104062009
		arg_38_1.duration_ = 6.87

		local var_38_0 = {
			ja = 6.866,
			ko = 6.266,
			zh = 4.4,
			en = 4.7
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play104062010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_41_1 = arg_38_1.actors_["2070_tpose"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect2070_tpose == nil then
				arg_38_1.var_.characterEffect2070_tpose = var_41_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.1

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_2 and not isNil(var_41_1) then
				if arg_38_1.var_.characterEffect2070_tpose and not isNil(var_41_1) then
					arg_38_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_2 and arg_38_1.time_ < 0 + var_41_2 + arg_41_0 and not isNil(var_41_1) and arg_38_1.var_.characterEffect2070_tpose then
				arg_38_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_41_4 = 0
			local var_41_5 = 0.325

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[60].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(104062009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 13 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 13)

				if (13 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 13)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062009", "story_v_out_104062.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_104062", "104062009", "story_v_out_104062.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_104062", "104062009", "story_v_out_104062.awb")

						arg_38_1:RecordAudio("104062009", var_41_11)
						arg_38_1:RecordAudio("104062009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_104062", "104062009", "story_v_out_104062.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_104062", "104062009", "story_v_out_104062.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_12 and arg_38_1.time_ < var_41_4 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play104062010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 104062010
		arg_42_1.duration_ = 1.6

		local var_42_0 = {
			ja = 1.466,
			ko = 1.3,
			zh = 1.2,
			en = 1.6
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play104062011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["2070_tpose"]) and arg_42_1.var_.characterEffect2070_tpose == nil then
				arg_42_1.var_.characterEffect2070_tpose = arg_42_1.actors_["2070_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.1

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["2070_tpose"]) then
				if arg_42_1.var_.characterEffect2070_tpose and not isNil(arg_42_1.actors_["2070_tpose"]) then
					arg_42_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_42_1.var_.characterEffect2070_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["2070_tpose"]) and arg_42_1.var_.characterEffect2070_tpose then
				arg_42_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_42_1.var_.characterEffect2070_tpose.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 0.125

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_3 = arg_42_1:GetWordFromCfg(104062010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_6 = 5 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_4) / 5)

				if (5 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_4) / 5)) > 0 and var_45_2 < var_45_6 then
					arg_42_1.talkMaxDuration = var_45_6

					if var_45_6 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_6 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062010", "story_v_out_104062.awb") ~= 0 then
					local var_45_7 = manager.audio:GetVoiceLength("story_v_out_104062", "104062010", "story_v_out_104062.awb") / 1000

					if var_45_7 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_1
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_out_104062", "104062010", "story_v_out_104062.awb")

						arg_42_1:RecordAudio("104062010", var_45_8)
						arg_42_1:RecordAudio("104062010", var_45_8)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_104062", "104062010", "story_v_out_104062.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_104062", "104062010", "story_v_out_104062.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_9 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_9 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_9

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_9 and arg_42_1.time_ < var_45_1 + var_45_9 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play104062011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 104062011
		arg_46_1.duration_ = 3.57

		local var_46_0 = {
			ja = 1.766,
			ko = 2.566,
			zh = 3.166,
			en = 3.566
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play104062012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["2070_tpose"]) and arg_46_1.var_.characterEffect2070_tpose == nil then
				arg_46_1.var_.characterEffect2070_tpose = arg_46_1.actors_["2070_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.1

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["2070_tpose"]) then
				if arg_46_1.var_.characterEffect2070_tpose and not isNil(arg_46_1.actors_["2070_tpose"]) then
					arg_46_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["2070_tpose"]) and arg_46_1.var_.characterEffect2070_tpose then
				arg_46_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_49_2 = 0
			local var_49_3 = 0.15

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[60].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(104062011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 6 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 6)

				if (6 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 6)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062011", "story_v_out_104062.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_104062", "104062011", "story_v_out_104062.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_104062", "104062011", "story_v_out_104062.awb")

						arg_46_1:RecordAudio("104062011", var_49_9)
						arg_46_1:RecordAudio("104062011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_104062", "104062011", "story_v_out_104062.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_104062", "104062011", "story_v_out_104062.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_10 and arg_46_1.time_ < var_49_2 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play104062012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 104062012
		arg_50_1.duration_ = 8.2

		local var_50_0 = {
			ja = 8.2,
			ko = 4.933,
			zh = 5.766,
			en = 5.733
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play104062013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["2070_tpose"]) and arg_50_1.var_.characterEffect2070_tpose == nil then
				arg_50_1.var_.characterEffect2070_tpose = arg_50_1.actors_["2070_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["2070_tpose"]) then
				if arg_50_1.var_.characterEffect2070_tpose and not isNil(arg_50_1.actors_["2070_tpose"]) then
					arg_50_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_50_1.var_.characterEffect2070_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["2070_tpose"]) and arg_50_1.var_.characterEffect2070_tpose then
				arg_50_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_50_1.var_.characterEffect2070_tpose.fillRatio = 0.5
			end

			local var_53_1 = 0
			local var_53_2 = 0.775

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_3 = arg_50_1:GetWordFromCfg(104062012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_6 = 31 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_4) / 31)

				if (31 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_4) / 31)) > 0 and var_53_2 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_1
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062012", "story_v_out_104062.awb") ~= 0 then
					local var_53_7 = manager.audio:GetVoiceLength("story_v_out_104062", "104062012", "story_v_out_104062.awb") / 1000

					if var_53_7 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_1
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_104062", "104062012", "story_v_out_104062.awb")

						arg_50_1:RecordAudio("104062012", var_53_8)
						arg_50_1:RecordAudio("104062012", var_53_8)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_104062", "104062012", "story_v_out_104062.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_104062", "104062012", "story_v_out_104062.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_9 = math.max(var_53_2, arg_50_1.talkMaxDuration)

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_9 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_1) / var_53_9

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_1 + var_53_9 and arg_50_1.time_ < var_53_1 + var_53_9 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play104062013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 104062013
		arg_54_1.duration_ = 8.77

		local var_54_0 = {
			ja = 8.766,
			ko = 5.9,
			zh = 6,
			en = 6.1
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play104062014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_57_1 = arg_54_1.actors_["2070_tpose"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect2070_tpose == nil then
				arg_54_1.var_.characterEffect2070_tpose = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect2070_tpose and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect2070_tpose then
				arg_54_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_57_4 = 0
			local var_57_5 = 0.45

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[60].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(104062013)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 18 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 18)

				if (18 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 18)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062013", "story_v_out_104062.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_104062", "104062013", "story_v_out_104062.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_out_104062", "104062013", "story_v_out_104062.awb")

						arg_54_1:RecordAudio("104062013", var_57_11)
						arg_54_1:RecordAudio("104062013", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_104062", "104062013", "story_v_out_104062.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_104062", "104062013", "story_v_out_104062.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play104062014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 104062014
		arg_58_1.duration_ = 0.97

		local var_58_0 = {
			ja = 0.733,
			ko = 0.933,
			zh = 0.966,
			en = 0.7
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
				arg_58_0:Play104062015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["2070_tpose"]) and arg_58_1.var_.characterEffect2070_tpose == nil then
				arg_58_1.var_.characterEffect2070_tpose = arg_58_1.actors_["2070_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.1

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["2070_tpose"]) then
				if arg_58_1.var_.characterEffect2070_tpose and not isNil(arg_58_1.actors_["2070_tpose"]) then
					arg_58_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_58_1.var_.characterEffect2070_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["2070_tpose"]) and arg_58_1.var_.characterEffect2070_tpose then
				arg_58_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_58_1.var_.characterEffect2070_tpose.fillRatio = 0.5
			end

			local var_61_1 = 0
			local var_61_2 = 0.05

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(104062014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_6 = 2 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_4) / 2)

				if (2 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_4) / 2)) > 0 and var_61_2 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062014", "story_v_out_104062.awb") ~= 0 then
					local var_61_7 = manager.audio:GetVoiceLength("story_v_out_104062", "104062014", "story_v_out_104062.awb") / 1000

					if var_61_7 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_1
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_104062", "104062014", "story_v_out_104062.awb")

						arg_58_1:RecordAudio("104062014", var_61_8)
						arg_58_1:RecordAudio("104062014", var_61_8)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_104062", "104062014", "story_v_out_104062.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_104062", "104062014", "story_v_out_104062.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_9 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_9 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_9

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_9 and arg_58_1.time_ < var_61_1 + var_61_9 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play104062015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104062015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play104062016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos2070_tpose = arg_62_1.actors_["2070_tpose"].transform.localPosition

				local var_65_0 = GameObjectTools.GetOrAddComponent(arg_62_1.actors_["2070_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_65_0 then
					var_65_0:EnableDynamicBone(false)
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["2070_tpose"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos2070_tpose, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_1)
				arg_62_1.actors_["2070_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["2070_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["2070_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["2070_tpose"].transform.position).z)
				arg_62_1.actors_["2070_tpose"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["2070_tpose"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["2070_tpose"].transform.localEulerAngles = arg_62_1.actors_["2070_tpose"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["2070_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["2070_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["2070_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["2070_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["2070_tpose"].transform.position).z)
				arg_62_1.actors_["2070_tpose"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["2070_tpose"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["2070_tpose"].transform.localEulerAngles = arg_62_1.actors_["2070_tpose"].transform.localEulerAngles

				local var_65_2 = GameObjectTools.GetOrAddComponent(arg_62_1.actors_["2070_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(true)
				end
			end

			local var_65_3 = 0
			local var_65_4 = 0.925

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_3 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_5 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(104062015).content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 37 <= 0 and var_65_4 or var_65_4 * (utf8.len(var_65_5) / 37)

				if (37 <= 0 and var_65_4 or var_65_4 * (utf8.len(var_65_5) / 37)) > 0 and var_65_4 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_3 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_3
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_8 = math.max(var_65_4, arg_62_1.talkMaxDuration)

			if var_65_3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_3 + var_65_8 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_3) / var_65_8

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_3 + var_65_8 and arg_62_1.time_ < var_65_3 + var_65_8 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
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
	Play104062016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104062016
		arg_66_1.duration_ = 5.77

		local var_66_0 = {
			ja = 5.766,
			ko = 2.666,
			zh = 2.666,
			en = 4.266
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
				arg_66_0:Play104062017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.3

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(104062016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 10 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 10)

				if (10 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 10)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062016", "story_v_out_104062.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_104062", "104062016", "story_v_out_104062.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_104062", "104062016", "story_v_out_104062.awb")

						arg_66_1:RecordAudio("104062016", var_69_6)
						arg_66_1:RecordAudio("104062016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_104062", "104062016", "story_v_out_104062.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_104062", "104062016", "story_v_out_104062.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104062017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104062017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play104062018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.875

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(104062017).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 35 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 35)

				if (35 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 35)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104062018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104062018
		arg_74_1.duration_ = 4.9

		local var_74_0 = {
			ja = 4.9,
			ko = 2.3,
			zh = 3.1,
			en = 3.066
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
				arg_74_0:Play104062019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.4

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:GetWordFromCfg(104062018)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 16 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 16)

				if (16 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 16)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062018", "story_v_out_104062.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_104062", "104062018", "story_v_out_104062.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_104062", "104062018", "story_v_out_104062.awb")

						arg_74_1:RecordAudio("104062018", var_77_6)
						arg_74_1:RecordAudio("104062018", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104062", "104062018", "story_v_out_104062.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104062", "104062018", "story_v_out_104062.awb")
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
	Play104062019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104062019
		arg_78_1.duration_ = 6.67

		local var_78_0 = {
			ja = 6.666,
			ko = 4.566,
			zh = 4.7,
			en = 4.6
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
				arg_78_0:Play104062020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_81_1 = arg_78_1.actors_["2070_tpose"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos2070_tpose = var_81_1.localPosition

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_1.gameObject, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end
			end

			local var_81_3 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 then
				var_81_1.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos2070_tpose, Vector3.New(0, -0.49, -3.1), (arg_78_1.time_ - 0) / var_81_3)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 then
				var_81_1.localPosition = Vector3.New(0, -0.49, -3.1)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles

				local var_81_4 = GameObjectTools.GetOrAddComponent(var_81_1.gameObject, typeof(DynamicBoneHelper))

				if var_81_4 then
					var_81_4:EnableDynamicBone(true)
				end
			end

			local var_81_5 = arg_78_1.actors_["2070_tpose"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect2070_tpose == nil then
				arg_78_1.var_.characterEffect2070_tpose = var_81_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_6 and not isNil(var_81_5) then
				if arg_78_1.var_.characterEffect2070_tpose and not isNil(var_81_5) then
					arg_78_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_6 and arg_78_1.time_ < 0 + var_81_6 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect2070_tpose then
				arg_78_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_81_8 = 0
			local var_81_9 = 0.25

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[60].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_10 = arg_78_1:GetWordFromCfg(104062019)
				local var_81_11 = arg_78_1:FormatText(var_81_10.content)

				arg_78_1.text_.text = var_81_11

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 10 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 10)

				if (10 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 10)) > 0 and var_81_9 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_8
					end
				end

				arg_78_1.text_.text = var_81_11
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062019", "story_v_out_104062.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_104062", "104062019", "story_v_out_104062.awb") / 1000

					if var_81_14 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_8
					end

					if var_81_10.prefab_name ~= "" and arg_78_1.actors_[var_81_10.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_10.prefab_name].transform, "story_v_out_104062", "104062019", "story_v_out_104062.awb")

						arg_78_1:RecordAudio("104062019", var_81_15)
						arg_78_1:RecordAudio("104062019", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_104062", "104062019", "story_v_out_104062.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_104062", "104062019", "story_v_out_104062.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_9, arg_78_1.talkMaxDuration)

			if var_81_8 <= arg_78_1.time_ and arg_78_1.time_ < var_81_8 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_8) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_8 + var_81_16 and arg_78_1.time_ < var_81_8 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play104062020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104062020
		arg_82_1.duration_ = 5.53

		local var_82_0 = {
			ja = 5.533,
			ko = 2.6,
			zh = 3.8,
			en = 3.6
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
				arg_82_0:Play104062021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["2070_tpose"]) and arg_82_1.var_.characterEffect2070_tpose == nil then
				arg_82_1.var_.characterEffect2070_tpose = arg_82_1.actors_["2070_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["2070_tpose"]) then
				if arg_82_1.var_.characterEffect2070_tpose and not isNil(arg_82_1.actors_["2070_tpose"]) then
					arg_82_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_82_1.var_.characterEffect2070_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["2070_tpose"]) and arg_82_1.var_.characterEffect2070_tpose then
				arg_82_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_82_1.var_.characterEffect2070_tpose.fillRatio = 0.5
			end

			local var_85_1 = 0
			local var_85_2 = 0.3

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(104062020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_6 = 12 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_4) / 12)

				if (12 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_4) / 12)) > 0 and var_85_2 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062020", "story_v_out_104062.awb") ~= 0 then
					local var_85_7 = manager.audio:GetVoiceLength("story_v_out_104062", "104062020", "story_v_out_104062.awb") / 1000

					if var_85_7 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_1
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_104062", "104062020", "story_v_out_104062.awb")

						arg_82_1:RecordAudio("104062020", var_85_8)
						arg_82_1:RecordAudio("104062020", var_85_8)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104062", "104062020", "story_v_out_104062.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104062", "104062020", "story_v_out_104062.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_9 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_9 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_9

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_9 and arg_82_1.time_ < var_85_1 + var_85_9 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play104062021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 104062021
		arg_86_1.duration_ = 7.5

		local var_86_0 = {
			ja = 4.6,
			ko = 5.066,
			zh = 7.5,
			en = 7.333
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
				arg_86_0:Play104062022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:AudioAction("play", "effect", "se_story", "se_story_robot_excited", "")
			end

			local var_89_1 = arg_86_1.actors_["2070_tpose"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect2070_tpose == nil then
				arg_86_1.var_.characterEffect2070_tpose = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect2070_tpose and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect2070_tpose then
				arg_86_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_89_4 = 0
			local var_89_5 = 0.475

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[60].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(104062021)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 19 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 19)

				if (19 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 19)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062021", "story_v_out_104062.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_out_104062", "104062021", "story_v_out_104062.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_out_104062", "104062021", "story_v_out_104062.awb")

						arg_86_1:RecordAudio("104062021", var_89_11)
						arg_86_1:RecordAudio("104062021", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_104062", "104062021", "story_v_out_104062.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_104062", "104062021", "story_v_out_104062.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play104062022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 104062022
		arg_90_1.duration_ = 7.4

		local var_90_0 = {
			ja = 2.8,
			ko = 3.166,
			zh = 4.6,
			en = 7.4
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
			arg_90_1.auto_ = false
		end

		function arg_90_1.playNext_(arg_92_0)
			arg_90_1.onStoryFinished_()
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.mask_.enabled = true
				arg_90_1.mask_.raycastTarget = true

				arg_90_1:SetGaussion(false)
			end

			local var_93_0 = 0.5

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 then
				local var_93_1 = Color.New(1, 1, 1)

				var_93_1.a = Mathf.Lerp(1, 0, (arg_90_1.time_ - 0) / var_93_0)
				arg_90_1.mask_.color = var_93_1
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 then
				local var_93_2 = Color.New(1, 1, 1)

				arg_90_1.mask_.enabled = false
				var_93_2.a = 0
				arg_90_1.mask_.color = var_93_2
			end

			local var_93_3 = manager.ui.mainCamera.transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.shakeOldPosMainCamera = var_93_3.localPosition
			end

			local var_93_4 = 0.600000023841858

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				local var_93_5, var_93_6 = math.modf((arg_90_1.time_ - 0) / 0.066)

				var_93_3.localPosition = Vector3.New(var_93_6 * 0.13, var_93_6 * 0.13, var_93_6 * 0.13) + arg_90_1.var_.shakeOldPosMainCamera
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_3.localPosition = arg_90_1.var_.shakeOldPosMainCamera
			end

			local var_93_7 = arg_90_1.actors_["2070_tpose"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_7) and arg_90_1.var_.characterEffect2070_tpose == nil then
				arg_90_1.var_.characterEffect2070_tpose = var_93_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_8 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_8 and not isNil(var_93_7) then
				if arg_90_1.var_.characterEffect2070_tpose and not isNil(var_93_7) then
					arg_90_1.var_.characterEffect2070_tpose.fillFlat = true
					arg_90_1.var_.characterEffect2070_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_8)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_8 and arg_90_1.time_ < 0 + var_93_8 + arg_93_0 and not isNil(var_93_7) and arg_90_1.var_.characterEffect2070_tpose then
				arg_90_1.var_.characterEffect2070_tpose.fillFlat = true
				arg_90_1.var_.characterEffect2070_tpose.fillRatio = 0.5
			end

			local var_93_9 = 0
			local var_93_10 = 0.45

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[59].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_11 = arg_90_1:GetWordFromCfg(104062022)
				local var_93_12 = arg_90_1:FormatText(var_93_11.content)

				arg_90_1.text_.text = var_93_12

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_14 = 18 <= 0 and var_93_10 or var_93_10 * (utf8.len(var_93_12) / 18)

				if (18 <= 0 and var_93_10 or var_93_10 * (utf8.len(var_93_12) / 18)) > 0 and var_93_10 < var_93_14 then
					arg_90_1.talkMaxDuration = var_93_14

					if var_93_14 + var_93_9 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_9
					end
				end

				arg_90_1.text_.text = var_93_12
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104062", "104062022", "story_v_out_104062.awb") ~= 0 then
					local var_93_15 = manager.audio:GetVoiceLength("story_v_out_104062", "104062022", "story_v_out_104062.awb") / 1000

					if var_93_15 + var_93_9 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_15 + var_93_9
					end

					if var_93_11.prefab_name ~= "" and arg_90_1.actors_[var_93_11.prefab_name] ~= nil then
						local var_93_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_11.prefab_name].transform, "story_v_out_104062", "104062022", "story_v_out_104062.awb")

						arg_90_1:RecordAudio("104062022", var_93_16)
						arg_90_1:RecordAudio("104062022", var_93_16)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_104062", "104062022", "story_v_out_104062.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_104062", "104062022", "story_v_out_104062.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_17 = math.max(var_93_10, arg_90_1.talkMaxDuration)

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_17 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_9) / var_93_17

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_9 + var_93_17 and arg_90_1.time_ < var_93_9 + var_93_17 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST03a"
	},
	voices = {
		"story_v_out_104062.awb"
	}
}
